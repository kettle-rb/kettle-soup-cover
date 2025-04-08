<p align="center">
  <a href="https://kettle-rb.gitlab.io/" target="_blank" rel="noopener">
    <img height="120px" src="https://kettle-rb.gitlab.io/assets/img/logos/logo-name-optimized.png" alt="kettle-rb logo, Copyright (c) 2023 Peter Boling, CC BY-SA 4.0, see https://kettle-rb.gitlab.io/logos">
  </a>
</p>

# Kettle::Soup::Cover

[![Version][👽versioni]][👽version]
[![License: MIT][📄license-img]][📄license-ref]
[![Downloads Rank][👽dl-ranki]][👽dl-rank]
[![Open Source Helpers][👽oss-helpi]][👽oss-help]
[![Depfu][🔑depfui♻️]][🔑depfu]
[![CodeCov Test Coverage][🔑codecovi♻️]][🔑codecov]
[![Coveralls Test Coverage][🔑coveralls-img]][🔑coveralls]
[![CodeClimate Test Coverage][🔑cc-covi♻️]][🔑cc-cov]
[![Maintainability][🔑cc-mnti♻️]][🔑cc-mnt]
[![CI Heads][🚎3-hd-wfi]][🚎3-hd-wf]
[![CI Current][🚎11-c-wfi]][🚎11-c-wf]
[![CI Supported][🚎6-s-wfi]][🚎6-s-wf]
[![CI Legacy][🚎4-lg-wfi]][🚎4-lg-wf]
[![CI Unsupported][🚎7-us-wfi]][🚎7-us-wf]
[![CI Test Coverage][🚎2-cov-wfi]][🚎2-cov-wf]
[![CI Style][🚎5-st-wfi]][🚎5-st-wf]

---

