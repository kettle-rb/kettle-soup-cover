# frozen_string_literal: true

namespace :turbo_tests do
  desc "Prepare isolated coverage output for turbo_tests2 workers"
  task :setup do
    if Kettle::Soup::Cover.turbo_tests_coverage?
      Kettle::Soup::Cover.clear_turbo_tests_coverage_dir!
    end
  end

  desc "Collate turbo_tests2 worker coverage reports"
  task :cleanup do
    Kettle::Soup::Cover.collate_turbo_tests_coverage!
  end
end
