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

# RSpec Configs
require "config/rspec/rspec_core"

# Force load the cover module, so we can use it while testing it, and get accurate coverage.
# It will be reloaded again after simplecov begins tracking.
path = File.expand_path(__dir__)
load File.join(path, "..", "lib", "kettle", "soup", "cover.rb")

# SimpleCov
require "simplecov"

Kettle::Soup::Cover.delete_const

# This gem
require "kettle-soup-cover"
