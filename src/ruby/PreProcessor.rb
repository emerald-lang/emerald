#!/usr/bin/env ruby

require_relative 'Grammar'

#
# Preprocess the emerald code and add notion of indentation so it may be parsed
# by a context free grammar. Removes all whitespace and adds braces to denote
# indentation.
#
module PreProcessor
  def self.process_emerald(file_name)
    input = File.open(file_name, "r").read

    in_literal = false;
    current_indent = 0; new_indent = 0; b_count = 0; output = ''

    input.each_line do |line|
      # remove any blank lines for intermediate form
      next if line.lstrip.length == 0

      new_indent = line.length - line.lstrip.length

      if new_indent > current_indent
        unless in_literal
          output += "{\n"; b_count += 1
          current_indent = new_indent
        end
      elsif new_indent < current_indent && new_indent != 0
        if in_literal
          output += "$\n"
          in_literal = false
          for i in 2..((current_indent - new_indent) / 2) do
            output += "}\n"; b_count -= 1
          end
        else
          for i in 1..((current_indent - new_indent) / 2) do
            output += "}\n"; b_count -= 1
          end
        end
        current_indent = new_indent
      end

      if in_literal
        # Crop off only Emerald indent whitespace
        # to preserve whitespace in the literal
        output += (line[current_indent..-1] || "")
          .gsub('$', '\$') 
        # $ is our end character, so 
        # we need to escape it in the literal
      else
        output += line.lstrip
      end

      if line.rstrip.end_with?("->")
        in_literal = true
        current_indent += 2
      end
    end

    # Print out remaining braces.
    for i in 1..b_count do
      output += "}\n"
    end

    output
  end
end
