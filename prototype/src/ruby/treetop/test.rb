require 'polyglot'
require 'treetop'

Treetop.load "grammar/emerald"

parser = EmeraldParser.new

# If nil, raise exception, stop compilation and send
# an email to me notifying of the error, and the input
# that caused it. Else, send the input to scala where the
# code generation phase will be handled.
p parser.parse("metas\na") # lookup how to do newlines with treetop
p parser.parse('metas a')
p parser.parse('metas strong')
p parser.parse('metas')
p parser.parse('a')
