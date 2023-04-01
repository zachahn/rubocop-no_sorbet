# frozen_string_literal: true

module RuboCop
  module Cop
    module NoSorbet
      # Do not inherit from `T::Struct`
      #
      # @safety
      #   There is no easy Ruby replacement for T::Struct
      #
      # @example
      #
      #   # bad
      #   class Foo < T::Struct
      #   end
      #
      #   # good
      #   Foo = Struct.new()
      #
      #   # good
      #   class Foo
      #   end
      #
      class NoTStruct < Base
        MSG = "Do not inherit from `T::Struct`"

        # @!method inheriting_t_struct?(node)
        def_node_matcher :inheriting_t_struct?, <<~PATTERN
          (class (const ...) (const #{RuboCop::NoSorbet::CONST_T} :Struct) ...)
        PATTERN

        def on_class(node)
          return unless inheriting_t_struct?(node)

          add_offense(node)
        end
      end
    end
  end
end
