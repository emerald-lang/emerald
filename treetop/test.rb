require 'polyglot'
require 'treetop'

Treetop.load "arithmetic"

parser = ArithmeticParser.new
p parser.parse('1+1')
