# frozen_string_literal: true

require "kettle/soup/cover/tasks"

# Lightly modified from: https://thoughtbot.com/blog/test-rake-tasks-like-a-boss
RSpec.describe "rake coverage" do
  let(:rake) { Rake::Task }
  let(:task_name) { self.class.top_level_description.sub(/\Arake /, "") }
  let(:task_dir) { "lib/kettle/soup/cover/rakelib/" }
  let(:task_path) { File.join(task_dir, task_name.split(":").first) }
  let(:task_args) { [] }

  before do
    Rake::Task.clear
  end

  it "has name as coverage" do
    expect(task_name).to eq("coverage")
  end

  it "has task path" do
    expect(task_path).to eq("lib/kettle/soup/cover/rakelib/coverage")
  end

  context "when defined" do
    subject(:definition) { rake_task }

    let(:rake_task) { rake[task_name] }

    it "does not raise error" do
      block_is_expected.to_not raise_error
    end

    context "when invoked" do
      subject(:invocation) { invoked }

      let(:invoked) { rake_task.invoke(*task_args) }

      it "does not raise error" do
        block_is_expected.to_not raise_error
      end

      # We can't really test this because the task isn't really running since we are already inside the self-safe task!
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
