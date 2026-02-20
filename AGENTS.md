# AGENTS.md - kettle-soup-cover Development Guide

## 🎯 Project Overview

`kettle-soup-cover` is a **four-line SimpleCov configuration** gem that provides curated, opinionated, pre-configured code coverage for every CI platform, batteries included. It bundles SimpleCov with formatters for HTML, XML (Cobertura), JSON, LCOV, RCov, and TTY console output — all configured via environment variables.

**Core Philosophy**: Code coverage configuration should be declarative via environment variables, not code. One gem, every CI platform, zero boilerplate.

**Repository**: https://github.com/kettle-rb/kettle-soup-cover
**Current Version**: 1.1.1
**Required Ruby**: >= 2.7.0 (currently developed against Ruby 4.0.1)

## ⚠️ AI Agent Terminal Limitations

### Terminal Output Is Not Visible

**CRITICAL**: AI agents using `run_in_terminal` almost never see the command output. The terminal tool sends commands to a persistent Copilot terminal, but output is frequently lost or invisible to the agent.

**Workaround**: Always redirect output to a file in the project's local `tmp/` directory, then read it back:

```bash
bundle exec rspec spec/some_spec.rb > tmp/test_output.txt 2>&1
```
Then use `read_file` to see `tmp/test_output.txt`.

**NEVER** use `/tmp` or other system directories — always use the project's own `tmp/` directory.

### direnv Requires Separate `cd` Command

**CRITICAL**: The project uses `direnv` to load environment variables from `.envrc`. When you `cd` into the project directory, `direnv` initializes **after** the shell prompt returns. If you chain `cd` with other commands via `&&`, the subsequent commands run **before** `direnv` has loaded the environment.

✅ **CORRECT** — Run `cd` alone, then run commands separately:
```bash
cd /home/pboling/src/kettle-rb/ast-merge/vendor/kettle-soup-cover
```
```bash
bundle exec rspec
```

❌ **WRONG** — Never chain `cd` with `&&`:
```bash
cd /home/pboling/src/kettle-rb/ast-merge/vendor/kettle-soup-cover && bundle exec rspec
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
- Git operations that require interaction
- Commands that actually need to execute (not just gather info)

### NEVER Pipe Test Commands Through head/tail

❌ **ABSOLUTELY FORBIDDEN**:
```bash
bundle exec rspec 2>&1 | tail -50
```

✅ **CORRECT** — Redirect to file:
```bash
bundle exec rspec > tmp/test_output.txt 2>&1
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

### Vendor Directory

**IMPORTANT**: This project lives in `vendor/kettle-soup-cover/` within the `ast-merge` workspace. It is a **nested git project** with its own `.git/` directory. The `grep_search` tool **CANNOT search inside nested git projects** — use `read_file` and `list_dir` instead.

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

## 🔧 Development Workflows

### Running Tests

```bash
cd /home/pboling/src/kettle-rb/ast-merge/vendor/kettle-soup-cover
```
```bash
bundle exec rspec > tmp/test_output.txt 2>&1
```

### Coverage Reports

```bash
cd /home/pboling/src/kettle-rb/ast-merge/vendor/kettle-soup-cover
```
```bash
bin/rake coverage > tmp/coverage_output.txt 2>&1
```

**Key ENV variables** (set in `.envrc`):
- `K_SOUP_COV_DO=true` – Enable coverage
- `K_SOUP_COV_MIN_LINE=92` – Line coverage threshold
- `K_SOUP_COV_MIN_BRANCH=50` – Branch coverage threshold
- `K_SOUP_COV_MIN_HARD=true` – Fail if thresholds not met

## 📝 Usage in Other Gems

### Four-Line Setup

In `spec/spec_helper.rb`, just before loading the library under test:

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
export K_SOUP_COV_MIN_LINE=90      # Minimum 90% line coverage
export K_SOUP_COV_MIN_BRANCH=80    # Minimum 80% branch coverage
export K_SOUP_COV_MIN_HARD=true    # Fail the build if not met
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

## 🚫 Common Pitfalls

1. **NEVER add backward compatibility** — No shims, aliases, or deprecation layers.
2. **NEVER chain `cd` with `&&`** — `direnv` won't initialize until after all chained commands finish.
3. **NEVER pipe test output through `head`/`tail`** — Redirect to `tmp/` files instead.
4. **Terminal output is invisible** — Always redirect to `tmp/` and read back with `read_file`.
5. **`grep_search` cannot search nested git projects** — Use `read_file` and `list_dir` to explore this codebase.
6. **Use `tmp/` for temporary files** — Never use `/tmp` or other system directories.
7. **Never review HTML coverage reports** — Use JSON, XML, LCOV, or the `kettle-soup-cover -d` TTY output.
8. **Coverage constants are frozen at load time** — They read from ENV when `require "kettle-soup-cover"` is called. Changing ENV after that has no effect on the constants.
