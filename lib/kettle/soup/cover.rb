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
