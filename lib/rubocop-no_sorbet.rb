# frozen_string_literal: true

require "rubocop"

require_relative "rubocop/no_sorbet"
require_relative "rubocop/no_sorbet/version"
require_relative "rubocop/no_sorbet/inject"

RuboCop::NoSorbet::Inject.defaults!

require_relative "rubocop/cop/no_sorbet_cops"
