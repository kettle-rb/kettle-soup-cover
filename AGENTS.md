# AGENTS.md - kettle-soup-cover Development Guide

## 🎯 Project Overview

`kettle-soup-cover` is a **four-line SimpleCov configuration** gem that provides curated, opinionated, pre-configured code coverage for every CI platform, batteries included. It bundles SimpleCov with formatters for HTML, XML (Cobertura), JSON, LCOV, RCov, and TTY console output — all configured via environment variables.

**Core Philosophy**: Code coverage configuration should be declarative via environment variables, not code. One gem, every CI platform, zero boilerplate.

**Repository**: https://github.com/kettle-rb/kettle-soup-cover
**Current Version**: 1.1.1
**Required Ruby**: >= 2.7.0 (currently developed against Ruby 4.0.1)

## ⚠️ AI Agent Terminal Limitations

### Terminal Output Is Available, but Each Command Is Isolated

**CRITICAL**: AI agents can reliably read terminal output when commands run in the background and the output is polled afterward. However, each terminal command should be treated as a fresh shell with no shared state.

### Use `mise` for Project Environment

**CRITICAL**: The canonical project environment now lives in `mise.toml`, with local overrides in `.env.local` loaded via `dotenvy`.

⚠️ **Watch for trust prompts**: After editing `mise.toml` or `.env.local`, `mise` may require trust to be refreshed before commands can load the project environment. That interactive trust screen can masquerade as missing terminal output, so commands may appear hung or silent until you handle it.

**Recovery rule**: If a `mise exec` command in this repo goes silent, appears hung, or terminal polling stops returning useful output, assume `mise trust` is needed first and recover with:

```bash
mise trust -C /home/pboling/src/kettle-rb/kettle-soup-cover
mise exec -C /home/pboling/src/kettle-rb/kettle-soup-cover -- bundle exec rspec
```

Do this before spending time on unrelated debugging; in this workspace, silent `mise` commands are usually a trust problem.

```bash
mise trust -C /home/pboling/src/kettle-rb/kettle-soup-cover
```

✅ **CORRECT** — Run self-contained commands with `mise exec`:
```bash
mise exec -C /home/pboling/src/kettle-rb/kettle-soup-cover -- bundle exec rspec
```

✅ **CORRECT** — If you need shell syntax first, load the environment in the same command:
```bash
eval "$(mise env -C /home/pboling/src/kettle-rb/kettle-soup-cover -s bash)" && bundle exec rspec
```

❌ **WRONG** — Do not rely on a previous command changing directories:
```bash
cd /home/pboling/src/kettle-rb/kettle-soup-cover
bundle exec rspec
```

❌ **WRONG** — A chained `cd` does not give directory-change hooks time to update the environment:
```bash
cd /home/pboling/src/kettle-rb/kettle-soup-cover && bundle exec rspec
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

✅ **CORRECT** — Run the plain command and read the full output afterward:
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

This repo is a sibling project inside the `/home/pboling/src/kettle-rb` workspace, not a vendored dependency under another repo.

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
mise exec -C /home/pboling/src/kettle-rb/kettle-soup-cover -- bundle exec rspec
```

### Coverage Reports

```bash
mise exec -C /home/pboling/src/kettle-rb/kettle-soup-cover -- bin/rake coverage
mise exec -C /home/pboling/src/kettle-rb/kettle-soup-cover -- bin/kettle-soup-cover -d
```

**Key ENV variables** (set in `mise.toml`, with local overrides in `.env.local`):
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

## 🚫 Common Pitfalls

1. **NEVER add backward compatibility** — No shims, aliases, or deprecation layers.
2. **NEVER expect `cd` to persist** — Every terminal command is isolated; use a self-contained `mise exec -C ... -- ...` invocation.
3. **NEVER pipe test output through `head`/`tail`** — Run tests without truncation so you can inspect the full output.
4. **Terminal commands do not share shell state** — Previous `cd`, `export`, aliases, and functions are not available to the next command.
5. **Use `tmp/` for temporary files** — Never use `/tmp` or other system directories.
6. **Never review HTML coverage reports** — Use JSON, XML, LCOV, or the `kettle-soup-cover -d` TTY output.
7. **Coverage constants are frozen at load time** — They read from ENV when `require "kettle-soup-cover"` is called. Changing ENV after that has no effect on the constants.
