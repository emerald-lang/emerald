require 'polyglot'
require 'treetop'

Treetop.load "grammar/tokens"
Treetop.load "grammar/emerald"

parser = EmeraldParser.new

# If nil, raise exception, stop compilation and send
# an email to me notifying of the error, and the input
# that caused it. Else, send the input to scala where the
# code generation phase will be handled.

file = File.open("../../test/treetop/samples/emerald/valid/temp.emr").read
nested = File.open("../../test/treetop/samples/emerald/valid/nested.emr").read

tests = [
  "metas\na",
  "metas a",
  "metas strong",
  "metas",
  "a",
  "a(accept = \"test this out\")",
  file.chomp,
  nested
]

tests.each do |test|
  parsed = parser.parse(test)

  if parsed.nil?
    puts "Failed: #{test}"
    puts parser.failure_reason
  else
    puts "Passed #{test}"
  end
end
