# Rubocop::NoSorbet

This set of rules serves to remove Sorbet from a codebase.

I like Sorbet a lot! But sometimes, I need to remove it from a codebase.

I use it to remove Sorbet type definitions in the gems I ship.

## Note!!!

* This gem does not cover all use-cases.
* This gem hasn't been tested very thoroughly.
* This gem produces ugly code. I recommend running your regular linter after.
* Please use version control! Please remember to commit your changes!
* Please run your tests to make sure your code is still okay!

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add rubocop-no_sorbet --require=false

## Usage

I strongly recommend that you use version control and commit all your changes
before using this gem. This gem edits your code, and honestly it isn't tested
too well.

Here's an example of how to run this and automatically remove all instances of
Sorbet:

```bash
bundle exec rubocop \
    --require rubocop-no_sorbet --only NoSorbet --autocorrect \
    app lib exe *.gemspec
```

Optionally, you can create a configuration file:

```yaml
# Name this file `.rubocop_no_sorbet.yml`
---
require:
  - rubocop-no_sorbet

AllCops:
  DisabledByDefault: true
  Exclude:
    - bin/**/*
    - test/**/*
  Include:
    - app/**/*.rb
    - exe/**/*
    - lib/**/*.rb
    - '*.gemspec'

NoSorbet:
  Enabled: Yes
```

You can then run the slightly shorter:

```bash
bundle exec rubocop --config .rubocop_no_sorbet.yml --autocorrect
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bin/rspec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bin/rake install`. To release
a new version, update the version number in `version.rb`, and then run
`bin/rake release`, which will create a git tag for the version, push git
commits and the created tag, and push the `.gem` file
to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
<https://github.com/zachahn/rubocop-no_sorbet>.

## License

The gem is available as open source under the terms
of the [MIT License](https://opensource.org/licenses/MIT).
