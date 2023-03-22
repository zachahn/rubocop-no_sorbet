# frozen_string_literal: true

RSpec.describe RuboCop::Cop::NoRubocop::NoTypeAliases, :config do
  let(:message) { described_class::MSG }

  it "registers an offense when using `T.type_alias`" do
    expect_offense(<<~RUBY)
      Int = T.type_alias {Integer}
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{message}
    RUBY
  end

  it "registers an offense when using `::T.type_alias`" do
    expect_offense(<<~RUBY)
      Int = ::T.type_alias {Integer}
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{message}
    RUBY
  end

  it "does not register an offense when using `Other::T.type_alias`" do
    expect_no_offenses(<<~RUBY)
      Int = Other::T.type_alias {Integer}
    RUBY
  end
end
