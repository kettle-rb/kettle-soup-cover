# Changelog

[![SemVer 2.0.0][📌semver-img]][📌semver] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog]

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][📗keep-changelog],
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html),
and [yes][📌major-versions-not-sacred], platform and engine support are part of the [public API][📌semver-breaking].
Please file a bug if you notice a violation of semantic versioning.

[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-FFDD67.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-FFDD67.svg?style=flat

## [Unreleased]

### Added

- When `ENV["MAX_ROWS"] == "0"`, explicitly, skip simplecov-console TTY output.
- Script `exe/kettle-soup-cover` generates coverage report
  - defaults to reading `$K_SOUP_COV_DIR/coverage.json`
  - prints a summarized report
  - accepts `-p/--path` or a positional path to coverage.json
  - requires the `json` formatter be configured in `$K_SOUP_COV_FORMATTERS` (or an explicit JSON path as above).

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [1.0.10] - 2025-07-15

- COVERAGE: 93.43% -- 128/137 lines in 10 files
- BRANCH COVERAGE: 50.00% -- 16/32 branches in 10 files
- 11.11% documented

### Added

- Add GitHub Pages site to badge info table
- YARD config, GFM compatible with relative file links
- Documentation site on GitHub Pages
  - [kettle-soup-cover.galtzo.com](https://kettle-soup-cover.galtzo.com)
- Auto-assign issues in the GitHub issue tracker

### Changed

- Updated `spec.homepage_uri` in gemspec to GitHub Pages YARD documentation site
- Updated contact email in gemspec to `floss@galtzo.com`
- Upgraded runtime dependency minimums:
  - simplecov-cobertura v3.0.0
  - simplecov-html v0.13.1
  - simplecov-rcov v0.3.7
  - simplecov-console v0.9.3
  - version_gem v1.1.8

## [1.0.9] - 2025-05-20

- COVERAGE: 93.43% -- 128/137 lines in 10 files
- BRANCH COVERAGE: 50.00% -- 16/32 branches in 10 files
- 11.11% documented

### Added

- YARD config, GFM compatible with relative file links
- Documentation site on GitHub Pages
  - [kettle-soup-cover.galtzo.com](https://kettle-soup-cover.galtzo.com)

### Changed

- Updated `spec.homepage_uri` in gemspec to GitHub Pages YARD documentation site

## [1.0.8] - 2025-05-20

- COVERAGE: 93.43% -- 128/137 lines in 10 files
- BRANCH COVERAGE: 50.00% -- 16/32 branches in 10 files
- 11.11% documented

### Added

- Link to discussions on GitHub

### Changed

- Fixed `spec.homepage` and `spec.source_code_uri` in gemspec

## [1.0.7] - 2025-05-20

- COVERAGE: 93.43% -- 128/137 lines in 10 files
- BRANCH COVERAGE: 50.00% -- 16/32 branches in 10 files
- 11.11% documented

### Added

- Document usage with minitest
- Document usage with https://github.com/irongut/CodeCoverageSummary
- Document usage with https://github.com/marocchino/sticky-pull-request-comment
- More documentation improvements
- Link to Discord

### Changed

 - Gem build: Don't check for cert if SKIP_GEM_SIGNING is set
   - Allows linux packaging systems to build gem without signing via rubygems
 - Update homepage in gemspec
 - Improved loading of version.rb in gemspec

## [1.0.6] - 2025-05-04

- COVERAGE: 93.43% -- 128/137 lines in 10 files
- BRANCH COVERAGE: 50.00% -- 16/32 branches in 10 files
- 11.11% documented

### Added

- Support for linux, and other OSes, in `coverage` rake task
  - previously was macOS only (would raise error on other OSes)
- ✨ `Kettle::Soup::Cover::OPEN_BIN`
  - Set `export K_SOUP_COV_OPEN_BIN=open` to use macOS' `open` command in `coverage` task
  - Set `export K_SOUP_COV_OPEN_BIN=xdg-open` to use Linux' `xdg-open` command in `coverage` task
  - Set `export K_SOUP_COV_OPEN_BIN=` to just print the path to the HTML coverage report in `coverage` task
- Test coverage increased from 55 => 93 for lines
- Test coverage increased from 25 => 50 for branches

### Changed

- Refactored internals in ways that should not affect public APIs
  - allows much greater test coverage
  - report a bug if anything breaks!
- Going forward all releases will be signed by my key that expires 2045-04-29

### Fixed

- require hooks such that both work equally well:
  - `require "kettle/soup/cover"`
  - `require "kettle-soup-cover"`
- Allow unsigned gem builds (for linux distros)
  - In the ENV set `SKIP_GEM_SIGNING` to any value

## [1.0.5] - 2025-04-03

### Added

- Documentation
- Support for malformed `K_SOUP_COV_FORMATTERS` (extra spaces)
- Code coverage tools QLTY, and CodeCov.io
- Added Ruby 3.3, 3.4 to CI

### Changed

- Update to Contributor Covenant 2.1
- Allow unsigned gem builds (for linux distros)
- Checksums are now created by `stone_checksums` gem

### Fixed

- Incorrect documentation of ENV variables that control gem behavior
- Prefer `Kernel.load` > `load` in gemspec
  - https://github.com/simplecov-ruby/simplecov/issues/557#issuecomment-2630782358

## [1.0.4] - 2024-06-11

### Added

- Documentation

### Changed

- `version_gem` requirement to 1.0.4

## [1.0.3] - 2024-05-23

### Added

- Documentation
- Mirror repo on GitHub: https://github.com/kettle-rb/kettle-soup-cover
- More tests

### Fixed

- Incorrect URLs for homepage, etc

## [1.0.2] - 2023-10-19

### Fixed

- Include new `coverage` rake task in the built gem
  - Goddamnit
- Try to get checksum for SHA-256 to match what is published on Rubygems.org

## [1.0.1] - 2023-10-19

### Fixed

- Include new `coverage` rake task in the built gem

## [1.0.0] - 2023-10-19

### Added

- ✨ `Regexp.escape` the `FILTER_DIRS` to allow for paths to be excluded from coverage
  - paths must always start at the root of the project, but no leading or trailing slash
- ✨ Rake task `coverage` will run spec suite, and open results in a browser.
- ✨ `Kettle::Soup::Cover::PREFIX` allows configuration of a custom ENV variable name prefix
  - Set `export K_SOUP_COV_DEBUG="K_SOUP_COV_"` (default shown)
- ✨ `Kettle::Soup::Cover::USE_MERGING`
  - Set `export K_SOUP_COV_USE_MERGING=true`
- ✨ `Kettle::Soup::Cover::MERGE_TIMEOUT`
  - Set `export K_SOUP_COV_MERGE_TIMEOUT=3600`
- ✨ `Kettle::Soup::Cover::DEBUG` - similar to `VERBOSE`, only moreso!
  - Set `export K_SOUP_COV_DEBUG=true`
  - NOTE: This gem actually has zero output statements.
    - The utility of `DEBUG` and `VERBOSE` being a part of this library is
      to normalize handling of this common logical need in other libraries.
- ✨ `Kettle::Soup::Cover.load_filters`
  - `Kettle::Soup::Cover::Filters::GtLineFilter`
  - `Kettle::Soup::Cover::Filters::LtLineFilter`
- More and better documentation

### Changed

- This gem no longer does `require "simplecov"`
  - Instead you can `require "simplecov" if Kettle::Soup::Cover::DO_COV` wherever you deem fit

### Fixed

- All ENV vars now begin with a uniform prefix for this gem:
  - `K_SOUP_COV_*`

## [0.1.0] - 2023-10-17
- Initial release

[Unreleased]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/compare/v1.0.10...HEAD
[1.0.10]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/compare/v1.0.9...v1.0.10
[1.0.9]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/compare/v1.0.8...v1.0.9
[1.0.8]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/compare/v1.0.7...v1.0.8
[1.0.7]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/compare/v1.0.6...v1.0.7
[1.0.6]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/compare/v1.0.5...v1.0.6
[1.0.5]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/compare/v1.0.4...v1.0.5
[1.0.4]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/compare/v1.0.3...v1.0.4
[1.0.3]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/compare/v1.0.2...v1.0.3
[1.0.2]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/compare/v1.0.1...v1.0.2
[1.0.1]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/compare/v1.0.0...v1.0.1
[1.0.0]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/compare/v0.1.0...v1.0.0
[0.1.0]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/compare/97ddbbca309b87c7f6eed0137b08cad74ec81235...v0.1.0
