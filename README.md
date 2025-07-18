<p align="center">
  <a href="https://discord.gg/3qme4XHNKN" target="_blank" rel="noopener">
    <img width="124px" src="https://github.com/galtzo-floss/shields-badge/raw/main/docs/images/logo/galtzo-floss-logos-original.svg?raw=true" alt="Galtzo.com Logo by Aboling0, CC BY-SA 4.0">
  </a>
  <a href="https://kettle-rb.gitlab.io/" target="_blank" rel="noopener">
    <img height="120px" src="https://kettle-rb.gitlab.io/assets/img/logos/logo-name-optimized.png" alt="kettle-rb logo, Copyright (c) 2023 Peter Boling, CC BY-SA 4.0, see https://kettle-rb.gitlab.io/logos">
  </a>
  <a href="https://www.ruby-lang.org/" target="_blank" rel="noopener">
    <img width="124px" src="https://github.com/galtzo-floss/shields-badge/raw/main/docs/images/logo/ruby-logo-198px.svg?raw=true" alt="Yukihiro Matsumoto, Ruby Visual Identity Team, CC BY-SA 2.5">
  </a>
</p>

# 🥘 Kettle::Soup::Cover

[![Version][👽versioni]][👽version] [![License: MIT][📄license-img]][📄license-ref] [![Downloads Rank][👽dl-ranki]][👽dl-rank] [![Open Source Helpers][👽oss-helpi]][👽oss-help] [![Depfu][🔑depfui♻️]][🔑depfu] [![Coveralls Test Coverage][🔑coveralls-img]][🔑coveralls] [![CodeCov Test Coverage][🔑codecovi♻️]][🔑codecov] [![QLTY Test Coverage][🔑qlty-covi♻️]][🔑qlty-cov] [![QLTY Maintainability][🔑qlty-mnti♻️]][🔑qlty-mnt] [![CI Heads][🚎3-hd-wfi]][🚎3-hd-wf] [![CI Current][🚎11-c-wfi]][🚎11-c-wf] [![CI Supported][🚎6-s-wfi]][🚎6-s-wf] [![CI Legacy][🚎4-lg-wfi]][🚎4-lg-wf] [![CI Unsupported][🚎7-us-wfi]][🚎7-us-wf] [![CI Test Coverage][🚎2-cov-wfi]][🚎2-cov-wf] [![CI Style][🚎5-st-wfi]][🚎5-st-wf]

---

[![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Buy me a coffee][🖇buyme-small-img]][🖇buyme] [![Donate on Polar][🖇polar-img]][🖇polar] [![Donate to my FLOSS or refugee efforts at ko-fi.com][🖇kofi-img]][🖇kofi] [![Donate to my FLOSS or refugee efforts using Patreon][🖇patreon-img]][🖇patreon]

Four lines of code to get a configured, curated, opinionated, set of dependencies for Test Coverage, and that's *including* the two lines for `require "simplecov"`, and `SimpleCov.start`.

