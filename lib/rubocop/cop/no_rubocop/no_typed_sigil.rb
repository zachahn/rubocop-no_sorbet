# frozen_string_literal: true

module RuboCop
  module Cop
    module NoRubocop
      # Do not set the `typed` sigil
      #
      # @safety
      #   Unsafe.
      #
      # @example
      #   # bad
      #   # typed: ignore
      #
      #   # bad
      #   # typed: false
      #
      #   # bad
      #   # typed: true
      #
      #   # bad
      #   # typed: strict
      #
      #   # bad
      #   # typed: strong
      #
      class NoTypedSigil < Base
        extend AutoCorrector

        MSG = "Do not set the `typed` sigil"

        def on_new_investigation
          return if processed_source.buffer.source.empty?

          processed_source.comments.each do |comment|
            break if comment.loc.line >= processed_source.ast.loc.line

            magic_comment = MagicComment.parse(comment.text)

            if magic_comment.typed_specified?
              end_pos = comment.location.expression.end_pos
              add_offense(comment) do |corrector|
                corrector.remove(comment)
                end_pos =
                  if /^[\r\n]+$/m.match?(processed_source.raw_source[(end_pos..(end_pos + 1))])
                    comment.location.expression.end_pos + 2
                  elsif /^[\r\n]+$/m.match?(processed_source.raw_source[end_pos])
                    comment.location.expression.end_pos + 1
                  else
                    comment.location.expression.end_pos
                  end

                total_removal = Parser::Source::Range.new(
                  processed_source.buffer,
                  comment.location.expression.begin_pos,
                  end_pos
                )

                corrector.remove(total_removal)
              end
            end
          end
        end
      end
    end
  end
end
