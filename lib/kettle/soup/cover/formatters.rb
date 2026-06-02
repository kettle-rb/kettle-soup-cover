# frozen_string_literal: true

module Kettle
  module Soup
    module Cover
      module_function

      def configure_formatters!
        if Constants::TURBO_TESTS_WORKER
          SimpleCov.at_exit { SimpleCov.result }
        elsif Constants::MULTI_FORMATTERS
          Kettle::Soup::Cover::Loaders.load_formatters
        else
          require "simplecov-html"
          SimpleCov.formatter(SimpleCov::Formatter::HTMLFormatter)
        end
      end
    end
  end
end
