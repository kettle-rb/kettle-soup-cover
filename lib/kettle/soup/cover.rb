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
    end
  end
end

Kettle::Soup::Cover::Version.class_eval do
  extend VersionGem::Basic
end