Configured for what?  To work out of the box on every CI*.  Batteries included.
For apps and libraries.  Any test framework.  Many code coverage related GitHub Actions (example configs [1](#marocchinosticky-pull-request-comment), [2](#irongutcodecoveragesummary)).

| Test Framework | Helper                      | Config                        |
|----------------|-----------------------------|-------------------------------|
| MiniTest       | [test helper][mini-helper]  | [.simplecov][mini-simplecov]  |
| RSpec          | [spec helper][rpsec-helper] | [.simplecov][rspec-simplecov] |

[mini-helper]: https://github.com/pboling/silent_stream/blob/master/tests/test_silent_stream.rb
[mini-simplecov]: https://github.com/pboling/silent_stream/blob/master/.simplecov
[rpsec-helper]: https://github.com/oauth-xx/oauth2/blob/main/spec/spec_helper.rb
[rspec-simplecov]: https://github.com/oauth-xx/oauth2/blob/main/.simplecov

## 📔 DO YOU LIKE PATTERNS?!? 📔

This library's local dev / testing / CI dependency structure serves as an example of a "modular gemfile" pattern
enabling a discrete gemfile for each CI workflow.

This modular pattern has the following benefits:

- All dependencies are DRY, never repeated.
- All modular gemfiles are shared between the main `Gemfile`, and the workflow `gemfiles/*.gemfile`s that need them.
- All gemfiles source from the `gemspec`.

For another example of this pattern see the [kettle-soup-cover](https://github.com/kettle-rb/kettle-soup-cover) gem.

If you like this idea, there is an even better alternative.

I've codified it for reuse in my [appraisal2](https://github.com/appraisal-rb/appraisal2/) gem,
which is a hard fork of the venerable `appraisal` gem due to that gem's lack of support for modular gemfiles.

📔 ME TOO! 📔

| Federated [DVCS][💎d-in-dvcs] Repository               | Status                                                            | Issues                    | PRs                      | Wiki                      | CI                       | Discussions                  |
|--------------------------------------------------------|-------------------------------------------------------------------|---------------------------|--------------------------|---------------------------|--------------------------|------------------------------|
| 🧪 [kettle-rb/kettle-soup-cover on GitLab][📜src-gl]   | The Truth                                                         | [💚][🤝gl-issues]         | [💚][🤝gl-pulls]         | [💚][📜wiki]              | 🏀 Tiny Matrix           | ➖                            |
| 🧊 [kettle-rb/kettle-soup-cover on CodeBerg][📜src-cb] | An Ethical Mirror ([Donate][🤝cb-donate])                         | ➖                         | [💚][🤝cb-pulls]         | ➖                         | ⭕️ No Matrix             | ➖                            |
| 🐙 [kettle-rb/kettle-soup-cover on GitHub][📜src-gh]   | A Dirty Mirror                                                    | [💚][🤝gh-issues]         | [💚][🤝gh-pulls]         | ➖      | 💯 Full Matrix           | [💚][gh-discussions]                            |
| 🎮️ [Discord Server][✉️discord-invite]                 | [![Live Chat on Discord][✉️discord-invite-img]][✉️discord-invite] | [Let's][✉️discord-invite] | [talk][✉️discord-invite] | [about][✉️discord-invite] | [this][✉️discord-invite] | [library!][✉️discord-invite] |

[gh-discussions]: https://github.com/kettle-rb/kettle-soup-cover/discussions

One of the major benefits of using this library is not having to figure
out how to get multiple coverage output formats working.  I did that for you,
and I got all of them working, at the same time together, or al la carte. Kum-ba-ya.

A quick shot of 12-factor coverage power, straight to your brain:

```console
export K_SOUP_COV_DO=true # Means you want code coverage
export K_SOUP_COV_FORMATTERS="html,tty" # Set to some slice of "html,xml,rcov,lcov,json,tty"
export K_SOUP_COV_MIN_BRANCH=53 # Means you want to enforce X% branch coverage
export K_SOUP_COV_MIN_HARD=true # Means you want the build to fail if the coverage thresholds are not met
export K_SOUP_COV_MIN_LINE=69 # Means you want to enforce X% line coverage
export MAX_ROWS=5 # Setting for simplecov-console gem for tty output, limits to the worst N rows of bad coverage
```

I hope I've piqued your interest enough to give it a ⭐️ if the forge you are on supports it.

<details>
  <summary>What does the name mean?</summary>

A Covered Kettle of SOUP (Software of Unknown Provenance)

The name is derived in part from the medical devices field,
where this library is considered a package of [SOUP](https://en.wikipedia.org/wiki/Software_of_unknown_pedigree).

</details>

## Format / Library x CI Matrix

This tool leverages other tools to make hard things easier, but sometimes those other tools break...
I'll try to track that here.

| Format | Library                    | Status | Web | Circle<br/>CI | Git<br/>Lab | Travis<br/>CI | Jenkins<br/>X | Jenkins | Hudson | Semaphore | Bit<br/>Bucket | Team<br/>City | 🤓<br/>Nerds |
|--------|----------------------------|--------|-----|---------------|-------------|---------------|---------------|---------|--------|-----------|----------------|---------------|--------------|
| `html` | `simplecov-html`           | ✅      | ✅   |               |             |               |               |         |        |           |                |               | ✅            |
| `xml`  | `simplecov-cobertura`      | ✅      |     |               | ✅           |               |               | ✅       |        |           |                |               | ✅            |
| `rcov` | `simplecov-rcov`           | ✅      |     |               |             |               |               |         | ✅      |           |                |               | ✅            |
| `lcov` | `simplecov-lcov`           | ✅      |     | ✅             |             | ✅             | ✅             |         |        | ✅         |                | ✅             | ✅            |
| `json` | `simplecov_json_formatter` | ✅      |     | ✅             |             | ✅             | ✅             |         |        |           | ✅              |               | ✅            |
| `tty`  | `simplecov-console`        | ✅      |     |               |             |               |               |         |        |           |                |               | ✅            |

If you find this working/not working different than above please open an issue / PR!

## ☝️ Not actually *every CI*

This gem does not add coverage parsing to CI's that don't have it, since that's impossible.
Vendor-specific formats which are not shared by other vendors are also not supported (e.g. BuildKite).

You'll have to configure them manually if you use them:

* BuildKite's custom [simplecov extension][buildkite-ext]
* GitHub Actions doesn't parse test output, but...
  * I configure my `coverage` workflow ([see example][example-cov-wf]) to upload coverage reports to SaaS services like:
    * [codecov.io][🔑codecov] (has tokenless OIDC option!)
    * [QLTY.sh](https://qlty.sh) (needs token for upload)
    * [coveralls.io][🔑coveralls]
  * This gem helps me configure my `coverage` workflow to use Github Actions designed to report coverage like:
    * Repo: [irongut/CodeCoverageSummary][GHA-ccs-repo]
    * Repo: [marocchino/sticky-pull-request-comment][GHA-sprc-repo]


[buildkite-ext]: https://github.com/buildkite/simplecov-buildkite
[example-cov-wf]: https://github.com/kettle-rb/kettle-soup-cover/blob/main/.github/workflows/coverage.yml

This library is based on ideas I originally introduced in the gem _[rspec-stubbed_env](https://github.com/pboling/rspec-stubbed_env)_.

## 💡 Info you can shake a stick at

| Tokens to Remember    | [![Gem name][⛳️name-img]][⛳️gem-name] [![Gem namespace][⛳️namespace-img]][⛳️gem-namespace]                                                                                                                                                                                                                                                                                                                                                                          |
|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Works with MRI Ruby 3 | [![Ruby 3.0 Compat][💎ruby-3.0i]][🚎4-lg-wf] [![Ruby 3.1 Compat][💎ruby-3.1i]][🚎6-s-wf] [![Ruby 3.2 Compat][💎ruby-3.2i]][🚎6-s-wf] [![Ruby 3.3 Compat][💎ruby-3.3i]][🚎6-s-wf] [![Ruby 3.4 Compat][💎ruby-c-i]][🚎11-c-wf] [![Ruby HEAD Compat][💎ruby-headi]][🚎3-hd-wf]                                                                                                                                                                                         |
| Works with MRI Ruby 2 | [![Ruby 2.7 Compat][💎ruby-2.7i]][🚎7-us-wf]                                                                                                                                                                                                                                                                                                                                                                                                                        |
| Source                | [![Source on GitLab.com][📜src-gl-img]][📜src-gl] [![Source on CodeBerg.org][📜src-cb-img]][📜src-cb] [![Source on Github.com][📜src-gh-img]][📜src-gh] [![The best SHA: dQw4w9WgXcQ!][🧮kloc-img]][🧮kloc]                                                                                                                                                                                                                                                         |
| Documentation         | [![Current release on RubyDoc.info][📜docs-cr-rd-img]][🚎yard-current] [![YARD on Galtzo.com][📜docs-head-rd-img]][🚎yard-head] [![BDFL Blog][🚂bdfl-blog-img]][🚂bdfl-blog] [![Wiki][📜wiki-img]][📜wiki]                                                                                                                                                                                                                                                          |
| Compliance            | [![License: MIT][📄license-img]][📄license-ref] [![📄ilo-declaration-img]][📄ilo-declaration] [![Security Policy][🔐security-img]][🔐security] [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct] [![SemVer 2.0.0][📌semver-img]][📌semver]                                                                                                                                                                                                                    |
| Style                 | [![Enforced Code Style Linter][💎rlts-img]][💎rlts] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog] [![Gitmoji Commits][📌gitmoji-img]][📌gitmoji]                                                                                                                                                                                                                                                                                              |
| Support               | [![Live Chat on Discord][✉️discord-invite-img]][✉️discord-invite] [![Get help from me on Upwork][👨🏼‍🏫expsup-upwork-img]][👨🏼‍🏫expsup-upwork] [![Get help from me on Codementor][👨🏼‍🏫expsup-codementor-img]][👨🏼‍🏫expsup-codementor]                                                                                                                                                                                                                       |
| Enterprise Support    | [![Get help from me on Tidelift][🏙️entsup-tidelift-img]][🏙️entsup-tidelift]<br/>💡Subscribe for support guarantees covering _all_ FLOSS dependencies!<br/>💡Tidelift is part of [Sonar][🏙️entsup-tidelift-sonar]!<br/>💡Tidelift pays maintainers to maintain the software you depend on!<br/>📊`@`Pointy Haired Boss: An [enterprise support][🏙️entsup-tidelift] subscription is "[never gonna let you down][🧮kloc]", and *supports* open source maintainers! |
| Comrade BDFL 🎖️      | [![Follow Me on LinkedIn][💖🖇linkedin-img]][💖🖇linkedin] [![Follow Me on Ruby.Social][💖🐘ruby-mast-img]][💖🐘ruby-mast] [![Follow Me on Bluesky][💖🦋bluesky-img]][💖🦋bluesky] [![Contact BDFL][🚂bdfl-contact-img]][🚂bdfl-contact] [![My technical writing][💖💁🏼‍♂️devto-img]][💖💁🏼‍♂️devto]                                                                                                                                                              |
| `...` 💖              | [![Find Me on WellFound:][💖✌️wellfound-img]][💖✌️wellfound] [![Find Me on CrunchBase][💖💲crunchbase-img]][💖💲crunchbase] [![My LinkTree][💖🌳linktree-img]][💖🌳linktree] [![More About Me][💖💁🏼‍♂️aboutme-img]][💖💁🏼‍♂️aboutme] [🧊][💖🧊berg] [🐙][💖🐙hub]  [🛖][💖🛖hut] [🧪][💖🧪lab]                                                                                                                                                                   |

## ✨ Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add kettle-soup-cover

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install kettle-soup-cover

### 🔒 Secure Installation

`kettle-soup-cover` is cryptographically signed, and has verifiable [SHA-256 and SHA-512][💎SHA_checksums] checksums by
[stone_checksums][💎stone_checksums]. Be sure the gem you install hasn’t been tampered with
by following the instructions below.

Add my public key (if you haven’t already, expires 2045-04-29) as a trusted certificate:

```console
gem cert --add <(curl -Ls https://raw.github.com/kettle-rb/kettle-soup-cover/main/certs/pboling.pem)
```

You only need to do that once.  Then proceed to install with:

```console
gem install kettle-soup-cover -P MediumSecurity
```

The `MediumSecurity` trust profile will verify signed gems, but allow the installation of unsigned dependencies.

This is necessary because not all of `kettle-soup-cover`’s dependencies are signed, so we cannot use `HighSecurity`.

If you want to up your security game full-time:

```console
bundle config set --global trust-policy MediumSecurity
```

NOTE: Be prepared to track down certs for signed gems and add them the same way you added mine.

## 🔧 Basic Usage

### RSpec or MiniTest

In your `spec/spec_helper.rb` or `tests/test_helper.rb`, just before loading the library under test,
add two lines of code:

### With Ruby 2.7+

```ruby
require "kettle-soup-cover"
require "simplecov" if Kettle::Soup::Cover::DO_COV # `.simplecov` is run here!
# IMPORTANT: If you are using MiniTest instead of RSpec, also do this (and not in .simplecov):
# SimpleCov.external_at_exit = true
```

### Projects that run tests against older Ruby versions, e.g. with Appraisals

```ruby
# NOTE: Gemfiles for older rubies won't have kettle-soup-cover.
#       The rescue LoadError handles that scenario.
begin
  require "kettle-soup-cover"

  if Kettle::Soup::Cover::DO_COV
    require "simplecov" # `.simplecov` is run here!

    # IMPORTANT: If you are using MiniTest instead of RSpec, also do this (and not in .simplecov):
    # SimpleCov.external_at_exit = true
  end
rescue LoadError => error
  # check the error message, if you are so inclined, and re-raise if not what is expected
  raise error unless error.message.include?("kettle")
end
```

### All projects

In your `.simplecov` file, add 2 lines of code:

```ruby
require "kettle/soup/cover/config" # 12-factor, ENV-based configuration, with good defaults!
# you could do this somewhere else, up to you, but you do have to do it somewhere
SimpleCov.start
```

See [Advanced Usage](#advanced-usage) below for more info,
but the simplest thing is to run all the coverage things,
which is configured by default on CI.  To replicate that locally you could:

```console
CI=true bundle exec rake test # or whatever command you run for tests.
```

That's it!

### Rakefile

You'll need to have your `test` task defined.
If you use `spec` instead, you can make it a pre-requisite of the `test` task with:

```ruby
desc "run spec task with test task"
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

```console
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
K_SOUP_COV_OPEN_BIN
K_SOUP_COV_USE_MERGING
K_SOUP_COV_VERBOSE
```

Additionally, some of the included gems, like [`simplecov-console`][simplecov-console],
have their own complete suite of ENV variables you can configure.

[env-constants]: /lib/kettle/soup/cover.rb
[simplecov-console]: https://github.com/chetan/simplecov-console#options

#### Compatible with GitHub Actions for Code Coverage feedback in pull requests

If you don't want to configure a SaaS service to update your pull requests with
code coverage there are alternatives.

After the step that runs your test suite use one or more of the following.

##### irongut/CodeCoverageSummary

Repo: [irongut/CodeCoverageSummary][GHA-ccs-repo]

[GHA-ccs-repo]: https://github.com/irongut/CodeCoverageSummary

```yaml

      - name: Code Coverage Summary Report
        uses: irongut/CodeCoverageSummary@v1.3.0
        if: ${{ github.event_name == 'pull_request' }}
        with:
          filename: ./coverage/coverage.xml
          badge: true
          fail_below_min: true
          format: markdown
          hide_branch_rate: false
          hide_complexity: true
          indicators: true
          output: both
          thresholds: '100 100' # '<MIN LINE COVERAGE> <MIN BRANCH COVERAGE>'
        continue-on-error: ${{ matrix.experimental != 'false' }}
```

##### *marocchino/sticky-pull-request-comment*

Repo: [marocchino/sticky-pull-request-comment][GHA-sprc-repo]

[GHA-sprc-repo]: https://github.com/marocchino/sticky-pull-request-comment

```yaml
      - name: Add Coverage PR Comment
        uses: marocchino/sticky-pull-request-comment@v2
        if: ${{ github.event_name == 'pull_request' }}
        with:
          recreate: true
          path: code-coverage-results.md
        continue-on-error: ${{ matrix.experimental != 'false' }}
```

## 🔐 Security

See [SECURITY.md][🔐security].

## 🤝 Contributing

If you need some ideas of where to help, you could work on adding more code coverage,
or if it is already 💯 (see [below](#code-coverage)) check [issues][🤝gh-issues], or [PRs][🤝gh-pulls],
or use the gem and think about how it could be better.

We [![Keep A Changelog][📗keep-changelog-img]][📗keep-changelog] so if you make changes, remember to update it.

See [CONTRIBUTING.md][🤝contributing] for more detailed instructions.

### 🚀 Release Instructions

See [CONTRIBUTING.md][🤝contributing].

### Code Coverage

[![Coverage Graph][🔑codecov-g♻️]][🔑codecov]

### 🪇 Code of Conduct

Everyone interacting with this project's codebases, issue trackers,
chat rooms and mailing lists agrees to follow the [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct].

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

- Jordan Harband (@ljharb, maintainer of SemVer) [in SemVer issue 716][📌semver-breaking]

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

See [CHANGELOG.md][📌changelog] for a list of releases.

## 📄 License

The gem is available as open source under the terms of
the [MIT License][📄license] [![License: MIT][📄license-img]][📄license-ref].
See [LICENSE.txt][📄license] for the official [Copyright Notice][📄copyright-notice-explainer].

### © Copyright

<ul>
    <li>
        Copyright (c) 2023-2025 Peter H. Boling, of
        <a href="https://discord.gg/3qme4XHNKN">
            Galtzo.com
            <picture>
              <img src="https://github.com/galtzo-floss/shields-badge/raw/main/docs/images/logo/galtzo-floss-logos-wordless.svg?raw=true" alt="Galtzo.com Logo by Aboling0, CC BY-SA 4.0" width="24">
            </picture>
        </a>, and kettle-soup-cover contributors
    </li>
</ul>

## 🤑 One more thing

Having arrived at the bottom of the page, please endure a final supplication.
The primary maintainer of this gem, Peter Boling, wants
Ruby to be a great place for people to solve problems, big and small.
Please consider supporting his efforts via the giant yellow link below,
or one of smaller ones, depending on button size preference.

[![Buy me a latte][🖇buyme-img]][🖇buyme]

[![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Donate on Polar][🖇polar-img]][🖇polar] [![Donate to my FLOSS or refugee efforts at ko-fi.com][🖇kofi-img]][🖇kofi] [![Donate to my FLOSS or refugee efforts using Patreon][🖇patreon-img]][🖇patreon]

P.S. If you need help️, or want to say thanks, 👇 Join the Discord.

[![Live Chat on Discord][✉️discord-invite-img]][✉️discord-invite]

[⛳liberapay-img]: https://img.shields.io/liberapay/goal/pboling.svg?logo=liberapay
[⛳liberapay]: https://liberapay.com/pboling/donate
[🖇sponsor-img]: https://img.shields.io/badge/Sponsor_Me!-pboling.svg?style=social&logo=github
[🖇sponsor]: https://github.com/sponsors/pboling
[🖇polar-img]: https://img.shields.io/badge/polar-donate-yellow.svg
[🖇polar]: https://polar.sh/pboling
[🖇kofi-img]: https://img.shields.io/badge/a_more_different_coffee-✓-yellow.svg
[🖇kofi]: https://ko-fi.com/O5O86SNP4
[🖇patreon-img]: https://img.shields.io/badge/patreon-donate-yellow.svg
[🖇patreon]: https://patreon.com/galtzo
[🖇buyme-small-img]: https://img.shields.io/badge/buy_me_a_coffee-✓-yellow.svg?style=flat
[🖇buyme-img]: https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20latte&emoji=&slug=pboling&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff
[🖇buyme]: https://www.buymeacoffee.com/pboling
[✉️discord-invite]: https://discord.gg/3qme4XHNKN
[✉️discord-invite-img]: https://img.shields.io/discord/1373797679469170758?style=for-the-badge

[✇bundle-group-pattern]: https://gist.github.com/pboling/4564780
[⛳️gem-namespace]: https://github.com/kettle-rb/kettle-soup-cover
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
[💖🦋bluesky]: https://bsky.app/profile/galtzo.com
[💖🦋bluesky-img]: https://img.shields.io/badge/@galtzo.com-0285FF?style=flat&logo=bluesky&logoColor=white
[💖🌳linktree]: https://linktr.ee/galtzo
[💖🌳linktree-img]: https://img.shields.io/badge/galtzo-purple?style=flat&logo=linktree
[💖💁🏼‍♂️devto]: https://dev.to/galtzo
[💖💁🏼‍♂️devto-img]: https://img.shields.io/badge/dev.to-0A0A0A?style=flat&logo=devdotto&logoColor=white
[💖💁🏼‍♂️aboutme]: https://about.me/peter.boling
[💖💁🏼‍♂️aboutme-img]: https://img.shields.io/badge/about.me-0A0A0A?style=flat&logo=aboutme&logoColor=white
[💖🧊berg]: https://codeberg.org/pboling
[💖🐙hub]: https://github.org/pboling
[💖🛖hut]: https://sr.ht/~galtzo/
[💖🧪lab]: https://gitlab.com/pboling
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
[📜src-cb-img]: https://img.shields.io/badge/CodeBerg-4893CC?style=for-the-badge&logo=CodeBerg&logoColor=blue
[📜src-cb]: https://codeberg.org/kettle-rb/kettle-soup-cover
[📜src-gh-img]: https://img.shields.io/badge/GitHub-238636?style=for-the-badge&logo=Github&logoColor=green
[📜src-gh]: https://github.com/kettle-rb/kettle-soup-cover
[📜docs-cr-rd-img]: https://img.shields.io/badge/RubyDoc-Current_Release-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜docs-head-rd-img]: https://img.shields.io/badge/YARD_on_Galtzo.com-HEAD-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜wiki]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/wikis/home
[📜wiki-img]: https://img.shields.io/badge/wiki-examples-943CD2.svg?style=for-the-badge&logo=Wiki&logoColor=white
[👽dl-rank]: https://rubygems.org/gems/kettle-soup-cover
[👽dl-ranki]: https://img.shields.io/gem/rd/kettle-soup-cover.svg
[👽oss-help]: https://www.codetriage.com/kettle-rb/kettle-soup-cover
[👽oss-helpi]: https://www.codetriage.com/kettle-rb/kettle-soup-cover/badges/users.svg
[👽version]: https://rubygems.org/gems/kettle-soup-cover
[👽versioni]: https://img.shields.io/gem/v/kettle-soup-cover.svg
[🔑qlty-mnt]: https://qlty.sh/gh/kettle-rb/projects/kettle-soup-cover
[🔑qlty-mnti♻️]: https://qlty.sh/badges/75db1a51-b8ab-423a-b396-8b518067d8c3/maintainability.svg
[🔑qlty-cov]: https://qlty.sh/gh/kettle-rb/projects/kettle-soup-cover
[🔑qlty-covi♻️]: https://qlty.sh/badges/75db1a51-b8ab-423a-b396-8b518067d8c3/test_coverage.svg
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
[💎ruby-2.7i]: https://img.shields.io/badge/Ruby-2.7-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.0i]: https://img.shields.io/badge/Ruby-3.0-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.1i]: https://img.shields.io/badge/Ruby-3.1-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.2i]: https://img.shields.io/badge/Ruby-3.2-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.3i]: https://img.shields.io/badge/Ruby-3.3-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-c-i]: https://img.shields.io/badge/Ruby-current-CC342D?style=for-the-badge&logo=ruby&logoColor=green
[💎ruby-headi]: https://img.shields.io/badge/Ruby-HEAD-CC342D?style=for-the-badge&logo=ruby&logoColor=blue
[🤝gh-issues]: https://github.com/kettle-rb/kettle-soup-cover/issues
[🤝gh-pulls]: https://github.com/kettle-rb/kettle-soup-cover/pulls
[🤝gl-issues]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/issues
[🤝gl-pulls]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/merge_requests
[🤝cb-issues]: https://codeberg.org/kettle-rb/kettle-soup-cover/issues
[🤝cb-pulls]: https://codeberg.org/kettle-rb/kettle-soup-cover/pulls
[🤝cb-donate]: https://donate.codeberg.org/
[🤝contributing]: CONTRIBUTING.md
[🔑codecov-g♻️]: https://codecov.io/gh/kettle-rb/kettle-soup-cover/graphs/tree.svg?token=0X5VEW9USD
[🖐contrib-rocks]: https://contrib.rocks
[🖐contributors]: https://github.com/kettle-rb/kettle-soup-cover/graphs/contributors
[🖐contributors-img]: https://contrib.rocks/image?repo=kettle-rb/kettle-soup-cover
[🚎contributors-gl]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/graphs/main
[🪇conduct]: CODE_OF_CONDUCT.md
[🪇conduct-img]: https://img.shields.io/badge/Contributor_Covenant-2.1-259D6C.svg
[📌pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint
[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-259D6C.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📌changelog]: CHANGELOG.md
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-34495e.svg?style=flat
[📌gitmoji]:https://gitmoji.dev
[📌gitmoji-img]:https://img.shields.io/badge/gitmoji_commits-%20😜%20😍-34495e.svg?style=flat-square
[🧮kloc]: https://www.youtube.com/watch?v=dQw4w9WgXcQ
[🧮kloc-img]: https://img.shields.io/badge/KLOC-0.137-FFDD67.svg?style=for-the-badge&logo=YouTube&logoColor=blue
[🔐security]: SECURITY.md
[🔐security-img]: https://img.shields.io/badge/security-policy-259D6C.svg?style=flat
[📄copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year
[📄license]: LICENSE.txt
[📄license-ref]: https://opensource.org/licenses/MIT
[📄license-img]: https://img.shields.io/badge/License-MIT-259D6C.svg
[📄ilo-declaration]: https://www.ilo.org/declaration/lang--en/index.htm
[📄ilo-declaration-img]: https://img.shields.io/badge/ILO_Fundamental_Principles-✓-259D6C.svg?style=flat
[🚎yard-current]: http://rubydoc.info/gems/kettle-soup-cover
[🚎yard-head]: https://kettle-soup-cover.galtzo.com
[💎stone_checksums]: https://github.com/pboling/stone_checksums
[💎SHA_checksums]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/tree/main/checksums
[💎rlts]: https://github.com/rubocop-lts/rubocop-lts
[💎rlts-img]: https://img.shields.io/badge/code_style_%26_linting-rubocop--lts-34495e.svg?plastic&logo=ruby&logoColor=white
[💎d-in-dvcs]: https://railsbling.com/posts/dvcs/put_the_d_in_dvcs/
