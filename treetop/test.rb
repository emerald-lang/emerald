require 'polyglot'
require 'treetop'

Treetop.load "grammar/emerald"

parser = EmeraldParser.new
p parser.parse('header ( alt )')
