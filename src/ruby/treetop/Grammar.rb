require 'polyglot'
require 'treetop'

Treetop.load 'grammar/tokens'
Treetop.load 'grammar/emerald'

# Class
class Grammer
  @@parser = EmeraldParser.new

  text = File.open('../../test/treetop/samples/emerald/tests/valid/nested/1.emr').read
  text2 = File.open('../../test/treetop/samples/emerald/tests/valid/nested/4.emr').read

  tests = [
    text.chomp,
    text2.chomp
  ]

  tests.each do |test|
    parsed = @@parser.parse(test)

    if parsed.nil?
      puts "Failed:\n"
      puts "===================================="
      puts test
      puts "====================================\n\n"
      puts @@parser.failure_reason
      puts "\n"
    else
      puts "Passed:\n"
      puts "===================================="
      puts test
      puts "====================================\n\n"
    end
  end
end
