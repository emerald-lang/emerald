#!/usr/bin/env ruby

require 'polyglot'
require 'treetop'

# Require all treetop nodes for grammar
Dir[File.dirname(__FILE__) + '/nodes/*.rb'].each { |f| require f }

Treetop.load __dir__ + '/grammar/tokens'
Treetop.load __dir__ + '/grammar/emerald'

#
# Interface which interacts with emerald context free grammar. Parses the
# preprocessed Emerald and prints out success if the parser was successful and
# failure if there was an error when parsing. Returns an abstract syntax tree.
#
module Grammer
  @parser = EmeraldParser.new

  # Parse the preprocessed emerald text and print failure if it fails the
  # parsing stage
  def self.parse_grammar(text)
    parsed = @parser.parse(text)

    if parsed.nil?
      print_failure(text)
    else
      print_passed(text)
    end

    parsed
  end

  # Print out faliure reason and lines
  def self.print_failure(text)
    puts "Failed:\n"
    puts '===================================='
    text.each_line.with_index { |line, i| puts "#{i + 1} #{line}" }
    puts "====================================\n\n"
    puts parser.failure_reason
    puts "\n"
  end

  # Print success
  def self.print_passed(text)
    puts "Passed:\n"
    puts '===================================='
    puts text
    puts "====================================\n\n"
  end
end
