require 'polyglot'
require 'treetop'
require_relative 'Node'

Treetop.load 'grammar/tokens'
Treetop.load 'grammar/emerald'

# Class
class Grammer
  @@parser = EmeraldParser.new

  text = File.open('../../test/treetop/samples/emerald/tests/valid/general/2.emr').read
  # text2 = File.open('../../test/treetop/samples/emerald/tests/valid/comments/2.emr').read
  # text3 = File.open('../../test/treetop/samples/emerald/tests/valid/metas/2.emr').read
  # text4 = File.open('../../test/treetop/samples/emerald/tests/valid/text/2.emr').read
  # text5 = File.open('../../test/treetop/samples/emerald/tests/valid/nested/2.emr').read
  # text6 = File.open('../../test/treetop/samples/emerald/tests/valid/temp.emr').read

  tests = [
    text.chomp
    # text2.chomp,
    # text3.chomp,
    # text4.chomp,
    # text5.chomp,
    # text6.chomp
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
      puts parsed.to_html()
      puts "====================================\n\n"
    end
  end
end
