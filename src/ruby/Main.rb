#!/usr/bin/env ruby

require_relative 'Grammar'
require_relative 'PreProcessor'


# TODO: add command line arguments.
# - b --beautify (format the html - minified by default)
# - p --source_path (source destination to write file to)

# Parses a context free grammar from the preprocessed emerald and generates
# html associated with corresponding abstract syntax tree.
class Main
  unless ARGV.length == 0
    file_name = ARGV[0]
  else
    file_name = "index.emr"
  end

  preprocessed_emerald = PreProcessor.process_emerald(file_name)
  abstract_syntax_tree = Grammer.parse_grammar(preprocessed_emerald)
  out = abstract_syntax_tree.to_html

  puts out
  File.open(file_name + '.html', "w") do |file|
    file.write(out)
  end
end
