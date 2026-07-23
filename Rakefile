# frozen_string_literal: true

require "bundler/gem_tasks"

require "rdoc/task"

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.title    = "Gretel::JSONLD"
  rdoc.options << "--line-numbers"
  rdoc.rdoc_files.include("README.md")
  rdoc.rdoc_files.include("lib/**/*.rb")
end

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)
task default: :spec
