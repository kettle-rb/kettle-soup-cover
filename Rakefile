# frozen_string_literal: true

require "bundler/gem_tasks"

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

desc "alias test task to spec"
task test: :spec

# Setup Reek
begin
  require "reek/rake/task"

  Reek::Rake::Task.new do |t|
    t.fail_on_error = true
    t.verbose = false
    t.source_files = "{app,config,db,lib,test}/**/*.rb"
  end
rescue LoadError
  task(:reek) do
    warn("reek is disabled")
  end
end

# Setup Yard
begin
  require "yard"

  YARD::Rake::YardocTask.new(:yard)
rescue LoadError
  task(:yard) do
    warn("yard is disabled")
  end
end

# Setup RuboCop-LTS
begin
  require "rubocop/lts"
  Rubocop::Lts.install_tasks
rescue LoadError
  task(:rubocop_gradual) do
    warn("RuboCop (Gradual) is disabled")
  end
end

# Setup stone_checksums
begin
  require "stone_checksums"
  GemChecksums.install_tasks
rescue LoadError
  task("build:generate_checksums") do
    warn("gem_checksums is not available")
  end
end

require "kettle-soup-cover"
Kettle::Soup::Cover.install_tasks

task default: %i[spec rubocop]
