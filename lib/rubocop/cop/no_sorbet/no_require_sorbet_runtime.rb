# frozen_string_literal: true

module RuboCop
  module Cop
    module NoSorbet
      class NoRequireSorbetRuntime < Base
        extend AutoCorrector

        MSG = "Don't require \"sorbet-runtime\""

        # TODO: Don't call `on_send` unless the method name is in this list
        # If you don't need `on_send` in the cop you created, remove it.
        RESTRICT_ON_SEND = %i[require].freeze

        # @!method require_sorbet_runtime?(node)
        def_node_matcher :require_sorbet_runtime?, <<~PATTERN
          (send nil? :require (str "sorbet-runtime"))
        PATTERN

        def on_send(node)
          return unless require_sorbet_runtime?(node)

          add_offense(node) do |corrector|
            corrector.remove(node)
          end
        end
      end
    end
  end
end
