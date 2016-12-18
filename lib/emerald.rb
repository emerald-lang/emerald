#!/usr/bin/env ruby
# frozen_string_literal: true

#
# Emerald, the language agnostic templating engine.
# Copyright 2016, Emerald Language (MIT)
#
require 'emerald/version'

require 'json'
require 'thor'
require 'htmlbeautifier'

require_relative 'emerald/grammar'
require_relative 'emerald/preprocessor'

# Parses a context free grammar from the preprocessed emerald and generates
# html associated with corresponding abstract syntax tree.
module Emerald
  # The Emerald CLI
  class CLI < Thor
    class_option :beautify, :type => :boolean, :aliases => 'b'

    def self.exit_on_failure?
      true
    end

    # Main emerald option, processes the emerald file, generates an abstract
    # syntax tree based on the output from the preprocessing.
    desc 'process', 'Process a file or folder (recursively) and converts it to emerald.'
    option :output, aliases: 'o'
    def process(file_name, context_file_name = nil)
      begin
        output_name = options[:output] || file_name
        context =
          if context_file_name
            JSON.parse(IO.read(context_file_name))
          else
            {}
          end

        input = IO.read(file_name)

        Emerald.write_html(
          Emerald.convert(input, context),
          output_name,
          options['beautify']
        )
      rescue Grammar::PreProcessorError, Grammar::ParserError => e
        raise Thor::Error, e.message
      end
    end
  end

  def self.convert(input, context = {})
    preprocessed_emerald, source_map = PreProcessor.new.process_emerald(input)
    abstract_syntax_tree = Grammar.parse_grammar(
      preprocessed_emerald,
      input,
      source_map
    )

    return abstract_syntax_tree.to_html(context)
  end

  # Write html to file and beautify it if the beautify global option is set to
  # true.
  def self.write_html(html_output, file_name, beautify)
    File.open(file_name + '.html', 'w') do |emerald_file|
      html_output = HtmlBeautifier.beautify(html_output) if beautify
      emerald_file.write(html_output)
    end
    puts "Wrote #{file_name + '.html'}"
  end
end
