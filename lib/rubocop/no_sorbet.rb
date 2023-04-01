# frozen_string_literal: true

require_relative "no_sorbet/version"

module RuboCop
  module NoSorbet
    class Error < StandardError; end
    # Your code goes here...
    PROJECT_ROOT = Pathname.new(__dir__).parent.parent.expand_path.freeze
    CONFIG_DEFAULT = PROJECT_ROOT.join("config", "default.yml").freeze
    CONFIG = YAML.safe_load(CONFIG_DEFAULT.read).freeze

    CONST_T = "(const {nil? | cbase} :T)"

    private_constant(:CONFIG_DEFAULT, :PROJECT_ROOT)
  end
end
