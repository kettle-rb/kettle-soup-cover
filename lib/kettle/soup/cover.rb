# frozen_string_literal: true

# External gems
require "version_gem"

require_relative "cover/version"

# USAGE:
# In your `spec/spec_helper.rb`,
# just prior to loading the library under test:
#
#   require "kettle/soup/cover" # or require "kettle-soup-cover"
#
# In your `.simplecov` file:
#
#   require "kettle/soup/cover/config"
#   SimpleCov.start
#

module Kettle
  module Soup
    module Cover
      class Error < StandardError; end

      FALSE = "false"
      TRUE = "true"
      FORMATTER_PLUGINS = {
        # HTML for Humans
        html: {
          type: :html,
          klass: "HTMLFormatter",
          lib: "simplecov-html",
        },
        # XML for Jenkins
        xml: {
          type: :xml,
          klass: "CoberturaFormatter",
          lib: "simplecov-cobertura",
        },
        # RCOV for Hudson
        rcov: {
          type: :rcov,
          klass: "RcovFormatter",
          lib: "simplecov-rcov",
        },
        # LCOV for GCOV
        lcov: {
          type: :lcov,
          klass: "LcovFormatter",
          lib: "simplecov-lcov",
        },
        # JSON for CodeClimate
        json: {
          type: :json,
          klass: "JSONFormatter",
          lib: "simplecov_json_formatter",
        },
        # TTY / Console output
        tty: {
          type: :tty,
          klass: "Console",
          lib: "simplecov-console",
        },
      }

      CI = ENV.fetch("CI", FALSE)
      COMMAND_NAME = ENV.fetch("K_SOUP_COMMAND_NAME", "RSpec (COVERAGE)")
      COVERAGE_DIR = ENV.fetch("K_SOUP_COV_DIR", "coverage")
      IS_CI = CI.casecmp?(TRUE)
      DO_COV = ENV.fetch("K_SOUP_DO_COV", CI).casecmp?(TRUE)
      FILTER_DIRS = ENV.fetch(
        "K_SOUP_FILTER_DIRS",
        "bin,certs,checksums,config,docs,features,gemfiles,pkg,results,sig,spec,src,test,test-results,vendor",
      )
        .split(",")
        .map { |dir_name| %r{^/#{dir_name}/} }
      FORMATTERS = ENV.fetch(
        "K_SOUP_FORMATTERS",
        IS_CI ? "html,xml,rcov,lcov,json,tty" : "",
      )
        .split(",")
        .map { |fmt_name| FORMATTER_PLUGINS[fmt_name.to_sym] }
      MIN_COVERAGE_HARD = ENV.fetch("K_SOUP_COV_MIN_HARD", FALSE).casecmp?(TRUE)
      MIN_COVERAGE_BRANCH = ENV.fetch("K_SOUP_COV_MIN_BRANCH", "80").to_i
      MIN_COVERAGE_LINE = ENV.fetch("K_SOUP_COV_MIN_LINE", "80").to_i
      MULTI_FORMATTERS_DEFAULT = if IS_CI
        CI
      else
        FORMATTERS.any? ? TRUE : FALSE
      end
      MULTI_FORMATTERS = ENV.fetch("K_SOUP_COV_MULTI_FORMATTERS", MULTI_FORMATTERS_DEFAULT).casecmp?(TRUE)
      USE_MERGING = ENV.fetch("K_SOUP_USE_MERGING", FALSE)
      VERBOSE = ENV.fetch("K_SOUP_VERBOSE", FALSE).casecmp?(TRUE)

      module_function def load_formatters
        SimpleCov.formatters = FORMATTERS
          .each_with_object([]) do |fmt_data, formatters|
          require fmt_data[:lib].to_s

          klass = SimpleCov::Formatter.const_get(fmt_data[:klass])

          if fmt_data[:type] == :lcov
            klass.config do |c|
              c.report_with_single_file = true
              c.single_report_path = "#{Kettle::Soup::Cover::COVERAGE_DIR}/lcov.info"
            end
          end

          formatters << klass
        end
      end
    end
  end
end

Kettle::Soup::Cover::Version.class_eval do
  extend VersionGem::Basic
end

if Kettle::Soup::Cover::DO_COV
  # When simplecov library loads here, the .simplecov library will be run immediately
  # It is expected that inside .simplecov users of this gem will add:
  #
  #   require "kettle/soup/cover/config" # Runs SimpleCov.configure, but not SimpleCov.start
  #   SimpleCov.start # actually run start!
  #
  require "simplecov"
elsif Kettle::Soup::Cover::VERBOSE
  puts "[Kettle::Soup::Cover] Not running coverage on #{RUBY_ENGINE} #{RUBY_VERSION}"
end
