# frozen_string_literal: true

module RuboCop
  module Cop
    module NoRubocop
      # TODO: Write cop description and example of bad / good code. For every
      # `SupportedStyle` and unique configuration, there needs to be examples.
      # Examples must have valid Ruby syntax. Do not use upticks.
      #
      # @safety
      #   Unsafe
      #
      # @example
      #
      #   # bad
      #   Foo = T.type_alias { Integer }
      #
      class NoTypeAliases < Base
        MSG = "Do not alias types with `T.type_alias`"

        # @!method define_type_alias?(node)
        def_node_matcher :define_type_alias?, <<~PATTERN
          (casgn _ _ (block (send (const {nil? | cbase} :T) :type_alias) ...))
        PATTERN

        def on_casgn(node)
          return unless define_type_alias?(node)

          add_offense(node)
        end
      end
    end
  end
end
