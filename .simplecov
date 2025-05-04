require "kettle/soup/cover/config"

# In other gems we would simply check if Kettle::Soup::Cover::DO_COV
#   but because this is that library, and we can't load it before we start SimpleCov,
#   it isn't available here, so we fall back to the raw ENV variable check.
if ENV.fetch("K_SOUP_COV_DO", "false").casecmp?("true")
  SimpleCov.start do
    # coverage config is loaded when the test suite runs, so it is under dog food testing.
    add_filter "lib/kettle/soup/cover/config"
  end
end
