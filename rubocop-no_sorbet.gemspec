# frozen_string_literal: true

require_relative "lib/rubocop/no_sorbet/version"

Gem::Specification.new do |spec|
  spec.name = "rubocop-no_sorbet"
  spec.version = RuboCop::NoSorbet::VERSION
  spec.authors = ["Zach Ahn"]
  spec.email = ["engineering@zachahn.com"]

  spec.summary = "Ensure no Sorbet definitions"
  spec.homepage = "https://github.com/zachahn/rubocop-no_sorbet"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    Dir.glob("{{config,exe,lib,sig}/**/*,*.gemspec,{CHANGELOG,README}.md,LICENSE*}").select { |file| File.file?(file) }.sort
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html

  spec.add_runtime_dependency "rubocop"
end
