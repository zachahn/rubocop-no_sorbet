# frozen_string_literal: true

RSpec.describe RuboCop::Cop::NoRubocop::NoTStruct, :config do
  let(:message) { described_class::MSG }

  it "registers an offense when inheriting from `T::Struct`" do
    expect_offense(<<~RUBY)
      class Example < T::Struct
      ^^^^^^^^^^^^^^^^^^^^^^^^^ #{message}
      end
    RUBY
  end

  it "registers an offense when inheriting from `::T::Struct`" do
    expect_offense(<<~RUBY)
      class Example < ::T::Struct
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{message}
      end
    RUBY
  end
end
