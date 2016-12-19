#!/usr/bin/env ruby
# frozen_string_literal: true

require 'polyglot'
require 'treetop'

# Require all treetop nodes for grammar
Dir[File.dirname(__FILE__) + '/nodes/*.rb'].each { |f| require f }

Treetop.load __dir__ + '/grammar/tokens'
Treetop.load __dir__ + '/grammar/variables'
Treetop.load __dir__ + '/grammar/scopes'
Treetop.load __dir__ + '/grammar/emerald'

#
# Interface which interacts with emerald context free grammar. Parses the
# preprocessed Emerald and prints out success if the parser was successful and
# failure if there was an error when parsing. Returns an abstract syntax tree.
#
module Grammar
  # When the parser fails on a line from user input
  class ParserError < StandardError
    LINES_BEFORE = 3
    LINES_AFTER = 1

    def initialize(line_number, reason, source)
      @line_number = line_number
      @reason = reason
      @source = source
    end

    def message
      messages = []
      if match = @reason.match(/(Expected .+?) at line/)
        messages << match[1]
      else
        messages << @reason
      end

      lines = @source.split(/\n/)
      LINES_BEFORE.downto(1).each do |i|
        messages << '    ' + lines[@line_number - i - 1] if lines[@line_number - i - 1]
      end
      messages << '>>> ' + lines[@line_number - 1]
      1.upto(LINES_AFTER).each do |i|
        messages << '    ' + lines[@line_number + i - 1] if lines[@line_number + i - 1]
      end

      messages.join("\n")
    end
  end

  # When the parser fails on a line added only in preprocessing
  class PreProcessorError < ParserError
    def say
      messages = []
      messages << "Error parsing in pre-processed Emerald. This is likely a bug."
      messages << @reason
      messages.concat(@source.lines.with_index { |line, i| puts "#{i + 1} #{line}" })

      messages.join("\n")
    end
  end

  @parser = EmeraldParser.new

  # Parse the preprocessed emerald text and print failure if it fails the
  # parsing stage
  def self.parse_grammar(text, original, source_map)
    parsed = @parser.parse(text)

    if parsed.nil?
      source_line = source_map[@parser.failure_line][:source_line]
      if source_line.nil?
        raise PreProcessorError.new(
          @parser.failure_line,
          @parser.failure_reason,
          text
        )
      end
      raise ParserError.new(
        source_line,
        @parser.failure_reason,
        original
      )
    end

    parsed
  end
end
