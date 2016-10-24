#!/usr/bin/env ruby

#
# Preprocess the emerald code and add notion of indentation so it may be parsed
# by a context free grammar.
#
class PreProcessor
  # pass once, remove any whitespace that is not on a line with text.
  # pass second time, add {} for nesting.
  # pass input to Grammar file to be parsed by a CFG.
  f = File.open("sample.emr")

  puts f.read
end
