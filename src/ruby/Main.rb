#!/usr/bin/env ruby

require 'thor'
require 'htmlbeautifier'

require_relative 'Grammar'
require_relative 'PreProcessor'

# Parses a context free grammar from the preprocessed emerald and generates
# html associated with corresponding abstract syntax tree.
module Emerald
  class Main < Thor
    class_option :beautify

    # main emerald option, processes the emerald file, generates an abstract
    # syntax tree based on the output from the preprocessing.
    desc 'Emerald', 'Process a file and convert it to emerald.'
    def main
      file_name = 'index.emr'
      preprocessed_emerald = PreProcessor.process_emerald(file_name)
      abstract_syntax_tree = Grammer.parse_grammar(preprocessed_emerald)
      out = abstract_syntax_tree.to_html
      Emerald.write_html(out, file_name, options["beautify"])
    end

    # Prints help and usage for app.
    def help
      puts "Emerald, the language agnostic templating engine."
    end
  end

  # write html to file and beautify it if the beautify global option is set to
  # true.
  def self.write_html(html_output, file_name, beautify)
    File.open(file_name + '.html', 'w') do |emerald_file|
      # html beautifier doesn't support html5.
      # need to make pr to gem to update its support
      html_output = HtmlBeautifier.beautify(html_output) if beautify
      emerald_file.write(html_output)
    end
  end

  Main.start(ARGV)
end
