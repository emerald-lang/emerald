#!/usr/bin/env ruby

require_relative 'Grammar'

#
# Preprocess the emerald code and add notion of indentation so it may be parsed
# by a context free grammar. Removes all whitespace and adds braces to denote
# indentation.
#
module PreProcessor
  # Instance variables
  @in_literal = false
  @current_indent = 0
  @new_indent = 0
  @b_count = 0
  @output = ''

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

  def self.append_closing_braces(new_indent)
    @output += "$\n"
    @in_literal = false

    for i in 2..((@current_indent - new_indent) / 2) do
      @output += "}\n"
      @b_count -= 1
    end
  end

  def self.append_opening_braces(new_indent)
    for i in 1..((@current_indent - new_indent) / 2) do
      @output += "}\n"
      @b_count -= 1
    end
  end

  def self.parse_literal_whitespace(line)
    if @in_literal
      # Crop off only Emerald indent whitespace to preserve
      # whitespace in the literal
      @output += (line[@current_indent..-1] || '').gsub('$', '\$')
    # $ is our end character, so we need to escape it in
    # the literal
    else
      @output += line.lstrip
    end
  end

  def self.check_if_suffix_arrow(line)
    if line.rstrip.end_with?('->')
      @in_literal = true
      @current_indent += 2
    end
  end

  def self.print_remaining_braces
    for i in 1..@b_count do
      @output += "}\n"
    end
  end
end
