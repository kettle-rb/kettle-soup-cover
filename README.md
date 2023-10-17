<p align="center">
  <a href="https://kettle-rb.gitlab.io/" target="_blank" rel="noopener">
    <img height="120px" src="https://kettle-rb.gitlab.io/assets/img/logos/logo-name-optimized.png" alt="kettle-rb logo, Copyright (c) 2023 Peter Boling, CC BY-SA 4.0, see https://kettle-rb.gitlab.io/logos">
  </a>
</p>

# Kettle::Soup::Cover

A Covered Kettle of SOUP (Software of Unknown Provenance)

The name is derived in part from the medical devices field,
where this library is considered a package of [SOUP](https://en.wikipedia.org/wiki/Software_of_unknown_pedigree).

It provides a one-line-configured, curated, opinionated, set of dependencies for Test Coverage.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add kettle-soup-cover

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install kettle-soup-cover

## Usage

In your `spec/spec_helper.rb`, just prior to loading the library under test:

```ruby
require "kettle/soup/cover" # or require "kettle-soup-cover"
```

In your `.simplecov` file:

```ruby
require "kettle/soup/cover/config"
SimpleCov.start
```

See [Advanced Usage](#advanced-usage) below for more info,
but the simplest thing is to run all the coverage things,
which is configured by default on CI.  To replicate that locally you could:

```shell
CI=true bundle exec rake test # or whatever command you run for tests.
```

That's it!

### Advanced Usage

There are a number of ENV variables that control things within this gem.
All of them can be found in [lib/kettle/soup/cover.rb][env-constants].

Additionally some of the included gems, like [`simplecov-console`][simplecov-console],
have their own complete suite of ENV variables you can configure.

[env-constants]: /lib/kettle/soup/cover.rb
[simplecov-console]: https://github.com/chetan/simplecov-console#options

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Code of Conduct

Everyone interacting in this project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## Versioning

This library aims to adhere to [Semantic Versioning 2.0.0][semver]. Violations of this scheme should be reported as
bugs. Specifically, if a minor or patch version is released that breaks backward compatibility, a new version should be
immediately released that restores compatibility. Breaking changes to the public API will only be introduced with new
major versions.

As a result of this policy, you can (and should) specify a dependency on this gem using
the [Pessimistic Version Constraint][pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency("kettle-soup-cover", "~> 0.1")
```

## License

The gem is available as open source under the terms of
the [MIT License][license] [![License: MIT][license-img]][license-ref].
See [LICENSE][license] for the official [Copyright Notice][copyright-notice-explainer].

* Copyright (c) 2023 [Peter H. Boling][peterboling] of [Rails Bling][railsbling]

[copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year
[license]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/blob/main/LICENSE.txt
[license-img]: https://img.shields.io/badge/License-MIT-green.svg
[license-ref]: https://opensource.org/licenses/MIT
[pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint
[railsbling]: http://www.railsbling.com
[semver]: http://semver.org/
