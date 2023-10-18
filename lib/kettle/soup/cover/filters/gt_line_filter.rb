# See: https://github.com/simplecov-ruby/simplecov#custom-filter-class
# See: https://github.com/simplecov-ruby/simplecov#groups
module Kettle
  module Soup
    module Cover
      module Filters
        class GtLineFilter < SimpleCov::Filter
          def matches?(source_file)
            source_file.lines.count > filter_argument
          end
        end
      end
    end
  end
end
