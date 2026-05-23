# frozen_string_literal: true

# USAGE:
# In your `spec/spec_helper.rb`,
# just prior to loading the library under test:
#
#   require "kettle-soup-cover"
#   # ... other setup code
#   require "simplecov" if Kettle::Soup::Cover::DO_COV
#
# In your `.simplecov` file:
#
#   require "kettle/soup/cover/config"
#   SimpleCov.start
#

# Standard Lib
require "fileutils"
require "rbconfig"

# External gems
require "version_gem"

# This gem
require_relative "../change"
require_relative "cover/version"

require_relative "cover/constants"
require_relative "cover/loaders"

module Kettle
  module Soup
    module Cover
      class Error < StandardError; end

      # Provide a public API for constants that is a bit less namespaced
      include Constants
      extend Loaders

      module_function

      VAR_HOME_PREFIX = %r{\A/var/home(?=/|\z)}

      def display_path(path)
        return path if path.nil?

        path.to_s.sub(VAR_HOME_PREFIX, "/home")
      end

      def reset_const(&block)
        Constants.reset_const(&block)
      end

      def delete_const(&block)
        Constants.delete_const(&block)
      end

      # Deletes coverage/.resultset.json (if it exists) so that stale entries
      # from prior runs cannot pollute the current run's coverage report.
      # Called automatically from config.rb when CLEAN_RESULTSET is true.
      def clean_resultset!
        resultset_path = SimpleCov::ResultMerger.resultset_path
        File.delete(resultset_path) if File.exist?(resultset_path)
      end

      def clear_coverage_dir!(coverage_dir = Constants::COVERAGE_DIR, project_root: Dir.pwd)
        FileUtils.rm_rf(File.expand_path(coverage_dir, project_root))
      end

      def turbo_tests_coverage_dir(coverage_dir = Constants::COVERAGE_ROOT_DIR, project_root: Dir.pwd)
        File.expand_path(File.join(coverage_dir, Constants::TURBO_TESTS_DIR), project_root)
      end

      def turbo_tests_coverage?
        Constants::DO_COV && Constants::TURBO_TESTS
      end

      def clear_turbo_tests_coverage_dir!(coverage_dir = Constants::COVERAGE_ROOT_DIR, project_root: Dir.pwd)
        FileUtils.rm_rf(turbo_tests_coverage_dir(coverage_dir, project_root: project_root))
      end

      def turbo_tests_resultset_paths(coverage_dir = Constants::COVERAGE_ROOT_DIR, project_root: Dir.pwd)
        Dir[File.join(turbo_tests_coverage_dir(coverage_dir, project_root: project_root), "*", ".resultset.json")]
      end

      def collate_turbo_tests_coverage!(coverage_dir = Constants::COVERAGE_ROOT_DIR, project_root: Dir.pwd)
        return :disabled unless turbo_tests_coverage?

        resultsets = turbo_tests_resultset_paths(coverage_dir, project_root: project_root)
        return :empty if resultsets.empty?

        require "simplecov"

        SimpleCov.collate(resultsets) do
          command_name("#{Constants::COMMAND_NAME} (turbo_tests2)")
          enable_coverage(:branch)
          primary_coverage(:branch)
          add_filter(Constants::FILTER_DIRS)
          coverage_dir(File.expand_path(coverage_dir, project_root))

          if Constants::MULTI_FORMATTERS
            Kettle::Soup::Cover::Loaders.load_formatters
          else
            require "simplecov-html"
            formatter(SimpleCov::Formatter::HTMLFormatter)
          end

          if Constants::MIN_COVERAGE_HARD
            minimum_coverage(
              branch: Constants::MIN_COVERAGE_BRANCH,
              line: Constants::MIN_COVERAGE_LINE,
            )
          end
        end

        :collated
      end

      def coverage_task_env(coverage_dir = Constants::COVERAGE_DIR, project_root: Dir.pwd)
        resolved_coverage_dir = File.expand_path(coverage_dir, project_root)

        {
          "K_SOUP_COV_PREFIX" => Constants::PREFIX,
          "#{Constants::PREFIX}DIR" => resolved_coverage_dir,
          "#{Constants::PREFIX}DO" => Constants::TRUE,
          "#{Constants::PREFIX}FORMATTERS" => "json",
          "#{Constants::PREFIX}MIN_HARD" => Constants::FALSE,
          "#{Constants::PREFIX}MULTI_FORMATTERS" => Constants::TRUE,
          "#{Constants::PREFIX}OPEN_BIN" => "",
        }
      end

      def refresh_coverage_data!(coverage_dir = Constants::COVERAGE_DIR, project_root: Dir.pwd, out: $stdout, err: $stderr)
        clear_coverage_dir!(coverage_dir, project_root: project_root)

        coverage_task = File.expand_path("bin/rake", project_root)
        success = system(
          coverage_task_env(coverage_dir, project_root: project_root),
          coverage_task,
          "coverage",
          chdir: project_root,
          out: out,
          err: err,
        )
        return if success

        raise Error, "Coverage refresh failed: #{coverage_task} coverage"
      end
    end
  end
end

Kettle::Soup::Cover::Version.class_eval do
  extend VersionGem::Basic
end
