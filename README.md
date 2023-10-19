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

## Support My Open Source Development

<div id="badges">

[![Liberapay Patrons][⛳liberapay-img]][⛳liberapay]
<span class="badge-buymeacoffee">
[![Sponsor Me][🖇sponsor-img]][🖇sponsor]
<a href="https://ko-fi.com/O5O86SNP4" target='_blank' title="Donate to my FLOSS or refugee efforts at ko-fi.com"><img src="https://img.shields.io/badge/buy%20me%20coffee-donate-yellow.svg" alt="Buy Me Coffee donation button" /></a>
</span>
<span class="badge-patreon">
<a href="https://patreon.com/galtzo" title="Donate to my FLOSS or refugee efforts using Patreon"><img src="https://img.shields.io/badge/patreon-donate-yellow.svg" alt="Patreon donate button" /></a>
</span>

---

<a rel="me" alt="Follow me on Ruby.social" href="https://ruby.social/@galtzo"><img src="https://img.shields.io/mastodon/follow/109447111526622197?domain=https%3A%2F%2Fruby.social&style=social&label=Follow%20%40galtzo%20on%20Ruby.social"></a>
[![Follow Me on X][🐦twitter-img]][🐦twitter]
[![Follow Me on LinkedIn][🖇linkedin-img]][🖇linkedin]
[![Subscribe to my Rubygems updates][💎rubygems-img]][💎rubygems]
[![My Blog][🚎blog-img]][🚎blog]

</div>

[⛳liberapay-img]: https://img.shields.io/liberapay/patrons/pboling.svg?logo=liberapay
[⛳liberapay]: https://liberapay.com/pboling/donate
[🖇sponsor-img]: https://img.shields.io/badge/Sponsor_Me!-pboling.svg?style=social&logo=github
[🖇sponsor]: https://github.com/sponsors/pboling
[🖇linkedin]: http://www.linkedin.com/in/peterboling
[🖇linkedin-img]: https://img.shields.io/badge/PeterBoling-blue?style=plastic&logo=linkedin
[🐦twitter]: http://x.com/intent/user?screen_name=galtzo
[🐦twitter-img]: https://img.shields.io/twitter/follow/galtzo.svg?style=social&label=Follow%20@galtzo
[💎rubygems]: https://rubygems.org/profiles/pboling
[💎rubygems-img]: https://img.shields.io/gem/u/pboling.svg
[🚎blog]: http://www.railsbling.com/tags/oauth2/
[🚎blog-img]: https://img.shields.io/badge/blog-railsbling-brightgreen.svg?style=flat

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add kettle-soup-cover

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install kettle-soup-cover

## Usage

In your `spec/spec_helper.rb`, just prior to loading the library under test:

```ruby
# This does not require "simplecov",
#   because that has a side-effect of running `.simplecov`
require "kettle-soup-cover"

# Later in your spec setup, do this;
require "simplecov" if Kettle::Soup::Cover::COV_DO
```

In your `.simplecov` file:

```ruby
require "kettle/soup/cover/config"
SimpleCov.start # you could do this somewhere else, up to you, but you do have to do it
```

See [Advanced Usage](#advanced-usage) below for more info,
but the simplest thing is to run all the coverage things,
which is configured by default on CI.  To replicate that locally you could:

```shell
CI=true bundle exec rake test # or whatever command you run for tests.
```

That's it!

### Rakefile

You'll need to have your `test` task defined.
If you use `spec` instead, you can alias `test` to `spec` as follows:

```ruby
desc "alias test task to spec"
task test: :spec
```

This gem provides a `coverage` task.
It runs the `test` task (see just above about that),
and opens the coverage results in a browser.

```ruby
require "kettle-soup-cover"
Kettle::Soup::Cover.install_tasks
```

### Filters

There are two built-in SimpleCov filters which can be loaded via `Kettle::Soup::Cover.load_filters`.

You could use them like this:
```ruby
SimpleCov.add_group("Too Long", Kettle::Soup::Cover::Filters::GtLineFilter.new(1000))
```

### Advanced Usage

There are a number of ENV variables that control things within this gem.
All of them can be found, along with their default values, in [lib/kettle/soup/cover.rb][env-constants].

#### Handy List of ENV Variables

Most are self explanatory.
I tried to follow POLS, the principle of least surprise, so they mostly _DWTFYT_.
Want to help improve this documentation? PRs are easy!

```shell
K_SOUP_COV_COMMAND_NAME
K_SOUP_COV_DEBUG
K_SOUP_COV_DIR
K_SOUP_COV_DO
K_SOUP_COV_FILTER_DIRS
K_SOUP_COV_FORMATTERS
K_SOUP_COV_MERGE_TIMEOUT
K_SOUP_COV_MIN_HARD
K_SOUP_COV_MIN_BRANCH
K_SOUP_COV_MIN_LINE
K_SOUP_COV_MULTI_FORMATTERS
K_SOUP_COV_PREFIX
K_SOUP_COV_USE_MERGING
K_SOUP_COV_VERBOSE
```

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
spec.add_dependency("kettle-soup-cover", "~> 1.0")
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
