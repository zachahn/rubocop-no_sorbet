# typed: true

# to run with real Sorbet:
#   ruby -rsorbet-runtime scratch.rb
#
# to run with emulation:
#   ruby scratch.rb

def assert(arg)
  raise "expected arg to be truthy" unless arg
end

def assert_raises(klass, &block)
  raised_correct = false
  begin
    block.call
  rescue klass => e
    if ENV["INSPECT"]
      print "Received expected error: "
      pp e
    end
    raised_correct = true
  end
  assert(raised_correct)
end

if !defined?(T::Struct)
  eval DATA.read
end

class Suit < T::Enum
  enums do
    Spades = new
    HeaRts = new
    Clubs = new
    Diamonds = new
  end
end

binding.irb if ENV["INSPECT"]

assert(Suit.values.count == 4)
assert(Suit.values.include?(Suit::Spades))
assert(Suit.values.include?(Suit::HeaRts))
assert(Suit.values.include?(Suit::Clubs))
assert(Suit.values.include?(Suit::Diamonds))

assert(Suit::Spades.serialize == "spades")
assert(Suit::HeaRts.serialize == "hearts")
assert(Suit::Clubs.serialize == "clubs")
assert(Suit::Diamonds.serialize == "diamonds")

assert(Suit::Diamonds.inspect == "#<Suit::Diamonds>")
assert(Suit::Diamonds.to_s == "#<Suit::Diamonds>")

assert(Suit.deserialize("spades") == Suit::Spades)
assert(Suit.deserialize("hearts") == Suit::HeaRts)
assert(Suit.deserialize("clubs") == Suit::Clubs)
assert(Suit.deserialize("diamonds") == Suit::Diamonds)
assert_raises(KeyError) { Suit.deserialize("DIAMONDS") == Suit::Diamonds }

def describe_suit_color(suit)
  case suit
  when Suit::Spades   then true
  when Suit::HeaRts   then true
  else T.absurd(suit)
  end
end

assert_raises(TypeError) { describe_suit_color(Suit::Diamonds) }

__END__
module T
  def self.absurd(thing)
    raise TypeError, "T.absurd: #{thing}"
  end
end

class T::Enum
  def self.enums
    yield if block_given?
  end

  def self.values
    @values ||= []
  end

  def self.const_added(name)
    # Finish instantiating the enum
    const = const_get(name)
    const.instance_variable_set(:@name, name)
    values.push(const)

    # Setup deserialization
    @mapping ||= {}
    @mapping[const.serialize] = const
  end

  def self.deserialize(serialized)
    @mapping ||= {}
    @mapping.fetch(serialized)
  end

  def serialize
    @name.to_s.downcase
  end

  def inspect
    "#<#{self.class}::#{@name}>"
  end

  def to_s
    inspect
  end
end
