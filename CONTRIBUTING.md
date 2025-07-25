# Contributing

Bug reports and pull requests are welcome on GitLab at [https://gitlab.com/kettle-rb/kettle-soup-cover][🚎src-main]
. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct][🤝conduct].

To submit a patch, please fork the project and create a patch with tests.
Once you're happy with it send a pull request.

We [![Keep A Changelog][📗keep-changelog-img]][📗keep-changelog] so if you make changes, remember to update it.

## You can help!

Simply follow these instructions:

1. Join the Discord: [![Live Chat on Discord][✉️discord-invite-img]][✉️discord-invite]
2. Fork the repository
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Make some fixes.
5. Commit your changes (`git commit -am 'Added some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Make sure to add tests for it. This is important, so it doesn't break in a future release.
8. Create new Pull Request.
9. Announce it in the channel for this org in the [Discord][✉️discord-invite]!

## The Reek List

Take a look at the `reek` list which is the file called `REEK` and find something to improve.

To refresh the `reek` list:

```console
bundle exec reek > REEK
```

## Run Tests

To run all tests

```console
bundle exec rake test
```

## Lint It

Run all the default tasks, which includes running the gradually autocorrecting linter, `rubocop-gradual`.

```console
bundle exec rake
```

Or just run the linter.

```console
bundle exec rake rubocop_gradual:autocorrect
```

## Contributors

Your picture could be here!

[![Contributors][🖐contributors-img]][🖐contributors]

Made with [contributors-img][🖐contrib-rocks].

Also see GitLab Contributors: [https://gitlab.com/kettle-rb/kettle-soup-cover/-/graphs/main][🚎contributors-gl]

## For Maintainers

### One-time, Per-maintainer, Setup

**IMPORTANT**: If you want to sign the build you create,
your public key for signing gems will need to be picked up by the line in the
`gemspec` defining the `spec.cert_chain` (check the relevant ENV variables there).
All releases to RubyGems.org will be signed.
See: [RubyGems Security Guide][🔒️rubygems-security-guide]

NOTE: To build without signing the gem you must set `SKIP_GEM_SIGNING` to some value in your environment.

### To release a new version:

1. Run `bin/setup && bin/rake` as a tests, coverage, & linting sanity check
2. Update the version number in `version.rb`, and ensure `CHANGELOG.md` reflects changes
3. Run `bin/setup && bin/rake` again as a secondary check, and to update `Gemfile.lock`
4. Run `git commit -am "🔖 Prepare release v<VERSION>"` to commit the changes
5. Run `git push` to trigger the final CI pipeline before release, & merge PRs
    - NOTE: Remember to [check the build][🧪build]!
6. Run `export GIT_TRUNK_BRANCH_NAME="$(git remote show origin | grep 'HEAD branch' | cut -d ' ' -f5)" && echo $GIT_TRUNK_BRANCH_NAME`
7. Run `git checkout $GIT_TRUNK_BRANCH_NAME`
8. Run `git pull origin $GIT_TRUNK_BRANCH_NAME` to ensure you will release the latest trunk code
9. Set `SOURCE_DATE_EPOCH` so `rake build` and `rake release` use same timestamp, and generate same checksums
    - Run `export SOURCE_DATE_EPOCH=$EPOCHSECONDS && echo $SOURCE_DATE_EPOCH`
    - If the echo above has no output, then it didn't work.
    - Note that you'll need the `zsh/datetime` module, if running `zsh`.
    - In older versions of `bash` you can use `date +%s` instead, i.e. `export SOURCE_DATE_EPOCH=$(date +%s) && echo $SOURCE_DATE_EPOCH`
10. Run `bundle exec rake build`
11. Run `bin/gem_checksums` (more context [1][🔒️rubygems-checksums-pr], [2][🔒️rubygems-guides-pr])
    to create SHA-256 and SHA-512 checksums. This functionality is provided by the `stone_checksums`
    [gem][💎stone_checksums].
    - Checksums will be committed automatically by the script, but not pushed
12. Run `bundle exec rake release` which will create a git tag for the version,
    push git commits and tags, and push the `.gem` file to [rubygems.org][💎rubygems]

[🚎src-main]: https://gitlab.com/kettle-rb/kettle-soup-cover
[🧪build]: https://github.com/kettle-rb/kettle-soup-cover/actions
[🤝conduct]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/blob/main/CODE_OF_CONDUCT.md
[🖐contrib-rocks]: https://contrib.rocks
[🖐contributors]: https://github.com/kettle-rb/kettle-soup-cover/graphs/contributors
[🚎contributors-gl]: https://gitlab.com/kettle-rb/kettle-soup-cover/-/graphs/main
[🖐contributors-img]: https://contrib.rocks/image?repo=kettle-rb/kettle-soup-cover
[💎rubygems]: https://rubygems.org
[🔒️rubygems-security-guide]: https://guides.rubygems.org/security/#building-gems
[🔒️rubygems-checksums-pr]: https://github.com/rubygems/rubygems/pull/6022
[🔒️rubygems-guides-pr]: https://github.com/rubygems/guides/pull/325
[💎stone_checksums]: https://github.com/pboling/stone_checksums
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-FFDD67.svg?style=flat
[✉️discord-invite]: https://discord.gg/3qme4XHNKN
[✉️discord-invite-img]: https://img.shields.io/discord/1373797679469170758?style=for-the-badge
