# frozen_string_literal: true

module RuboCop
  module Cop
    module NoRubocop
      # Do not inherit from `T::Enum`
      #
      # @safety
      #   There is no easy Ruby replacement for T::Enum
      #
      # @example
      #   # bad
      #   class Foo < T::Enum
      #   end
      class NoTEnum < Base
        MSG = "Do not inherit from `T::Enum`"

        # @!method inheriting_t_struct?(node)
        def_node_matcher :inheriting_t_enum?, <<~PATTERN
          (class (const ...) (const (const {nil? | cbase} :T) :Enum) ...)
        PATTERN

        def on_class(node)
          return unless inheriting_t_enum?(node)

          add_offense(node)
        end
      end
    end
  end
end
