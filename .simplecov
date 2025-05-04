require "kettle/soup/cover/config"

SimpleCov.start do
  # coverage config is loaded when the test suite runs, so it is under dog food testing.
  add_filter "lib/kettle/soup/cover/config"
end
