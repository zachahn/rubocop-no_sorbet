# frozen_string_literal: true

RSpec.describe RuboCop::Cop::NoSorbet::NoExtendTHelpers, :config do
  let(:message) { described_class::MSG }

  shared_examples "wrapped `extend T::Helpers`" do |open, close|
    it "registers a correctable offense when `extend T::Helpers` is wrapped within `#{open}`" do
      expect_offense(<<~RUBY)
        #{open}
          extend T::Helpers
          ^^^^^^^^^^^^^^^^^ #{message}
        #{close}
      RUBY

      expect_correction(<<~RUBY)
        #{open}
          
        #{close}
      RUBY
    end
  end

  include_examples "wrapped `extend T::Helpers`", "class Foo", "end"
  include_examples "wrapped `extend T::Helpers`", "module Foo", "end"
  include_examples "wrapped `extend T::Helpers`", "class Foo ; class << self", "end; end"
  include_examples "wrapped `extend T::Helpers`", "module Foo ; class << self", "end; end"
  include_examples "wrapped `extend T::Helpers`", "", ""

  it "registers a correctable offence when `extend T::Helpers` is called on an object" do
    expect_offense(<<~RUBY)
      foo.extend T::Helpers
      ^^^^^^^^^^^^^^^^^^^^^ #{message}
    RUBY

    expect_correction("\n")
  end
end
