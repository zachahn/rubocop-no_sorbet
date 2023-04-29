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
        RESTRICT_ON_SEND = %i[let cast must assert_type! bind unsafe].freeze

        # @!method t_let_cast_assert_type_bind?(node)
        def_node_matcher :t_let_cast_assert_type_bind?, <<~PATTERN
          (send #{RuboCop::NoSorbet::CONST_T} {:let | :cast | :assert_type! | :bind} _ _)
        PATTERN

        # @!method t_must_unsafe?(node)
        def_node_matcher :t_must_unsafe?, <<~PATTERN
          (send #{RuboCop::NoSorbet::CONST_T} {:must | :unsafe} _)
        PATTERN

        def on_send(node)
          if t_let_cast_assert_type_bind?(node)
            return add_offense(node) do |corrector|
              corrector.replace(node, "(#{node.child_nodes[1].source})")
            end
          end

          if t_must_unsafe?(node)
            add_offense(node) do |corrector|
              corrector.replace(node, "(#{node.child_nodes[1].source})")
            end
          end
        end
      end
    end
  end
end
