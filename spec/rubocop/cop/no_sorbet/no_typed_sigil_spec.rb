# frozen_string_literal: true

RSpec.describe RuboCop::Cop::NoSorbet::NoTypedSigil, :config do
  let(:message) { described_class::MSG }

  it "registers an offense when using the `typed` sigil" do
    expect_offense(<<~RUBY)
      # typed: true
      ^^^^^^^^^^^^^ #{message}
      test = true
    RUBY

    expect_correction(<<~RUBY)
      test = true
    RUBY
  end

  it "corrects correctly when there are other sigils, frozen_string_literal is first" do
    expect_offense(<<~RUBY)
      # frozen_string_literal: true
      # typed: true
      ^^^^^^^^^^^^^ #{message}
      test = true
    RUBY

    expect_correction(<<~RUBY)
      # frozen_string_literal: true
      test = true
    RUBY
  end

  it "corrects correctly when there are other sigils, frozen_string_literal is second" do
    expect_offense(<<~RUBY)
      # typed: true
      ^^^^^^^^^^^^^ #{message}
      # frozen_string_literal: true
      test = true
    RUBY

    expect_correction(<<~RUBY)
      # frozen_string_literal: true
      test = true
    RUBY
  end

  it "does not register an office when using `typed` in a comment, but not as a sigil" do
    expect_no_offenses(<<~RUBY)
      test = true # typed: true
    RUBY

    expect_no_offenses(<<~RUBY)
      test = true
      # typed: true
    RUBY
  end
end
