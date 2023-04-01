# frozen_string_literal: true

RSpec.describe RuboCop::Cop::NoSorbet::NoTAbsurd, :config do
  let(:message) { described_class::MSG }

  it "registers an offense when using `T.absurd`" do
    expect_offense(<<~RUBY)
      T.absurd
      ^^^^^^^^ #{message}
    RUBY
  end

  it "registers an offense when using `::T.absurd`" do
    expect_offense(<<~RUBY)
      T.absurd
      ^^^^^^^^ #{message}
    RUBY
  end

  it "does not register an offense when using `absurd`" do
    expect_no_offenses(<<~RUBY)
      absurd
    RUBY
  end

  it "does not register an offense when using `Other.absurd`" do
    expect_no_offenses(<<~RUBY)
      Other.absurd
    RUBY
  end
end
