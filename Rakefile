task default: ["test"]

task :setup do
  sh "ln -s $PWD/bin/pre-commit .git/hooks/pre-commit"
  sh "chmod +x .git/hooks/pre-commit"
end

task :test do
  ruby "src/test/preprocessor/PreProcessorSuite.rb"
  ruby "src/test/treetop/TreetopSuite.rb"
end
