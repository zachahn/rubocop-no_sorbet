# frozen_string_literal: true

RSpec.describe RuboCop::Cop::NoSorbet::NoTEnum, :config do
  let(:message) { described_class::MSG }

  it "registers an offense when inheriting from `T::Enum`" do
    expect_offense(<<~RUBY)
      class Suit < T::Enum
      ^^^^^^^^^^^^^^^^^^^^ #{message}
        enums do
          Spades = new
          Hearts = new
          Clubs = new
          Diamonds = new
        end
      end
    RUBY
  end

  it "registers an offense when inheriting from `::T::Enum`" do
    expect_offense(<<~RUBY)
      class Suit < ::T::Enum
      ^^^^^^^^^^^^^^^^^^^^^^ #{message}
        enums do
          Spades = new
          Hearts = new
          Clubs = new
          Diamonds = new
        end
      end
    RUBY
  end

  it "does not register an offense when inheriting from `Other::Enum`" do
    expect_no_offenses(<<~RUBY)
      class Suit < Other::Enum
      end
    RUBY
  end
end
