require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'pre-commit'

RSpec::Core::RakeTask.new(:test)

task :setup do
  sh 'pre-commit install'
  sh 'git config pre-commit.checks "[rubocop]"'
end

task :default => :test
