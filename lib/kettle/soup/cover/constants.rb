module Kettle
  module Soup
    module Cover
      module Constants
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
          .map { |dir_name| %r{^/#{Regexp.escape(dir_name)}/} }
        FORMATTERS = begin
          list = ENV_GET.call(
            "FORMATTERS",
            IS_CI ? "html,xml,rcov,lcov,json,tty" : "html,tty",
          )
            .split(",")
            .map { |fmt_name| FORMATTER_PLUGINS[fmt_name.strip.to_sym] }
            .compact

          # If MAX_ROWS is explicitly set to "0", skip tty output from simplecov-console
          max_rows = ENV.fetch("MAX_ROWS", nil)
          if max_rows && max_rows.strip == "0"
            list = list.reject { |f| f && f[:type] == :tty }
          end

          list
        end
        MIN_COVERAGE_HARD = ENV_GET.call("MIN_HARD", CI).casecmp?(TRUE)
        MIN_COVERAGE_BRANCH = ENV_GET.call("MIN_BRANCH", "80").to_i
        MIN_COVERAGE_LINE = ENV_GET.call("MIN_LINE", "80").to_i
        MULTI_FORMATTERS_DEFAULT = if IS_CI
          TRUE
        else
          FORMATTERS.any? ? TRUE : FALSE
        end
        MULTI_FORMATTERS = ENV_GET.call("MULTI_FORMATTERS", MULTI_FORMATTERS_DEFAULT).casecmp?(TRUE)
        # A wild approximation, but will suffice for nearly all users
        is_mac = RbConfig::CONFIG["host_os"].include?("darwin")
        # Set to "" to prevent opening a browser with the coverage rake task
        OPEN_BIN = ENV_GET.call("OPEN_BIN", is_mac ? "open" : "xdg-open")
        # Enable merging by default to aggregate coverage across multiple test runs
        # (e.g., separate RSpec tasks for FFI tests, integration tests, unit tests)
        # Set K_SOUP_COV_USE_MERGING=false to disable
        USE_MERGING = ENV_GET.call("USE_MERGING", TRUE).casecmp?(TRUE)
        # Default merge timeout of 1 hour (3600 seconds) - enough for most test suites
        # Set K_SOUP_COV_MERGE_TIMEOUT to override
        MERGE_TIMEOUT = ENV_GET.call("MERGE_TIMEOUT", "3600").to_i
        VERBOSE = ENV_GET.call("VERBOSE", FALSE).casecmp?(TRUE)

        include Kettle::Change.new(
          constants: %w[
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
            OPEN_BIN
            PREFIX
            TRUE
            USE_MERGING
            VERBOSE
          ],
          path: "kettle/soup/cover/constants.rb",
        )
      end
    end
  end
end
