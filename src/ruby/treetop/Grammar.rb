require 'polyglot'
require 'treetop'
require_relative 'nodes/Node'

Treetop.load 'grammar/tokens'
Treetop.load 'grammar/emerald'

# Class
class Grammer
  @@parser = EmeraldParser.new

  text = File.open('../../test/treetop/samples/emerald/tests/valid/html/3.emr').read

  tests = [
    text.chomp
  ]

  tests.each do |test|
    parsed = @@parser.parse(test)

    if parsed.nil?
      puts "Failed:\n"
      puts "===================================="

      test.each_line.with_index do |line, i|
        puts "#{i + 1} #{line}"
      end

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
