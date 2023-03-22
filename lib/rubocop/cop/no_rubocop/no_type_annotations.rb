# frozen_string_literal: true

module RuboCop
  module Cop
    module NoRubocop
      # Do not use type annotations with `T.let`
      #
      # @safety
      #   Unsafe.
      #
      # @example
      #
      #   # bad
      #   foo = T.let(nil, T.nilable(Integer))
      #
      #   # good
      #   foo = nil
      #
      class NoTypeAnnotations < Base
        extend AutoCorrector

        MSG = "Do not use type annotations with `T.let`"
        RESTRICT_ON_SEND = %i[let].freeze

        # @!method t_let?(node)
        def_node_matcher :t_let?, <<~PATTERN
          (send (const {nil? | cbase} :T) :let _ _)
        PATTERN

        def on_send(node)
          return unless t_let?(node)

          add_offense(node) do |corrector|
            corrector.replace(node, node.child_nodes[1].to_s)
          end
        end
      end
    end
  end
end
