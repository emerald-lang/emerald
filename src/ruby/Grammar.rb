#!/usr/bin/env ruby

require 'polyglot'
require 'treetop'

# Require all treetop nodes for grammar
Dir[File.dirname(__FILE__) + '/nodes/*.rb'].each {|f| require f}

Treetop.load 'grammar/tokens'
Treetop.load 'grammar/emerald'

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
      puts "====================================\n\n"
    end

    parsed
  end
end
