# frozen_string_literal: true

require "kettle/soup/cover/tasks"

# rubocop:disable RSpec/DescribeClass
RSpec.describe "rake turbo_tests:cleanup" do
  let(:rake) { Rake::Application.new }
  let(:gem_root) { File.expand_path("../../../../../..", __FILE__) }
  let(:loaded_files) { $".reject { |file| file.end_with?("turbo_tests.rake") } }

  before do
    Rake.application = rake
    Kettle::Soup::Cover.install_tasks
    Rake.application.rake_require("lib/kettle/soup/cover/rakelib/turbo_tests", [gem_root], loaded_files)
  end

  it "collates turbo_tests2 coverage on cleanup" do
    allow(Kettle::Soup::Cover).to receive(:collate_turbo_tests_coverage!).and_return(:collated)

    rake["turbo_tests:cleanup"].invoke

    expect(Kettle::Soup::Cover).to have_received(:collate_turbo_tests_coverage!)
  end
end

RSpec.describe "rake turbo_tests:setup" do
  let(:rake) { Rake::Application.new }
  let(:gem_root) { File.expand_path("../../../../../..", __FILE__) }
  let(:loaded_files) { $".reject { |file| file.end_with?("turbo_tests.rake") } }

  before do
    Rake.application = rake
    Kettle::Soup::Cover.install_tasks
    Rake.application.rake_require("lib/kettle/soup/cover/rakelib/turbo_tests", [gem_root], loaded_files)
  end

  it "clears turbo_tests2 coverage when coverage is enabled" do
    allow(Kettle::Soup::Cover).to receive(:turbo_tests_coverage?).and_return(true)
    allow(Kettle::Soup::Cover).to receive(:clear_turbo_tests_coverage_dir!)

    rake["turbo_tests:setup"].invoke

    expect(Kettle::Soup::Cover).to have_received(:clear_turbo_tests_coverage_dir!)
  end
end
# rubocop:enable RSpec/DescribeClass