[![Liberapay Patrons][⛳liberapay-img]][⛳liberapay]
[![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor]
[![Buy me a coffee][🖇buyme-small-img]][🖇buyme]
[![Polar Shield][🖇polar-img]][🖇polar]
[![Donate to my FLOSS or refugee efforts at ko-fi.com][🖇kofi-img]][🖇kofi]
[![Donate to my FLOSS or refugee efforts using Patreon][🖇patreon-img]][🖇patreon]

A Covered Kettle of SOUP (Software of Unknown Provenance)

The name is derived in part from the medical devices field,
where this library is considered a package of [SOUP](https://en.wikipedia.org/wiki/Software_of_unknown_pedigree).

Just add four lines of code to get a configured, curated, opinionated, set of dependencies for Test Coverage.

One of the major benefits of using this library is not having to figure
out how to get multiple coverage output formats working.  I did that for you,
and I got all of them working, at the same time together, or al la carte. Kum-ba-ya.

A quick shot of raw coverage power, straight to your brain:

```shell
export K_SOUP_COV_DO=true # Means you want code coverage
export K_SOUP_COV_FORMATTERS="html,tty" # Set to some slice of "html,xml,rcov,lcov,json,tty"
export K_SOUP_COV_MIN_BRANCH=53 # Means you want to enforce X% branch coverage
export K_SOUP_COV_MIN_HARD=true # Means you want the build to fail if the coverage thresholds are not met
export K_SOUP_COV_MIN_LINE=69 # Means you want to enforce X% line coverage
export MAX_ROWS=5 # Setting for simplecov-console gem for tty output, limits to the worst N rows of bad coverage
```

I hope I've piqued your interest.

## Info you can shake a stick at

| Tokens to Remember      | [![Gem name][⛳️name-img]][⛳️gem-name] [![Gem namespace][⛳️namespace-img]][⛳️gem-namespace]                                                                                                                                                                                                                                                                                                                                                                          |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Works with MRI Ruby 3   | [![Ruby 3.0 Compat][💎ruby-3.0i]][🚎4-lg-wf] [![Ruby 3.1 Compat][💎ruby-3.1i]][🚎6-s-wf] [![Ruby 3.2 Compat][💎ruby-3.2i]][🚎6-s-wf] [![Ruby 3.3 Compat][💎ruby-3.3i]][🚎6-s-wf] [![Ruby 3.4 Compat][💎ruby-c-i]][🚎11-c-wf] [![Ruby HEAD Compat][💎ruby-headi]][🚎3-hd-wf]                                                                                                                                                                                         |
| Works with MRI Ruby 2   | [![Ruby 2.7 Compat][💎ruby-2.7i]][🚎7-us-wf]                                                                                                                                                                                                                                                                                                                                                                                                                        |
| Source                  | [![Source on GitLab.com][📜src-gl-img]][📜src-gl] [![Source on Github.com][📜src-gh-img]][📜src-gh] [![The best SHA: dQw4w9WgXcQ!][🧮kloc-img]][🧮kloc]                                                                                                                                                                                                                                                                                                             |
| Documentation           | [![Current release on RubyDoc.info][📜docs-cr-rd-img]][🚎yard-current] [![HEAD on RubyDoc.info][📜docs-head-rd-img]][🚎yard-head] [![BDFL Blog][🚂bdfl-blog-img]][🚂bdfl-blog] [![Wiki][📜wiki-img]][📜wiki]                                                                                                                                                                                                                                                        |
| Compliance              | [![License: MIT][📄license-img]][📄license-ref] [![📄ilo-declaration-img]][📄ilo-declaration] [![Security Policy][🔐security-img]][🔐security] [![CodeQL][🖐codeQL-img]][🖐codeQL] [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct] [![SemVer 2.0.0][📌semver-img]][📌semver] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog]                                                                                                            |
| Expert 1:1 Support      | [![Get help from me on Upwork][👨🏼‍🏫expsup-upwork-img]][👨🏼‍🏫expsup-upwork] `or` [![Get help from me on Codementor][👨🏼‍🏫expsup-codementor-img]][👨🏼‍🏫expsup-codementor]                                                                                                                                                                                                                                                                                    |
| Enterprise Support      | [![Get help from me on Tidelift][🏙️entsup-tidelift-img]][🏙️entsup-tidelift]<br/>💡Subscribe for support guarantees covering _all_ FLOSS dependencies!<br/>💡Tidelift is part of [Sonar][🏙️entsup-tidelift-sonar]!<br/>💡Tidelift pays maintainers to maintain the software you depend on!<br/>📊`@`Pointy Haired Boss: An [enterprise support][🏙️entsup-tidelift] subscription is "[never gonna let you down][🧮kloc]", and *supports* open source maintainers! |
| Comrade BDFL 🎖️        | [![Follow Me on LinkedIn][💖🖇linkedin-img]][💖🖇linkedin] [![Follow Me on Ruby.Social][💖🐘ruby-mast-img]][💖🐘ruby-mast] [![Follow Me on Bluesky][💖🦋bluesky-img]][💖🦋bluesky] [![Contact BDFL][🚂bdfl-contact-img]][🚂bdfl-contact] [![My technical writing][💖💁🏼‍♂️devto-img]][💖💁🏼‍♂️devto]                                                                                                                                                              |
| `...` 💖                | [![Find Me on WellFound:][💖✌️wellfound-img]][💖✌️wellfound] [![Find Me on CrunchBase][💖💲crunchbase-img]][💖💲crunchbase] [![My LinkTree][💖🌳linktree-img]][💖🌳linktree] [![More About Me][💖💁🏼‍♂️aboutme-img]][💖💁🏼‍♂️aboutme]                                                                                                                                                                                                                             |

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add kettle-soup-cover

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install kettle-soup-cover

## Usage

In your `spec/spec_helper.rb`, just prior to loading the library under test:

```ruby
# This does not require "simplecov",
#   because that has a side effect of running `.simplecov`
require "kettle-soup-cover"

# Later in your spec setup, do this;
require "simplecov" if Kettle::Soup::Cover::DO_COV
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
K_SOUP_COV_MIN_BRANCH
K_SOUP_COV_MIN_HARD
K_SOUP_COV_MIN_LINE
K_SOUP_COV_MULTI_FORMATTERS
K_SOUP_COV_PREFIX
K_SOUP_COV_USE_MERGING
K_SOUP_COV_VERBOSE
```

Additionally, some of the included gems, like [`simplecov-console`][simplecov-console],
have their own complete suite of ENV variables you can configure.

[env-constants]: /lib/kettle/soup/cover.rb
[simplecov-console]: https://github.com/chetan/simplecov-console#options

## 🔐 Security

See [SECURITY.md][🔐security].

## 🤝 Contributing

If you need some ideas of where to help, you could work on adding more code coverage,
or if it is already 💯 (see [below](#code-coverage)) check TODOs (see [below](#todos)),
or check [issues][🤝issues], or [PRs][🤝pulls],
or use the gem and think about how it could be better.

We [![Keep A Changelog][📗keep-changelog-img]][📗keep-changelog] so if you make changes, remember to update it.

See [CONTRIBUTING.md][🤝contributing] for more detailed instructions.

### Code Coverage

[![Coverage Graph][🔑codecov-g♻️]][🔑codecov]

### 🪇 Code of Conduct

Everyone interacting in this project's codebases, issue trackers,
chat rooms and mailing lists is expected to follow the [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct].

## 🌈 Contributors

[![Contributors][🖐contributors-img]][🖐contributors]

Made with [contributors-img][🖐contrib-rocks].

Also see GitLab Contributors: [https://gitlab.com/kettle-rb/kettle-soup-cover/-/graphs/main][🚎contributors-gl]

## ⭐️ Star History

<a href="https://star-history.com/#kettle-rb/kettle-soup-cover&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=kettle-rb/kettle-soup-cover&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=kettle-rb/kettle-soup-cover&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=kettle-rb/kettle-soup-cover&type=Date" />
 </picture>
</a>

## 📌 Versioning

This Library adheres to [![Semantic Versioning 2.0.0][📌semver-img]][📌semver].
Violations of this scheme should be reported as bugs.
Specifically, if a minor or patch version is released that breaks backward compatibility,
a new version should be immediately released that restores compatibility.
Breaking changes to the public API will only be introduced with new major versions.

### 📌 Is "Platform Support" part of the public API?

Yes.  But I'm obligated to include notes...

SemVer should, but doesn't explicitly, say that dropping support for specific Platforms
is a *breaking change* to an API.
It is obvious to many, but not all, and since the spec is silent, the bike shedding is endless.

> dropping support for a platform is both obviously and objectively a breaking change

- Jordan Harband (@ljharb) [in SemVer issue 716][📌semver-breaking]

To get a better understanding of how SemVer is intended to work over a project's lifetime,
read this article from the creator of SemVer:

- ["Major Version Numbers are Not Sacred"][📌major-versions-not-sacred]

As a result of this policy, and the interpretive lens used by the maintainer,
you can (and should) specify a dependency on these libraries using
the [Pessimistic Version Constraint][📌pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency("kettle-soup-cover", "~> 1.0")
```

See [CHANGELOG.md][📌changelog] for list of releases.

## 📄 License

The gem is available as open source under the terms of
the [MIT License][📄license] [![License: MIT][📄license-img]][📄license-ref].
See [LICENSE.txt][📄license] for the official [Copyright Notice][📄copyright-notice-explainer].

### © Copyright

<p>
  Copyright (c) 2023 - 2025 Peter H. Boling,
  <a href="https://railsbling.com">
    RailsBling.com
    <picture>
      <img alt="Rails Bling" height="20" src="https://railsbling.com/images/logos/RailsBling-TrainLogo.svg" />
    </picture>
  </a>
</p>

## 🤑 One more thing

You made it to the bottom of the page,
so perhaps you'll indulge me for another 20 seconds.
I maintain many dozens of gems, including this one,
because I want Ruby to be a great place for people to solve problems, big and small.
Please consider supporting my efforts via the giant yellow link below,
or one of the others at the head of this README.

[![Buy me a latte][🖇buyme-img]][🖇buyme]

[✇bundle-group-pattern]: https://gist.github.com/pboling/4564780
[⛳️gem-namespace]: https://github.com/kettle-rb/kettle-soup-cover/blob/main/lib/masq.rb
[⛳️namespace-img]: https://img.shields.io/badge/namespace-Kettle%3A%3ASoup%3A%3ACover-brightgreen.svg?style=flat&logo=ruby&logoColor=white
[⛳️gem-name]: https://rubygems.org/gems/kettle-soup-cover
[⛳️name-img]: https://img.shields.io/badge/name-kettle--soup--cover-brightgreen.svg?style=flat&logo=rubygems&logoColor=red
[🚂bdfl-blog]: http://www.railsbling.com/tags/kettle-soup-cover
[🚂bdfl-blog-img]: https://img.shields.io/badge/blog-railsbling-0093D0.svg?style=for-the-badge&logo=rubyonrails&logoColor=orange
[🚂bdfl-contact]: http://www.railsbling.com/contact
[🚂bdfl-contact-img]: https://img.shields.io/badge/Contact-BDFL-0093D0.svg?style=flat&logo=rubyonrails&logoColor=red
[💖🖇linkedin]: http://www.linkedin.com/in/peterboling
[💖🖇linkedin-img]: https://img.shields.io/badge/PeterBoling-LinkedIn-0B66C2?style=flat&logo=newjapanprowrestling
[💖✌️wellfound]: https://angel.co/u/peter-boling
[💖✌️wellfound-img]: https://img.shields.io/badge/peter--boling-orange?style=flat&logo=wellfound
[💖💲crunchbase]: https://www.crunchbase.com/person/peter-boling
[💖💲crunchbase-img]: https://img.shields.io/badge/peter--boling-purple?style=flat&logo=crunchbase
[💖🐘ruby-mast]: https://ruby.social/@galtzo
[💖🐘ruby-mast-img]: https://img.shields.io/mastodon/follow/109447111526622197?domain=https%3A%2F%2Fruby.social&style=flat&logo=mastodon&label=Ruby%20%40galtzo
[💖🦋bluesky]: https://galtzo.bsky.social
[💖🦋bluesky-img]: https://img.shields.io/badge/@galtzo.bsky.social-0285FF?style=flat&logo=bluesky&logoColor=white
[💖🌳linktree]: https://linktr.ee/galtzo
[💖🌳linktree-img]: https://img.shields.io/badge/galtzo-purple?style=flat&logo=linktree
[💖💁🏼‍♂️devto]: https://dev.to/galtzo
[💖💁🏼‍♂️devto-img]: https://img.shields.io/badge/dev.to-0A0A0A?style=flat&logo=devdotto&logoColor=white
[💖💁🏼‍♂️aboutme]: https://about.me/peter.boling
[💖💁🏼‍♂️aboutme-img]: https://img.shields.io/badge/about.me-0A0A0A?style=flat&logo=aboutme&logoColor=white
[👨🏼‍🏫expsup-upwork]: https://www.upwork.com/freelancers/~014942e9b056abdf86?mp_source=share
[👨🏼‍🏫expsup-upwork-img]: https://img.shields.io/badge/UpWork-13544E?style=for-the-badge&logo=Upwork&logoColor=white
[👨🏼‍🏫expsup-codementor]: https://www.codementor.io/peterboling?utm_source=github&utm_medium=button&utm_term=peterboling&utm_campaign=github
[👨🏼‍🏫expsup-codementor-img]: https://img.shields.io/badge/CodeMentor-Get_Help-1abc9c?style=for-the-badge&logo=CodeMentor&logoColor=white
[🏙️entsup-tidelift]: https://tidelift.com/subscription
[🏙️entsup-tidelift-img]: https://img.shields.io/badge/Tidelift_and_Sonar-Enterprise_Support-FD3456?style=for-the-badge&logo=sonar&logoColor=white
[🏙️entsup-tidelift-sonar]: https://blog.tidelift.com/tidelift-joins-sonar
[💁🏼‍♂️peterboling]: http://www.peterboling.com
[🚂railsbling]: http://www.railsbling.com
[📜src-gl-img]: https://img.shields.io/badge/GitLab-FBA326?style=for-the-badge&logo=Gitlab&logoColor=orange
[📜src-gl]: https://gitlab.com/kettle-rb/kettle-soup-cover/
[📜src-gh-img]: https://img.shields.io/badge/GitHub-238636?style=for-the-badge&logo=Github&logoColor=green
[📜src-gh]: https://github.com/kettle-rb/kettle-soup-cover
[📜docs-cr-rd-img]: https://img.shields.io/badge/RubyDoc-Current_Release-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜docs-head-rd-img]: https://img.shields.io/badge/RubyDoc-HEAD-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜wiki]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/wikis/home
[📜wiki-img]: https://img.shields.io/badge/wiki-examples-943CD2.svg?style=for-the-badge&logo=Wiki&logoColor=white
[👽dl-rank]: https://rubygems.org/gems/kettle-soup-cover
[👽dl-ranki]: https://img.shields.io/gem/rd/kettle-soup-cover.svg
[👽oss-help]: https://www.codetriage.com/kettle-rb/kettle-soup-cover
[👽oss-helpi]: https://www.codetriage.com/kettle-rb/kettle-soup-cover/badges/users.svg
[👽version]: https://rubygems.org/gems/kettle-soup-cover
[👽versioni]: https://img.shields.io/gem/v/kettle-soup-cover.svg
[🔑cc-mnt]: https://qlty.sh/gh/kettle-rb/projects/kettle-soup-cover
[🔑cc-mnti♻️]: https://qlty.sh/badges/75db1a51-b8ab-423a-b396-8b518067d8c3/maintainability.svg
[🔑cc-cov]: https://qlty.sh/gh/kettle-rb/projects/kettle-soup-cover
[🔑cc-covi♻️]: https://qlty.sh/badges/75db1a51-b8ab-423a-b396-8b518067d8c3/test_coverage.svg
[🔑codecov]: https://codecov.io/gh/kettle-rb/kettle-soup-cover
[🔑codecovi♻️]: https://codecov.io/gh/kettle-rb/kettle-soup-cover/branch/main/graph/badge.svg?token=0X5VEW9USD
[🔑coveralls]: https://coveralls.io/github/kettle-rb/kettle-soup-cover?branch=main
[🔑coveralls-img]: https://coveralls.io/repos/github/kettle-rb/kettle-soup-cover/badge.svg?branch=main
[🔑depfu]: https://depfu.com/github/kettle-rb/kettle-soup-cover?project_id=60302
[🔑depfui♻️]: https://badges.depfu.com/badges/71e1a65eafef1b12a044bf04bbea4f90/count.svg
[🖐codeQL]: https://github.com/kettle-rb/kettle-soup-cover/security/code-scanning
[🖐codeQL-img]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/codeql-analysis.yml/badge.svg
[🚎1-an-wf]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/ancient.yml
[🚎1-an-wfi]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/ancient.yml/badge.svg
[🚎2-cov-wf]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/coverage.yml
[🚎2-cov-wfi]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/coverage.yml/badge.svg
[🚎3-hd-wf]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/heads.yml
[🚎3-hd-wfi]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/heads.yml/badge.svg
[🚎4-lg-wf]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/legacy.yml
[🚎4-lg-wfi]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/legacy.yml/badge.svg
[🚎5-st-wf]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/style.yml
[🚎5-st-wfi]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/style.yml/badge.svg
[🚎6-s-wf]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/supported.yml
[🚎6-s-wfi]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/supported.yml/badge.svg
[🚎7-us-wf]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/unsupported.yml
[🚎7-us-wfi]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/unsupported.yml/badge.svg
[🚎8-ho-wf]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/hoary.yml
[🚎8-ho-wfi]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/hoary.yml/badge.svg
[🚎11-c-wf]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/current.yml
[🚎11-c-wfi]: https://github.com/kettle-rb/kettle-soup-cover/actions/workflows/current.yml/badge.svg
[⛳liberapay-img]: https://img.shields.io/liberapay/patrons/pboling.svg?logo=liberapay
[⛳liberapay]: https://liberapay.com/pboling/donate
[🖇sponsor-img]: https://img.shields.io/badge/Sponsor_Me!-pboling.svg?style=social&logo=github
[🖇sponsor]: https://github.com/sponsors/pboling
[🖇polar-img]: https://polar.sh/embed/seeks-funding-shield.svg?org=pboling
[🖇polar]: https://polar.sh/pboling
[🖇kofi-img]: https://img.shields.io/badge/buy_me_coffee-donate-yellow.svg
[🖇kofi]: https://ko-fi.com/O5O86SNP4
[🖇patreon-img]: https://img.shields.io/badge/patreon-donate-yellow.svg
[🖇patreon]: https://patreon.com/galtzo
[💎ruby-2.7i]: https://img.shields.io/badge/Ruby-2.7-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.0i]: https://img.shields.io/badge/Ruby-3.0-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.1i]: https://img.shields.io/badge/Ruby-3.1-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.2i]: https://img.shields.io/badge/Ruby-3.2-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.3i]: https://img.shields.io/badge/Ruby-3.3-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-c-i]: https://img.shields.io/badge/Ruby-current-CC342D?style=for-the-badge&logo=ruby&logoColor=green
[💎ruby-headi]: https://img.shields.io/badge/Ruby-HEAD-CC342D?style=for-the-badge&logo=ruby&logoColor=blue
[🤝issues]: https://github.com/kettle-rb/kettle-soup-cover/issues
[🤝pulls]: https://github.com/kettle-rb/kettle-soup-cover/pulls
[🤝contributing]: CONTRIBUTING.md
[🔑codecov-g♻️]: https://codecov.io/gh/kettle-rb/kettle-soup-cover/graphs/tree.svg?token=0X5VEW9USD
[🖐contrib-rocks]: https://contrib.rocks
[🖐contributors]: https://github.com/kettle-rb/kettle-soup-cover/graphs/contributors
[🖐contributors-img]: https://contrib.rocks/image?repo=kettle-rb/kettle-soup-cover
[🚎contributors-gl]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/graphs/main
[🪇conduct]: CODE_OF_CONDUCT.md
[🪇conduct-img]: https://img.shields.io/badge/Contributor_Covenant-2.1-4baaaa.svg
[📌pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint
[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-FFDD67.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📌changelog]: CHANGELOG.md
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-FFDD67.svg?style=flat
[🧮kloc]: https://www.youtube.com/watch?v=dQw4w9WgXcQ
[🧮kloc-img]: https://img.shields.io/badge/KLOC-0.075-FFDD67.svg?style=for-the-badge&logo=YouTube&logoColor=blue
[🔐security]: SECURITY.md
[🔐security-img]: https://img.shields.io/badge/security-policy-brightgreen.svg?style=flat
[📄copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year
[📄license]: LICENSE.txt
[📄license-ref]: https://opensource.org/licenses/MIT
[📄license-img]: https://img.shields.io/badge/License-MIT-green.svg
[📄ilo-declaration]: https://www.ilo.org/declaration/lang--en/index.htm
[📄ilo-declaration-img]: https://img.shields.io/badge/ILO_Fundamental_Principles-✓-brightgreen.svg?style=flat
[🚎yard-current]: http://rubydoc.info/gems/kettle-soup-cover
[🚎yard-head]: https://rubydoc.info/github/kettle-rb/kettle-soup-cover/main
[🖇buyme-img]: https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20latte&emoji=&slug=pboling&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff
[🖇buyme]: https://www.buymeacoffee.com/pboling
[🖇buyme-small-img]: https://img.shields.io/badge/Buy--Me--A--Coffee-✓-brightgreen.svg?style=flat
