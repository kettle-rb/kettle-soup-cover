# See: https://github.com/simplecov-ruby/simplecov#custom-filter-class
# See: https://github.com/simplecov-ruby/simplecov#groups
class GtLineFilter < SimpleCov::Filter
  def matches?(source_file)
    source_file.lines.count > filter_argument
  end
end
