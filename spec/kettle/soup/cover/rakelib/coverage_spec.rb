# frozen_string_literal: true

require "kettle/soup/cover/tasks"

# rubocop:disable RSpec/DescribeClass
# rubocop:disable RSpec/MultipleMemoizedHelpers
# Lightly modified from: https://thoughtbot.com/blog/test-rake-tasks-like-a-boss
RSpec.describe "rake coverage" do
  let(:rake)      { Rake::Application.new }
  let(:task_name) { self.class.top_level_description.sub(/\Arake /, "") }
  let(:task_dir) { "lib/kettle/soup/cover/rakelib/" }
  let(:task_path) { File.join(task_dir, task_name.split(":").first) }
  let(:gem_root) { File.expand_path("../../../../../..", __FILE__) }
  let(:task_args) { [] }
  let(:rake_task) { rake[task_name] }

  def loaded_files_excluding_current_rake_file
    $".reject {|file| file == "#{task_path}.rake" }
  end

  before do
    Rake.application = rake
    rake_task.reenable # if this task was the one invoked to run the test suite it will have disappeared
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

      # We can't really test this because the task isn't really running since we are already inside the self-same task!
      # context "with output" do
      #   subject(:std_output) { output }
      #
      #   let(:output) { capture(:stdout) { invoked } }
      #
      #   it "has empty expected output" do
      #     expect(output).to eq("")
      #   end
      # end
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
# rubocop:enable RSpec/DescribeClass
