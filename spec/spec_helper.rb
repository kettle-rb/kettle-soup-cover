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

Kettle::Soup::Cover::Constants.delete_const

# This gem
require "kettle-soup-cover"
