# frozen_string_literal: true

RSpec.describe RuboCop::Cop::NoSorbet::NoAbstractBang, :config do
  let(:message) { described_class::MSG }

  it "registers an offense when `abstract!`" do
    expect_offense(<<~RUBY)
      class Foo
        extend T::Helpers
        abstract!
        ^^^^^^^^^ #{message}
      end
    RUBY

    expect_correction(<<~RUBY)
      class Foo
        extend T::Helpers
        
      end
    RUBY
  end
end
