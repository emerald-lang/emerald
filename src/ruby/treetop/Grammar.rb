require 'polyglot'
require 'treetop'

Treetop.load "grammar/tokens"
Treetop.load "grammar/emerald"

parser = EmeraldParser.new

# If nil, raise exception, stop compilation and send
# an email to me notifying of the error, and the input
# that caused it. Else, send the output of tt to scala
# where the code generation phase will be handled.

file = File.open("../../test/treetop/samples/emerald/tests/valid/temp.emr").read
metas = File.open("../../test/treetop/samples/emerald/tests/valid/metas/1.emr").read
metas2 = File.open("../../test/treetop/samples/emerald/tests/valid/metas/2.emr").read
metas3 = File.open("../../test/treetop/samples/emerald/tests/valid/metas/3.emr").read
# text = File.open("../../test/treetop/samples/emerald/tests/valid/text.emr").read

tests = [
  file.chomp,
  metas.chomp,
  metas2.chomp,
  metas3.chomp
]

tests.each do |test|
  parsed = parser.parse(test)

  if parsed.nil?
    puts "Failed: #{test}"
    puts parser.failure_reason
  else
    puts "Passed #{test}"
    # p parsed
  end
end
