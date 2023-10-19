# frozen_string_literal: true


# USAGE:
# In your `spec/spec_helper.rb`,
# just prior to loading the library under test:
#
#   require "kettle-soup-cover"
#   # ... other setup code
#   require "simplecov" if Kettle::Soup::Cover::COV_DO
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

      CONSTANTS = %w[
        CI
        COMMAND_NAME
        COVERAGE_DIR
        DEBUG
        DO_COV
        ENV_GET
        FALSE
        FILTER_DIRS
        FORMATTER_PLUGINS
        FORMATTERS
        IS_CI
        MERGE_TIMEOUT
        MIN_COVERAGE_BRANCH
        MIN_COVERAGE_LINE
        MIN_COVERAGE_HARD
        MULTI_FORMATTERS_DEFAULT
        MULTI_FORMATTERS
        PREFIX
        TRUE
        USE_MERGING
        VERBOSE
      ]
      FALSE = "false"
      TRUE = "true"
      PREFIX = ENV.fetch("K_SOUP_COV_PREFIX", "K_SOUP_COV_")
      ENV_GET = ->(suffix, default) { ENV.fetch("#{PREFIX}#{suffix}", default) }
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
      IS_CI = CI.casecmp?(TRUE)
      COMMAND_NAME = ENV_GET.call("COMMAND_NAME", "RSpec (COVERAGE)")
      COVERAGE_DIR = ENV_GET.call("DIR", "coverage")
      DEBUG = ENV_GET.call("DEBUG", FALSE).casecmp?(TRUE)
      DO_COV = ENV_GET.call("DO", CI).casecmp?(TRUE)
      FILTER_DIRS = ENV_GET.call(
        "FILTER_DIRS",
        "bin,certs,checksums,config,coverage,docs,features,gemfiles,pkg,results,sig,spec,src,test,test-results,vendor",
      )
        .split(",")
        .map { |dir_name| %r{^/#{dir_name}/} }
      FORMATTERS = ENV_GET.call(
        "FORMATTERS",
        IS_CI ? "html,xml,rcov,lcov,json,tty" : "html,tty",
      )
        .split(",")
        .map { |fmt_name| FORMATTER_PLUGINS[fmt_name.to_sym] }
      MIN_COVERAGE_HARD = ENV_GET.call("MIN_HARD", CI).casecmp?(TRUE)
      MIN_COVERAGE_BRANCH = ENV_GET.call("MIN_BRANCH", "80").to_i
      MIN_COVERAGE_LINE = ENV_GET.call("MIN_LINE", "80").to_i
      MULTI_FORMATTERS_DEFAULT = if IS_CI
        CI
      else
        FORMATTERS.any? ? TRUE : FALSE
      end
      MULTI_FORMATTERS = ENV_GET.call("MULTI_FORMATTERS", MULTI_FORMATTERS_DEFAULT).casecmp?(TRUE)
      USE_MERGING = ENV_GET.call("USE_MERGING", nil)&.casecmp?(TRUE)
      MERGE_TIMEOUT = ENV_GET.call("MERGE_TIMEOUT", nil)&.to_i
      VERBOSE = ENV_GET.call("VERBOSE", FALSE).casecmp?(TRUE)

      module_function
      def load_formatters
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

      def load_filters
        require "kettle/soup/cover/filters/gt_line_filter"
        require "kettle/soup/cover/filters/lt_line_filter"
      end

      def install_tasks
        load("kettle/soup/cover/tasks.rb")
      end

      # Const manipulation is to help with testing this gem
      def reset_const(&_)
        delete_const do
          yield if block_given?
          # Loading myself... Woah.
          load("kettle/soup/cover.rb")
        end
      end

      # Const manipulation is to help with testing this gem
      def delete_const(&_)
        CONSTANTS.each do |var|
          remove_const(var)
        end
        remove_const(:CONSTANTS)
        yield if block_given?

        nil
      end
    end
  end
end
