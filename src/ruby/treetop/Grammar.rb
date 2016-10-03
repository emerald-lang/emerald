require 'polyglot'
require 'treetop'

Treetop.load 'grammar/tokens'
Treetop.load 'grammar/emerald'

# Class
class Grammer
  @@parser = EmeraldParser.new

  text = File.open('../../test/treetop/samples/emerald/tests/valid/nested.emr').read

  tests = [
    text.chomp
  ]

  tests.each do |test|
    parsed = @@parser.parse(test)

    if parsed.nil?
      puts "Failed: #{test}"
      puts @@parser.failure_reason
    else
      puts "Passed #{test}"
      parsed.each do |t|
        puts t
      end
    end
  end
end
