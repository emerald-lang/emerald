#!/usr/bin/env ruby

#
# Emerald, the language agnostic templating engine.
# Copyright 2016, Emerald Language (MIT)
#

require 'thor'
require 'htmlbeautifier'

require_relative 'Grammar'
require_relative 'PreProcessor'

# Parses a context free grammar from the preprocessed emerald and generates
# html associated with corresponding abstract syntax tree.
module Emerald
  class Main < Thor
    class_option :beautify # specify if you wante the code formatted
    class_option :language # specify what templating engine you want to transpile to

    # main emerald option, processes the emerald file, generates an abstract
    # syntax tree based on the output from the preprocessing.
    desc 'process', 'Process a file or folder (recursively) and convert it to emerald.'
    # option :name - TODO remember how to do method specific options.
    def process(file_name)
      preprocessed_emerald = PreProcessor.process_emerald(file_name)
      puts preprocessed_emerald
      abstract_syntax_tree = Grammer.parse_grammar(preprocessed_emerald)
      Emerald.write_html(abstract_syntax_tree.to_html, file_name,
                         options["beautify"])
    end
  end

  # Write html to file and beautify it if the beautify global option is set to
  # true.
  def self.write_html(html_output, file_name, beautify)
    File.open(file_name + '.html', 'w') do |emerald_file|
      html_output = HtmlBeautifier.beautify(html_output) if beautify
      emerald_file.write(html_output)
    end
  end

  Main.start(ARGV)
end
