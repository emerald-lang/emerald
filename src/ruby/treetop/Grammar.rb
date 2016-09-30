require 'polyglot'
require 'treetop'

Treetop.load 'grammar/tokens'
Treetop.load 'grammar/emerald'

class Grammer
  @@parser = EmeraldParser.new

  text = File.open('../../test/treetop/samples/emerald/tests/valid/text/1.emr').read
  text2 = File.open('../../test/treetop/samples/emerald/tests/valid/text/2.emr').read
  text3 = File.open('../../test/treetop/samples/emerald/tests/valid/text/3.emr').read

  tests = [
    text.chomp,
    text2.chomp,
    text3.chomp
  ]

  tests.each do |test|
    parsed = @@parser.parse(test)

    if parsed.nil?
      puts 'Failed: #{test}'
      puts @@parser.failure_reason
    else
      puts 'Passed #{test}'
    end
  end
end
