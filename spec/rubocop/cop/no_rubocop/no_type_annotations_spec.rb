# frozen_string_literal: true

RSpec.describe RuboCop::Cop::NoRubocop::NoTypeAnnotations, :config do
  let(:message) { described_class::MSG }

  it "registers an offense when using `T.let`" do
    expect_offense(<<~RUBY)
      def foo
        bar = T.let(nil, T.nilable(Integer))
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{message}
        bar ||= 1
      end
    RUBY

    expect_correction(<<~RUBY)
      def foo
        bar = (nil)
        bar ||= 1
      end
    RUBY
  end
end
