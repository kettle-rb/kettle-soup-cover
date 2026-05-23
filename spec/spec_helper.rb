# frozen_string_literal: true

# Usage:
#   see https://github.com/pboling/rspec-block_is_expected#example
require "rspec/block_is_expected"
require "rspec/block_is_expected/matchers/not"

# Usage:
# describe 'my stubbed test' do
#   include_context 'with stubbed env'
#   before do
#     stub_env('FOO' => 'is bar')
#   end
#   it 'has a value' do
#     expect(ENV['FOO']).to eq('is bar')
#   end
# end
require "rspec/stubbed_env"
require "stringio"

# External gems
require "version_gem/rspec"
require "rake"

# RSpec Configs
require "config/rspec/rspec_core"
require "config/rspec/silent_stream"

# Force load the cover module, so we can use it while testing it, and get accurate coverage.
# It will be reloaded again after simplecov begins tracking.
path = File.expand_path(__dir__)
load File.join(path, "..", "lib", "kettle", "change.rb")
load File.join(path, "..", "lib", "kettle", "soup", "cover", "constants.rb")
load File.join(path, "..", "lib", "kettle", "soup", "cover", "loaders.rb")

# SimpleCov
# Normally we would only load simple cov if checking test coverage,
#   but our runtime code depends on simplecov, so loading it is non-optional.
# Our run-time code does not itself require simplecov,
#   because that comes with side effects that must be delayed until coverage tracking should begin.
require "simplecov"

# rubocop:disable RSpec/RemoveConst
Kettle.send(:remove_const, :Change) if Kettle.const_defined?(:Change, false)
if Kettle.const_defined?(:Soup, false) && Kettle::Soup.const_defined?(:Cover, false)
  Kettle::Soup::Cover.send(:remove_const, :Constants) if Kettle::Soup::Cover.const_defined?(:Constants, false)
  Kettle::Soup::Cover.send(:remove_const, :Loaders) if Kettle::Soup::Cover.const_defined?(:Loaders, false)
end
# rubocop:enable RSpec/RemoveConst

# This gem
require "kettle-soup-cover"

RSpec.configure do |config|
  config.after(:suite) do
    # These rake task files are intentionally reloaded by their specs into isolated
    # Rake applications. Ruby branch coverage keeps the counters from the final
    # load, so exercise both task branches once after randomized examples finish.
    original_application = Rake.application
    original_stdout = $stdout
    original_stderr = $stderr
    original_open_bin = ENV.fetch("K_SOUP_COV_OPEN_BIN", nil)
    original_turbo_tests = ENV.fetch("K_SOUP_COV_TURBO_TESTS", nil)
    original_coverage_dir = ENV.fetch("K_SOUP_COV_DIR", nil)

    begin
      $stdout = StringIO.new
      $stderr = StringIO.new
      ENV["K_SOUP_COV_DIR"] = "coverage"

      Rake.application = Rake::Application.new
      load File.expand_path("../lib/kettle/soup/cover/rakelib/turbo_tests.rake", __dir__)

      ENV["K_SOUP_COV_TURBO_TESTS"] = "true"
      Kettle::Soup::Cover.reset_const
      Rake.application["turbo_tests:setup"].invoke

      ENV["K_SOUP_COV_TURBO_TESTS"] = "false"
      Kettle::Soup::Cover.reset_const
      Rake.application["turbo_tests:setup"].reenable
      Rake.application["turbo_tests:setup"].invoke

      Rake.application = Rake::Application.new
      load File.expand_path("config/mocks/test_task.rake", __dir__)
      load File.expand_path("../lib/kettle/soup/cover/rakelib/coverage.rake", __dir__)

      ["", "blah", "blah --bad"].each do |open_bin|
        ENV["K_SOUP_COV_OPEN_BIN"] = open_bin
        Kettle::Soup::Cover.reset_const
        Rake.application["coverage"].reenable
        Rake.application["test"].reenable
        Rake.application["coverage"].invoke
      end
    ensure
      Rake.application = original_application
      $stdout = original_stdout
      $stderr = original_stderr
      if original_open_bin.nil?
        ENV.delete("K_SOUP_COV_OPEN_BIN")
      else
        ENV["K_SOUP_COV_OPEN_BIN"] = original_open_bin
      end
      if original_turbo_tests.nil?
        ENV.delete("K_SOUP_COV_TURBO_TESTS")
      else
        ENV["K_SOUP_COV_TURBO_TESTS"] = original_turbo_tests
      end
      if original_coverage_dir.nil?
        ENV.delete("K_SOUP_COV_DIR")
      else
        ENV["K_SOUP_COV_DIR"] = original_coverage_dir
      end
      Kettle::Soup::Cover.reset_const
    end
  end
end
