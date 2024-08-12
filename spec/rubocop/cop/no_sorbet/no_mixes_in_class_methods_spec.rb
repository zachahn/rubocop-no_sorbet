# frozen_string_literal: true

RSpec.describe RuboCop::Cop::NoSorbet::NoMixesInClassMethods, :config do
  let(:message) { described_class::MSG }

  it "registers a correctable offense when `mixes_in_class_methods`" do
    expect_offense(<<~RUBY)
      module Foo
        mixes_in_class_methods(MyClassMethods)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{message}
      end
    RUBY

    expect_correction(<<~RUBY)
      module Foo
        def self.included(klass)
          klass.extend(MyClassMethods)
        end
      end
    RUBY
  end

  it "inserts extends if self.included was already defined" do
    expect_offense(<<~RUBY)
      module Foo
        def self.included(hello)
          puts hello.inspect
        end
        mixes_in_class_methods(MyClassMethods)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{message}
      end
    RUBY

    expect_correction(<<~RUBY)
      module Foo
        def self.included(hello)
          puts hello.inspect
          hello.extend(MyClassMethods)
        end
        
      end
    RUBY
  end
end
