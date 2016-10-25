#!/usr/bin/env ruby

require 'polyglot'
require 'treetop'

Dir[File.dirname(__FILE__) + '/nodes/*.rb'].each {|f| require f}

Treetop.load 'grammar/tokens'
Treetop.load 'grammar/emerald'

# Parses a context free grammar and generates html associated with corresponding
# abstract syntax tree.
module Grammer
  def self.parse_grammar(text)
    parser = EmeraldParser.new
    parsed = parser.parse(text)

    if parsed.nil?
      puts "Failed:\n"
      puts "===================================="
      text.each_line.with_index {|line, i| puts "#{i + 1} #{line}"}
      puts "====================================\n\n"
      puts parser.failure_reason
      puts "\n"
    else
      puts "Passed:\n"
      puts "===================================="
      puts text
      # p parsed
      parsed.to_html()
      puts "====================================\n\n"
    end
  end
end
