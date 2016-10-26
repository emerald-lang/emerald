#!/usr/bin/env ruby

require_relative 'Grammar'

#
# Preprocess the emerald code and add notion of indentation so it may be parsed
# by a context free grammar. Removes all whitespace and adds braces to denote
# indentation.
#
module PreProcessor
  def self.process_emerald
    input = File.open("sample.emr", "r").read

    current_indent = 0; new_indent = 0; b_count = 0; output = ''

    input.each_line do |line|
      # remove any blank lines for intermediate form
      next if line.lstrip.length == 0

      new_indent = line.length - line.lstrip.length

      if new_indent > current_indent
        output += "{\n"; b_count += 1
        current_indent = new_indent
      elsif new_indent < current_indent && new_indent != 0
        for i in 1..((current_indent - new_indent) / 2) do
          output += "}\n"; b_count -= 1
        end
        current_indent = new_indent
      end

      output += line.lstrip
    end

    # Print out remaining braces.
    for i in 1..b_count do
      output += "}\n"
    end

    output
  end
end
