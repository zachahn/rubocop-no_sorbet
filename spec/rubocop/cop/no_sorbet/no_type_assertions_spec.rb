# frozen_string_literal: true

RSpec.describe RuboCop::Cop::NoSorbet::NoTypeAssertions, :config do
  let(:message) { described_class::MSG }

  shared_examples "two argument assertion, keep first parameter" do |method_name, type|
    it "registers an offense when assigning `T.#{method_name}(#{type})` to a variable" do
      expect_offense(<<~RUBY)
        foo = T.#{method_name}(some_value, #{type})
              ^^^^^^^^^^^^^^^^#{"^" * (method_name.size + type.size)} #{message}
      RUBY

      expect_correction(<<~RUBY)
        foo = (some_value)
      RUBY
    end

    it "registers an offense when assigning `::T.#{method_name}(#{type})` to a variable" do
      expect_offense(<<~RUBY)
        foo = ::T.#{method_name}(some_value, #{type})
              ^^^^^^^^^^^^^^^^^^#{"^" * (method_name.size + type.size)} #{message}
      RUBY

      expect_correction(<<~RUBY)
        foo = (some_value)
      RUBY
    end
  end

  shared_examples "one argument assertion, keep parameter" do |method_name, parameter|
    it "registers an offense when assigning `T.#{method_name}`" do
      expect_offense(<<~RUBY)
        foo = T.#{method_name}(#{parameter})
              ^^^^#{"^" * (method_name.size + parameter.size)} #{message}
      RUBY

      expect_correction(<<~RUBY)
        foo = (#{parameter})
      RUBY
    end

    it "registers an offense when assigning `::T.#{method_name}`" do
      expect_offense(<<~RUBY)
        foo = ::T.#{method_name}(#{parameter})
              ^^^^^^#{"^" * (method_name.size + parameter.size)} #{message}
      RUBY

      expect_correction(<<~RUBY)
        foo = (#{parameter})
      RUBY
    end
  end

  include_examples "two argument assertion, keep first parameter", "let", "T.nilable(Integer)"
  include_examples "two argument assertion, keep first parameter", "cast", "String"
  include_examples "two argument assertion, keep first parameter", "assert_type!", "T::Boolean"
  include_examples "two argument assertion, keep first parameter", "bind", "self", "MyClass"

  include_examples "one argument assertion, keep parameter", "must", "some_value"
  include_examples "one argument assertion, keep parameter", "unsafe", "some_value"
end
