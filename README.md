# Commitlint

This is a pure-ruby alternative to [commitlint](https://commitlint.js.org/).
It's simple and does what it needs to do: lint your commit messages.

## Installation

Install the gem and add to the application's `Gemfile` by executing:

    bundle add commitlint --group "development"

If bundler is not being used to manage dependencies, install the gem by executing:

    gem install commitlint

## Usage

The best way to use this gem is to add it to your `commit-msg` hook.
You can do this with [lefthook](https://lefthook.dev/)

First, install `lefthook` and `commitlint`:

```ruby
group :development do
  gem "lefthook", require: false
  gem "commitlint", require: false
end
```

Then, set up your `lefthook.yml` file with a `commit-msg` hook:

```yaml
commit-msg:
  jobs:
    - name: Lint commit message
      run: bundle exec commitlint --message {1}
```

In fact, this repository lints its own commit messages using this gem.

## Feautures

This gem does not require any configuration. It will lint your commit messages and that's it.
I'm not planning to add any configuration options, because I think that the default behavior is good enough.

The goal is provide a simple and fast way to lint your commit messages according to the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/arandilopez/commitlint>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/arandilopez/commitlint/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Commitlint project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/arandilopez/commitlint/blob/main/CODE_OF_CONDUCT.md).
