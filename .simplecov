# kettle-jem:freeze
# To retain chunks of comments & code during kettle-soup-cover templating:
# Wrap custom sections with freeze markers (e.g., as above and below this comment chunk).
# kettle-soup-cover will then preserve content between those markers across template runs.
# kettle-jem:unfreeze

require "kettle/soup/cover/config"

# Minimum coverage thresholds are set by kettle-soup-cover.
# They are controlled by ENV variables loaded by `mise` from `mise.toml`
# (with optional machine-local overrides in `.env.local`).
# If the values for minimum coverage need to change, they should be changed both there,
#   and in 2 places in .github/workflows/coverage.yml.
SimpleCov.start do
  track_files "lib/**/*.rb"
  track_files "lib/**/*.rake"
  track_files "exe/*.rb"
end

# In other gems we would simply check if Kettle::Soup::Cover::DO_COV
#   but because this is that library, and we can't load it before we start SimpleCov,
#   it isn't available here, so we fall back to the raw ENV variable check.
if ENV.fetch("K_SOUP_COV_DO", "false").casecmp?("true")
  SimpleCov.start do
    # coverage config is loaded when the test suite runs, so it is under dog food testing.
    add_filter "lib/kettle/soup/cover/config"
  end
end
