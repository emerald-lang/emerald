require 'polyglot'
require 'treetop'

Treetop.load 'grammar/tokens'
Treetop.load 'grammar/emerald'

# Class
class Grammer
  @@parser = EmeraldParser.new

  text = File.open('../../test/treetop/samples/emerald/tests/valid/general/2.emr').read
  text2 = File.open('../../test/treetop/samples/emerald/tests/valid/comments/1.emr').read

  tests = [
    text.chomp,
    text2.chomp
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
      puts "====================================\n\n"

      # p parsed
    end
  end
end
