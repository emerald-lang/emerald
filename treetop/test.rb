require 'polyglot'
require 'treetop'

Treetop.load "emerald"

parser = EmeraldParser.new
p parser.parse('doctype html')
