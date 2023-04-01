# frozen_string_literal: true

module RuboCop
  module Cop
    module NoSorbet
      # Do not use `T.absurd`
      #
      # @example
      #
      #   # bad
      #   T.absurd
      #
      class NoTAbsurd < Base
        MSG = "Do not use `T.absurd`"
        RESTRICT_ON_SEND = %i[absurd].freeze

        # @!method bad_method?(node)
        def_node_matcher :bad_method?, <<~PATTERN
          (send (const {nil? | cbase} :T) :absurd)
        PATTERN

        def on_send(node)
          return unless bad_method?(node)

          add_offense(node)
        end
      end
    end
  end
end
