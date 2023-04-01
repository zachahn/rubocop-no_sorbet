# frozen_string_literal: true

RSpec.describe RuboCop::Cop::NoSorbet::NoSig, :config do
  let(:message) { RuboCop::Cop::NoSorbet::NoSig::MSG }

  it "registers an offense when method signature is defined via `sig`" do
    expect_offense(<<~RUBY)
      class Foo
        sig { void }
        ^^^^^^^^^^^^ #{message}
        def bar
        end
      end
    RUBY

    expect_correction(<<~RUBY)
      class Foo
        
        def bar
        end
      end
    RUBY
  end
end
