require 'pre-commit'

task default: ["test"]

task :setup do
  sh 'pre-commit install'
  sh 'git config pre-commit.checks "[rubocop]"'
end

task :test do
  ruby "src/test/preprocessor/PreProcessorSuite.rb"
  ruby "src/test/treetop/TreetopSuite.rb"
  ruby "src/test/EmeraldSuite.rb"
end
