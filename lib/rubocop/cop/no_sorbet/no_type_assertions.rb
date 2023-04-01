# frozen_string_literal: true

module RuboCop
  module Cop
    module NoSorbet
      # Do not use type assertions `T.cast`, `T.must`, etc
      #
      # @safety
      #   Unsafe
      #
      # @example
      #   # bad
      #   T.let
      #
      #   # bad
      #   T.cast
      #
      #   # bad
      #   T.must
      #
      #   # bad
      #   T.assert_type!
      #
      #   # bad
      #   T.bind
      #
      class NoTypeAssertions < Base
        extend AutoCorrector

        MSG = "Do not use type assertions `T.cast`, `T.must`, etc"
        RESTRICT_ON_SEND = %i[let cast must assert_type! bind].freeze

        # @!method t_let_cast_assert_type?(node)
        def_node_matcher :t_let_cast_assert_type?, <<~PATTERN
          (send (const {nil? | cbase} :T) {:let | :cast | :assert_type!} _ _)
        PATTERN

        # @!method t_must_bind?(node)
        def_node_matcher :t_must_bind?, <<~PATTERN
          (send #{RuboCop::NoSorbet::CONST_T} {:must | :bind} _)
        PATTERN

        def on_send(node)
          if t_let_cast_assert_type?(node)
            return add_offense(node) do |corrector|
              corrector.replace(node, "(#{node.child_nodes[1].source})")
            end
          end

          if t_must_bind?(node)
            add_offense(node) do |corrector|
              corrector.replace(node, "(#{node.child_nodes[1].source})")
            end
          end
        end
      end
    end
  end
end
