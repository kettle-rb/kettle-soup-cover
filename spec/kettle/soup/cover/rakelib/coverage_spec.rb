# frozen_string_literal: true

require "kettle/soup/cover/tasks"

# rubocop:disable RSpec/DescribeClass
# rubocop:disable RSpec/MultipleMemoizedHelpers
# Lightly modified from: https://thoughtbot.com/blog/test-rake-tasks-like-a-boss
RSpec.describe "rake coverage" do
  let(:rake) { Rake::Application.new }
  let(:task_name) { self.class.top_level_description.sub(/\Arake /, "") }
  let(:task_dir) { "lib/kettle/soup/cover/rakelib/" }
  let(:task_path) { File.join(task_dir, task_name.split(":").first) }
  let(:gem_root) { File.expand_path("../../../../../..", __FILE__) }
  let(:task_args) { [] }
  let(:rake_task) { rake[task_name] }

  def loaded_files_excluding_current_rake_file
    $".reject { |file| file == "#{task_path}.rake" }
  end

  before do
    Rake.application = rake
    Kettle::Soup::Cover.install_tasks
    Rake.application.rake_require(task_path, [gem_root], loaded_files_excluding_current_rake_file)
    Rake.application.rake_require("spec/config/mocks/test_task", [gem_root], loaded_files_excluding_current_rake_file)
    rake_task.reenable # if this task was the one invoked to run the test suite it will have disappeared
    # test task is a dependency of the coverage task, so it must exist
  end

  it "has a gem root" do
    expect(gem_root).to end_with("kettle-soup-cover")
  end

  it "has name as coverage" do
    expect(task_name).to eq("coverage")
  end

  it "has task path" do
    expect(task_path).to eq("lib/kettle/soup/cover/rakelib/coverage")
  end

  context "when defined" do
    subject(:definition) { rake_task }

    it "does not raise error" do
      block_is_expected.not_to raise_error
    end

    context "when invoked" do
      subject(:invocation) { invoked }

      let(:invoked) { rake_task.invoke(*task_args) }

      it "does not raise error" do
        block_is_expected.not_to raise_error
      end

      context "when OPEN_BIN empty" do
        before do
          stub_const("Kettle::Soup::Cover::OPEN_BIN", "")
        end

        it "does not raise error" do
          block_is_expected.not_to raise_error
        end

        it "outputs where to find coverage report" do
          block_is_expected.to output("Kettle::Soup::Cover::OPEN_BIN not configured. Coverage report is at coverage/index.html\n").to_stdout
        end
      end

      context "when OPEN_BIN set to unavailable executable" do
        before do
          stub_const("Kettle::Soup::Cover::OPEN_BIN", "blah")
        end

        it "does not raise error" do
          block_is_expected.not_to raise_error
        end

        it "outputs where to find coverage report" do
          block_is_expected.to output("Configured Kettle::Soup::Cover::OPEN_BIN (blah) not available. Coverage report is at coverage/index.html\n").to_stdout
        end
      end
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
# rubocop:enable RSpec/DescribeClass
