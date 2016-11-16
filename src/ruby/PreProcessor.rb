#!/usr/bin/env ruby

require_relative 'Grammar'

#
# Preprocess the emerald code and add notion of indentation so it may be parsed
# by a context free grammar. Removes all whitespace and adds braces to denote
# indentation.
#
module PreProcessor
  @in_literal = false
  @current_indent = 0
  @new_indent = 0
  @b_count = 0
  @output = ''

  # Process the emerald to remove indentation and replace with brace convention
  # for an easier time parsing with context free grammar
  def self.process_emerald(file_name)
    input = File.open(file_name, 'r').read

    input.each_line do |line|
      next if line.lstrip.empty?
      new_indent = line.length - line.lstrip.length

      check_new_indent(new_indent)
      parse_literal_whitespace(line)
      check_if_suffix_arrow(line)
    end
    print_remaining_braces

    @output
  end

  # Compares the value of the new_indent with the old indentation.
  # Invoked by: process_emerald
  def self.check_new_indent(new_indent)
    if new_indent > @current_indent
      new_indent_greater(new_indent)
    elsif new_indent < @current_indent && new_indent.nonzero?
      new_indent_lesser(new_indent)
    end
  end

  # Invoked by: check_new_indent
  def self.new_indent_greater(new_indent)
    unless @in_literal
      @output += "{\n"
      @b_count += 1
      @current_indent = new_indent
    end
  end

  # Invoked by: check_new_indent
  def self.new_indent_lesser(new_indent)
    if @in_literal
      append_closing_braces(new_indent)
    else
      append_opening_braces(new_indent)
    end
    @current_indent = new_indent
  end

  # Append closing braces if in literal and new indent is less than old one
  def self.append_closing_braces(new_indent)
    @output += "$\n"
    @in_literal = false

    (2..((@current_indent - new_indent) / 2)).each do
      @output += "}\n"
      @b_count -= 1
    end
  end

  # Append opening braces if not in literal and new indent is less than old one
  def self.append_opening_braces(new_indent)
    (1..((@current_indent - new_indent) / 2)).each do
      @output += "}\n"
      @b_count -= 1
    end
  end

  # Crop off only Emerald indent whitespace to preserve whitespace in the
  # literal. Since $ is the end character, we need to escape it in the literal.
  def self.parse_literal_whitespace(line)
    @output += if @in_literal
                 (line[@current_indent..-1] || '').gsub('$', '\$')
               else
                 line.lstrip
               end
  end

  # Check if the suffic of the line is the 'arrow rule'
  def self.check_if_suffix_arrow(line)
    if line.rstrip.end_with?('->')
      @in_literal = true
      @current_indent += 2
    end
  end

  # Iterate through the brace count and print the remaining braces.
  def self.print_remaining_braces
    (1..@b_count).each do
      @output += "}\n"
    end
  end
end
