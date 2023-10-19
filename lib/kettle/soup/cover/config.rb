# frozen_string_literal: true

# USAGE:
# In your `spec/spec_helper.rb`,
# just prior to loading the library under test:
#
#   require "kettle-soup-cover"
#
# In your `.simplecov` file:
#
#   require "kettle/soup/cover/config"
#   SimpleCov.start
#

SimpleCov.configure do
  track_files("lib/**/*.rb")

  command_name Kettle::Soup::Cover::COMMAND_NAME

  enable_coverage :branch
  primary_coverage :branch

  # Filters (skip these paths for coverage tracking)
  add_filter Kettle::Soup::Cover::FILTER_DIRS

  # Setup Coverage Dir
  coverage_dir(Kettle::Soup::Cover::COVERAGE_DIR)

  # Formatters
  if Kettle::Soup::Cover::MULTI_FORMATTERS
    Kettle::Soup::Cover.load_formatters
  else
    require "simplecov-html"
    formatter SimpleCov::Formatter::HTMLFormatter
  end

  # Use Merging (merges RSpec + Cucumber Test Results)
  use_merging(Kettle::Soup::Cover::USE_MERGING) unless Kettle::Soup::Cover::USE_MERGING.nil?
  merge_timeout(Kettle::Soup::Cover::MERGE_TIMEOUT) if Kettle::Soup::Cover::MERGE_TIMEOUT

  # Fail build when missed coverage targets
  # NOTE: Checking SpecTracker.instance.full_suite? here would be awesome, but won't work
  #       SpecTracker must wait for instantiation until it has
  #       RSpec's config.world.all_examples,
  #       and that doesn't happen until the before(:suite) hook
  if Kettle::Soup::Cover::IS_CI || Kettle::Soup::Cover::MIN_COVERAGE_HARD
    minimum_coverage(
      branch: Kettle::Soup::Cover::MIN_COVERAGE_BRANCH,
      line: Kettle::Soup::Cover::MIN_COVERAGE_LINE,
    )
  end
end
