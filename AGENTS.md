# AGENTS.md - Development Guide

## 🎯 Project Overview

### Code Quality

```bash
mise exec -C /path/to/project -- bundle exec rake reek
mise exec -C /path/to/project -- bundle exec rubocop-gradual
```

### Releasing

```bash
bin/kettle-pre-release    # Validate everything before release
bin/kettle-release        # Full release workflow
```

## 📝 Project Conventions

### Freeze Block Preservation

Template updates preserve custom code wrapped in freeze blocks:

```ruby
# kettle-jem:freeze
# ... custom code preserved across template runs ...
# kettle-jem:unfreeze
```

### Modular Gemfile Architecture

Gemfiles are split into modular components under `gemfiles/modular/`. Each component handles a specific concern (coverage, style, debug, etc.). The main `Gemfile` loads these modular components via `eval_gemfile`.

**Minimum Supported Ruby**: See the gemspec `required_ruby_version` constraint.
**Local Development Ruby**: See `.tool-versions` for the version used in local development (typically the latest stable Ruby).

This project is a **RubyGem** managed with the [kettle-rb](https://github.com/kettle-rb) toolchain.

## ⚠️ AI Agent Terminal Limitations

### Terminal Output Is Available, but Each Command Is Isolated

### Running Commands

Always make commands self-contained. Use `mise exec -C /home/pboling/src/kettle-rb/prism-merge -- ...` so the command gets the project environment in the same invocation.
If the command is complicated write a script in local tmp/ and then run the script.

### Use `mise` for Project Environment

**CRITICAL**: The canonical project environment lives in `mise.toml`, with local overrides in `.env.local` loaded via `dotenvy`.

⚠️ **Watch for trust prompts**: After editing `mise.toml` or `.env.local`, `mise` may require trust to be refreshed before commands can load the project environment. Until that trust step is handled, commands can appear hung or produce no output, which can look like terminal access is broken.

**Recovery rule**: If a `mise exec` command goes silent or appears hung, assume `mise trust` is the first thing to check. Recover by running:

```bash
mise trust -C /home/pboling/src/kettle-rb/kettle-soup-cover
mise exec -C /home/pboling/src/kettle-rb/kettle-soup-cover -- bundle exec rspec
```

```bash
mise trust -C /path/to/project
mise exec -C /path/to/project -- bundle exec rspec
```

Do this before spending time on unrelated debugging; in this workspace pattern, silent `mise` commands are usually a trust problem first.

```bash
mise trust -C /home/pboling/src/kettle-rb/kettle-soup-cover
```

✅ **CORRECT** — Run self-contained commands with `mise exec`:
```bash
mise exec -C /home/pboling/src/kettle-rb/kettle-soup-cover -- bundle exec rspec
```

```bash
mise exec -C /path/to/project -- bundle exec rspec
```

✅ **CORRECT** — If you need shell syntax first, load the environment in the same command:
```bash
eval "$(mise env -C /home/pboling/src/kettle-rb/kettle-soup-cover -s bash)" && bundle exec rspec
```

```bash
eval "$(mise env -C /path/to/project -s bash)" && bundle exec rspec
```

❌ **WRONG** — Do not rely on a previous command changing directories:
```bash
cd /home/pboling/src/kettle-rb/kettle-soup-cover
bundle exec rspec
```

```bash
cd /path/to/project
bundle exec rspec
```

❌ **WRONG** — A chained `cd` does not give directory-change hooks time to update the environment:
```bash
cd /home/pboling/src/kettle-rb/kettle-soup-cover && bundle exec rspec
```

```bash
cd /path/to/project && bundle exec rspec
```

### Prefer Internal Tools Over Terminal

✅ **PREFERRED** — Use internal tools:

- `grep_search` instead of `grep` command
- `file_search` instead of `find` command
- `read_file` instead of `cat` command
- `list_dir` instead of `ls` command
- `replace_string_in_file` or `create_file` instead of `sed` / manual editing

❌ **AVOID** when possible:

- `run_in_terminal` for information gathering

Only use terminal for:

- Running tests (`bundle exec rspec`)
- Installing dependencies (`bundle install`)
- Simple commands that do not require much shell escaping
- Running scripts (prefer writing a script over a complicated command with shell escaping)

### NEVER Pipe Test Commands Through head/tail

❌ **ABSOLUTELY FORBIDDEN**:
```bash
bundle exec rspec 2>&1 | tail -50
```

When you do run tests, keep the full output visible so you can inspect failures completely.

```bash
mise exec -C /home/pboling/src/kettle-rb/kettle-soup-cover -- bundle exec rspec
```

## 🏗️ Architecture

### What kettle-soup-cover Provides

- **`Kettle::Soup::Cover`** — Main module with coverage constants and configuration
- **`Kettle::Soup::Cover::Config`** — SimpleCov configuration (loaded from `.simplecov`)
- **`Kettle::Soup::Cover::Constants`** — ENV-driven constants for all coverage settings
- **`Kettle::Soup::Cover::Loaders`** — Formatter loading logic
- **`Kettle::Soup::Cover::Filters`** — Coverage filter helpers (gt/lt line filters)
- **`kettle-soup-cover` executable** — CLI for coverage report display (`bin/kettle-soup-cover -d`)

### Executable

| Executable | Purpose |
|-----------|---------|
| `kettle-soup-cover` | CLI for displaying coverage reports (`-d` flag for detail) |

### Key Constants (ENV-driven)

| ENV Variable | Default | Purpose |
|-------------|---------|---------|
| `K_SOUP_COV_DO` | `false` | Enable coverage collection |
| `K_SOUP_COV_COMMAND_NAME` | `"Test Coverage"` | SimpleCov command name |
| `K_SOUP_COV_FORMATTERS` | `"html"` | Comma-separated formatter list |
| `K_SOUP_COV_MIN_LINE` | none | Minimum line coverage % |
| `K_SOUP_COV_MIN_BRANCH` | none | Minimum branch coverage % |
| `K_SOUP_COV_MIN_HARD` | `false` | Fail build if thresholds not met |
| `K_SOUP_COV_MULTI_FORMATTERS` | `false` | Enable multiple output formats |
| `K_SOUP_COV_OPEN_BIN` | system default | Browser to open HTML reports |
| `MAX_ROWS` | none | Limit rows in TTY console output |

### Runtime Dependencies

| Gem | Role |
|-----|------|
| `simplecov` (~> 0.22) | Core coverage engine |
| `simplecov-html` (~> 0.13) | HTML report formatter |
| `simplecov-cobertura` (~> 3.0) | XML/Cobertura formatter (GitLab, Jenkins) |
| `simplecov-console` (~> 0.9) | TTY console formatter |
| `simplecov_json_formatter` (~> 0.1) | JSON formatter (GHA, CircleCI, Travis) |
| `simplecov-lcov` (~> 0.8) | LCOV formatter (GCOV, TeamCity) |
| `simplecov-rcov` (~> 0.3) | RCov formatter (Hudson) |
| `version_gem` (~> 1.1) | Version management |

### Workspace layout

### Toolchain Dependencies

This gem is part of the **kettle-rb** ecosystem. Key development tools:

| Tool | Purpose |
|------|---------|
| `kettle-dev` | Development dependency: Rake tasks, release tooling, CI helpers |
| `kettle-test` | Test infrastructure: RSpec helpers, stubbed_env, timecop |
| `kettle-jem` | Template management and gem scaffolding |

### Executables (from kettle-dev)

| Executable | Purpose |
|-----------|---------|
| `kettle-release` | Full gem release workflow |
| `kettle-pre-release` | Pre-release validation |
| `kettle-changelog` | Changelog generation |
| `kettle-dvcs` | DVCS (git) workflow automation |
| `kettle-commit-msg` | Commit message validation |
| `kettle-check-eof` | EOF newline validation |

## 📁 Project Structure

```
lib/kettle/
├── change.rb                      # Change tracking utility
└── soup/
    ├── cover.rb                   # Main module, public API
    └── cover/
        ├── config.rb              # SimpleCov.start configuration
        ├── constants.rb           # ENV-driven constants
        ├── filters/
        │   ├── gt_line_filter.rb  # Greater-than line filter
        │   └── lt_line_filter.rb  # Less-than line filter
        ├── loaders.rb             # Formatter loading
        ├── rakelib/               # Rake task definitions
        ├── tasks.rb               # Task loader
        └── version.rb             # Version constant

lib/kettle-soup-cover.rb           # Convenience require path

exe/
└── kettle-soup-cover              # CLI executable
```

```
lib/
├── <gem_namespace>/           # Main library code
│   └── version.rb             # Version constant (managed by kettle-release)
spec/
├── fixtures/                  # Test fixture files (NOT auto-loaded)
├── support/
│   ├── classes/               # Helper classes for specs
│   └── shared_contexts/       # Shared RSpec contexts
├── spec_helper.rb             # RSpec configuration (loaded by .rspec)
gemfiles/
├── modular/                   # Modular Gemfile components
│   ├── coverage.gemfile       # SimpleCov dependencies
│   ├── debug.gemfile          # Debugging tools
│   ├── documentation.gemfile  # YARD/documentation
│   ├── optional.gemfile       # Optional dependencies
│   ├── rspec.gemfile          # RSpec testing
│   ├── style.gemfile          # RuboCop/linting
│   └── x_std_libs.gemfile     # Extracted stdlib gems
├── ruby_*.gemfile             # Per-Ruby-version Appraisal Gemfiles
└── Appraisal.root.gemfile     # Root Gemfile for Appraisal builds
.git-hooks/
├── commit-msg                 # Commit message validation hook
├── prepare-commit-msg         # Commit message preparation
├── commit-subjects-goalie.txt # Commit subject prefix filters
└── footer-template.erb.txt    # Commit footer ERB template
```

## 🔧 Development Workflows

### Running Tests

```bash
mise exec -C /home/pboling/src/kettle-rb/kettle-soup-cover -- bundle exec rspec
```

```bash
mise exec -C /path/to/project -- env K_SOUP_COV_MIN_HARD=false bundle exec rspec spec/path/to/spec.rb
```

### Coverage Reports

```bash
mise exec -C /home/pboling/src/kettle-rb/kettle-soup-cover -- bin/rake coverage
mise exec -C /home/pboling/src/kettle-rb/kettle-soup-cover -- bin/kettle-soup-cover -d
```

```bash
mise exec -C /path/to/project -- bin/rake coverage
mise exec -C /path/to/project -- bin/kettle-soup-cover -d
```

**Key ENV variables** (set in `mise.toml`, with local overrides in `.env.local`):

- `K_SOUP_COV_DO=true` – Enable coverage
- `K_SOUP_COV_MIN_LINE` – Line coverage threshold
- `K_SOUP_COV_MIN_BRANCH` – Branch coverage threshold
- `K_SOUP_COV_MIN_HARD=true` – Fail if thresholds not met

## 📝 Usage in Other Gems

### Four-Line Setup

Full suite spec runs:

```bash
mise exec -C /path/to/project -- bundle exec rspec
```

For single file, targeted, or partial spec runs the coverage threshold **must** be disabled.
Use the `K_SOUP_COV_MIN_HARD=false` environment variable to disable hard failure:

```ruby
require "kettle-soup-cover"
require "simplecov" if Kettle::Soup::Cover::DO_COV
```

In `.simplecov`:

```ruby
require "kettle/soup/cover/config"
SimpleCov.start
```

### Available Formatters

Set `K_SOUP_COV_FORMATTERS` to a comma-separated list:
- `html` — HTML reports (human-readable)
- `xml` — Cobertura XML (GitLab, Jenkins)
- `json` — JSON (GHA, CircleCI, Travis, CodeClimate)
- `lcov` — LCOV (GCOV, TeamCity)
- `rcov` — RCov (Hudson)
- `tty` — Console/TTY output

Example: `K_SOUP_COV_FORMATTERS="html,xml,rcov,lcov,json,tty"`

### Coverage Thresholds

```bash
K_SOUP_COV_MIN_LINE=90
K_SOUP_COV_MIN_BRANCH=80
K_SOUP_COV_MIN_HARD=true
```

## 🔍 Critical Files

| File | Purpose |
|------|---------|
| `lib/kettle/soup/cover.rb` | Main module, public API |
| `lib/kettle/soup/cover/config.rb` | SimpleCov.start configuration |
| `lib/kettle/soup/cover/constants.rb` | All ENV-driven constants |
| `lib/kettle/soup/cover/loaders.rb` | Formatter loading logic |
| `lib/kettle/soup/cover/filters/gt_line_filter.rb` | Line count filter (greater-than) |
| `lib/kettle/soup/cover/filters/lt_line_filter.rb` | Line count filter (less-than) |
| `exe/kettle-soup-cover` | CLI executable |

### Forward Compatibility with `**options`

**CRITICAL**: All constructors and public API methods that accept keyword arguments MUST include `**options` as the final parameter for forward compatibility.

## 🧪 Testing Patterns

### Test Infrastructure

- Uses `kettle-test` for RSpec helpers (stubbed_env, block_is_expected, silent_stream, timecop)
- Uses `Dir.mktmpdir` for isolated filesystem tests
- Spec helper is loaded by `.rspec` — never add `require "spec_helper"` to spec files

### Environment Variable Helpers

```ruby
before do
  stub_env("MY_ENV_VAR" => "value")
end

before do
  hide_env("HOME", "USER")
end
```

### Dependency Tags

Use dependency tags to conditionally skip tests when optional dependencies are not available:

```ruby
RSpec.describe SomeClass, :prism_merge do
  # Skipped if prism-merge is not available
end
```

## 🚫 Common Pitfalls

1. **NEVER add backward compatibility** — No shims, aliases, or deprecation layers.
2. **NEVER expect `cd` to persist** — Every terminal command is isolated; use a self-contained `mise exec -C ... -- ...` invocation.
3. **NEVER pipe test output through `head`/`tail`** — Run tests without truncation so you can inspect the full output.
4. **Terminal commands do not share shell state** — Previous `cd`, `export`, aliases, and functions are not available to the next command.
5. **Use `tmp/` for temporary files** — Never use `/tmp` or other system directories.
6. **Never review HTML coverage reports** — Use JSON, XML, LCOV, or the `kettle-soup-cover -d` TTY output.
7. **Coverage constants are frozen at load time** — They read from ENV when `require "kettle-soup-cover"` is called. Changing ENV after that has no effect on the constants.

1. **NEVER pipe test output through `head`/`tail`** — Run tests without truncation so you can inspect the full output.

1. **NEVER pipe test output through `head`/`tail`** — Run tests without truncation so you can inspect the full output.
