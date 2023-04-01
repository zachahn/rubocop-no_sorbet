# frozen_string_literal: true

module RuboCop
  module Cop
    module NoSorbet
      class NoAbstractBang < Base
        extend AutoCorrector

        MSG = "Don't call `abstract!`"

        RESTRICT_ON_SEND = %i[abstract!].freeze

        # @!method abstract?(node)
        def_node_matcher :abstract?, <<~PATTERN
          (send nil? :abstract!)
        PATTERN

        def on_send(node)
          return if !abstract?(node)

          add_offense(node) do |corrector|
            corrector.remove(node)
          end
        end
      end
    end
  end
end
