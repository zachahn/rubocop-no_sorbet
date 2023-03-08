# Rubocop::NoSorbet

This set of rules serves to remove Sorbet from a codebase.

I like Sorbet a lot! But sometimes, I need to remove it from a codebase.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add rubocop-no_sorbet --require=false

## Usage

Put this into your `.rubocop.yml`.

```yaml
require:
  - rubocop-no_rubocop
```

You can also specify this at runtime.

```bash
rubocop --require rubocop-no_rubocop
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
