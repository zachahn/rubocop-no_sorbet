# frozen_string_literal: true

RSpec.describe RuboCop::Cop::NoSorbet::NoExtendTSig, :config do
  let(:message) { RuboCop::Cop::NoSorbet::NoExtendTSig::MSG }

  shared_examples "wrapped `extend T::Sig`" do |open, close|
    it "registers a correctable offense when `extend T::Sig` is wrapped within `#{open}`" do
      expect_offense(<<~RUBY)
        #{open}
          extend T::Sig
          ^^^^^^^^^^^^^ #{message}
        #{close}
      RUBY

      expect_correction(<<~RUBY)
        #{open}
          
        #{close}
      RUBY
    end
  end

  include_examples "wrapped `extend T::Sig`", "class Foo", "end"
  include_examples "wrapped `extend T::Sig`", "module Foo", "end"
  include_examples "wrapped `extend T::Sig`", "class Foo ; class << self", "end; end"
  include_examples "wrapped `extend T::Sig`", "module Foo ; class << self", "end; end"
  include_examples "wrapped `extend T::Sig`", "", ""

  it "registers a correctable offence when `extend T::Sig` is called on an object" do
    expect_offense(<<~RUBY)
      foo.extend T::Sig
      ^^^^^^^^^^^^^^^^^ #{message}
    RUBY

    expect_correction("\n")
  end
end
