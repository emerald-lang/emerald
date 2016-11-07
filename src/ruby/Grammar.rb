#!/usr/bin/env ruby

require 'polyglot'
require 'treetop'

# Require all treetop nodes for grammar
Dir[File.dirname(__FILE__) + '/nodes/*.rb'].each { |f| require f }

Treetop.load 'grammar/tokens'
Treetop.load 'grammar/emerald'

#
# Interface which interacts with emerald context free grammar.
#
module Grammer
  @parser = EmeraldParser.new

  def self.parse_grammar(text)
    parsed = @parser.parse(text)

    if parsed.nil?
      print_failure(text)
    else
      print_passed(text)
    end

    parsed
  end

  def self.print_failure(text)
    puts "Failed:\n"
    puts '===================================='
    text.each_line.with_index { |line, i| puts "#{i + 1} #{line}" }
    puts "====================================\n\n"
    puts parser.failure_reason
    puts "\n"
  end

  def self.print_passed(text)
    puts "Passed:\n"
    puts '===================================='
    puts text
    puts "====================================\n\n"
  end
end
