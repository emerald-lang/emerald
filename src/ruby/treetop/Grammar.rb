require 'polyglot'
require 'treetop'
require_relative 'nodes/Attribute'
require_relative 'nodes/AttributeList'
require_relative 'nodes/Comment'
require_relative 'nodes/IndentLine'
require_relative 'nodes/IndentNested'
require_relative 'nodes/Line'
require_relative 'nodes/List'
require_relative 'nodes/Nested'
require_relative 'nodes/Node'
require_relative 'nodes/Root'
require_relative 'nodes/StringNode'
require_relative 'nodes/TagStatement'

Treetop.load 'grammar/tokens'
Treetop.load 'grammar/emerald'

# Class
class Grammer
  @@parser = EmeraldParser.new

  text = File.open('../../test/treetop/samples/emerald/tests/valid/html/2.emr').read
  tests = [text.chomp]

  tests.each do |test|
    parsed = @@parser.parse(test)

    if parsed.nil?
      puts "Failed:\n"
      puts "===================================="
      test.each_line.with_index {|line, i| puts "#{i + 1} #{line}"}
      puts "====================================\n\n"
      puts @@parser.failure_reason
      puts "\n"
    else
      puts "Passed:\n"
      puts "===================================="
      puts test
      parsed.to_html()
      puts "====================================\n\n"
    end
  end
end
