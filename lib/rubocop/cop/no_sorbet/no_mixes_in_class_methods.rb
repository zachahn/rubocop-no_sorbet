# frozen_string_literal: true

module RuboCop
  module Cop
    module NoSorbet
      class NoMixesInClassMethods < Base
        extend AutoCorrector

        RESTRICT_ON_SEND = [:mixes_in_class_methods]

        MSG = "Don't call `mixes_in_class_methods`"

        def_node_matcher :mixes_in_class_methods?, <<~PATTERN
          (send nil? :mixes_in_class_methods $(...))
        PATTERN

        def_node_matcher :def_self_included?, <<~PATTERN
          (defs
            (self) :included
            (args
              (arg ...)) ...)
        PATTERN

        def on_send(node)
          mixin = mixes_in_class_methods?(node)
          return if !mixin

          add_offense(node) do |corrector|
            child = node.parent.each_child_node.find { def_self_included?(_1) }

            if child
              existing_argument = child.first_argument
              existing_method_body = child.body
              indent = " " * existing_method_body.loc.column
              corrector.insert_after(existing_method_body, <<~RUBY.rstrip)

                #{indent}#{existing_argument.source}.extend(#{mixin.source})
              RUBY
              corrector.remove(node)
            else
              indent = " " * node.loc.column
              corrector.replace(node, <<~RUBY.rstrip)
                def self.included(klass)
                #{indent}  klass.extend(#{mixin.source})
                #{indent}end
              RUBY
            end
          end
        end
      end
    end
  end
end
