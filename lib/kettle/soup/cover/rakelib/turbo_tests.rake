# frozen_string_literal: true

namespace :turbo_tests do
  task :setup do
    next unless Kettle::Soup::Cover.turbo_tests_coverage?

    Kettle::Soup::Cover.clear_turbo_tests_coverage_dir!
  end

  task :cleanup do
    Kettle::Soup::Cover.collate_turbo_tests_coverage!
  end
end
