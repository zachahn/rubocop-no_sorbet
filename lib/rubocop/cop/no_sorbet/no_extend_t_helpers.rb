# frozen_string_literal: true

module RuboCop
  module Cop
    module NoSorbet
      class NoExtendTHelpers < Base
        extend AutoCorrector

        MSG = "Do not `extend T::Helpers`"
        RESTRICT_ON_SEND = %i[extend].freeze

        # @!method extend_t_helpers?(node)
        def_node_matcher :extend_t_helpers?, <<~PATTERN
          (send _ :extend (const #{RuboCop::NoSorbet::CONST_T} :Helpers))
        PATTERN

        def on_send(node)
          return if !extend_t_helpers?(node)

          add_offense(node) do |corrector|
            corrector.remove(node)
          end
        end
      end
    end
  end
end
