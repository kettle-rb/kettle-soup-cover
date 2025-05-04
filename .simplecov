require "kettle/soup/cover/config"

if Kettle::Soup::Cover::DO_COV
  SimpleCov.start do
    # coverage config is loaded when the test suite runs, so it is under dog food testing.
    add_filter "lib/kettle/soup/cover/config"
  end
end
