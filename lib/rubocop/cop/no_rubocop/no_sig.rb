# frozen_string_literal: true

module RuboCop
  module Cop
    module NoRubocop
      # TODO: Write cop description and example of bad / good code. For every
      # `SupportedStyle` and unique configuration, there needs to be examples.
      # Examples must have valid Ruby syntax. Do not use upticks.
      #
      # @safety
      #   Delete this section if the cop is not unsafe (`Safe: false` or
      #   `SafeAutoCorrect: false`), or use it to explain how the cop is
      #   unsafe.
      #
      # @example EnforcedStyle: bar (default)
      #   # Description of the `bar` style.
      #
      #   # bad
      #   bad_bar_method
      #
      #   # bad
      #   bad_bar_method(args)
      #
      #   # good
      #   good_bar_method
      #
      #   # good
      #   good_bar_method(args)
      #
      # @example EnforcedStyle: foo
      #   # Description of the `foo` style.
      #
      #   # bad
      #   sig { void }
      #   def foo
      #   end
      #
      #   # good
      #   def foo
      #   end
      #
      class NoSig < Base
        extend AutoCorrector

        MSG = "Do not define type signatures with `sig`"

        # @!method sig?(node)
        def_node_matcher :sig?, <<~PATTERN
          (block (send _ :sig) ...)
        PATTERN

        def on_block(node)
          return if !sig?(node)

          add_offense(node) do |corrector|
            corrector.remove(node)
          end
        end
      end
    end
  end
end
