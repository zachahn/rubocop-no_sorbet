# frozen_string_literal: true

module RuboCop
  module Cop
    module NoRubocop
      # Do not `extend T::Sig`
      #
      # @safety
      #   Unsafe
      #
      # @example
      #   # bad
      #   module Foo
      #     extend T::Sig
      #   end
      #
      #   # good
      #   module Foo
      #   end
      #
      class NoExtendTSig < Base
        extend AutoCorrector

        MSG = "Do not `extend T::Sig`"
        RESTRICT_ON_SEND = %i[extend].freeze

        # @!method extend_t_sig?(node)
        def_node_matcher :extend_t_sig?, <<~PATTERN
          (send _ :extend (const (const _ :T) :Sig))
        PATTERN

        def on_send(node)
          return if !extend_t_sig?(node)

          add_offense(node) do |corrector|
            corrector.remove(node)
          end
        end
      end
    end
  end
end
