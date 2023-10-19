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

# External gems
require "version_gem"

require_relative "kettle/soup/cover/version"

require "kettle/soup/cover"

Kettle::Soup::Cover::Version.class_eval do
  extend VersionGem::Basic
end
