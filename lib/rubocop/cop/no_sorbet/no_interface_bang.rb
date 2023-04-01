# frozen_string_literal: true

module RuboCop
  module Cop
    module NoSorbet
      class NoInterfaceBang < Base
        extend AutoCorrector

        MSG = "Don't call `interface!`"

        RESTRICT_ON_SEND = %i[interface!].freeze

        # @!method interface?(node)
        def_node_matcher :interface?, <<~PATTERN
          (send nil? :interface!)
        PATTERN

        def on_send(node)
          return if !interface?(node)

          add_offense(node) do |corrector|
            corrector.remove(node)
          end
        end
      end
    end
  end
end
