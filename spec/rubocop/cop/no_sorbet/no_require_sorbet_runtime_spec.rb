# frozen_string_literal: true

RSpec.describe RuboCop::Cop::NoSorbet::NoRequireSorbetRuntime, :config do
  let(:message) { described_class::MSG }
  it "registers a correctable offense for `require \"sorbet-runtime\"`" do
    expect_offense(<<~RUBY)
      require "sorbet-runtime"
      ^^^^^^^^^^^^^^^^^^^^^^^^ #{message}
    RUBY
    expect_correction("\n")
  end

  it "does not register an offense when requiring something else" do
    expect_no_offenses(<<~RUBY)
      require "something-else"
    RUBY
  end
end
