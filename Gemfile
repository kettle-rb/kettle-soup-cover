# frozen_string_literal: true

source "https://gem.coop"

git_source(:codeberg) { |repo_name| "https://codeberg.org/#{repo_name}" }
git_source(:gitlab) { |repo_name| "https://gitlab.com/#{repo_name}" }

#### IMPORTANT #######################################################
# Gemfile is for local development ONLY; Gemfile is NOT loaded in CI #
####################################################### IMPORTANT ####

# Include dependencies from <gem name>.gemspec
gemspec

eval_gemfile "gemfiles/modular/templating.gemfile"
eval_gemfile "gemfiles/modular/debug.gemfile"
eval_gemfile "gemfiles/modular/optional.gemfile"

# Security Audit
eval_gemfile "gemfiles/modular/audit.gemfile"

# Code Coverage
eval_gemfile "gemfiles/modular/coverage.gemfile"

# Documentation
eval_gemfile "gemfiles/modular/documentation.gemfile"

# Ex-Standard Libs
eval_gemfile "gemfiles/modular/x_std_libs.gemfile"

# Linting
eval_gemfile "gemfiles/modular/style.gemfile"
