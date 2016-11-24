#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'Grammar'

module Emerald
  #
  # Preprocess the emerald code and add notion of indentation so it may be parsed
  # by a context free grammar. Removes all whitespace and adds braces to denote
  # indentation.
  #
  class PreProcessor
    def initialize
      @in_literal = false
      @current_indent = 0
      @new_indent = 0
      @b_count = 0
      @output = ''
    end

    # Reset class variables, used for testing
    def reset
      @in_literal = false
      @current_indent = 0
      @new_indent = 0
      @b_count = 0
      @output = ''
    end

    # Process the emerald to remove indentation and replace with brace convention
    # for an easier time parsing with context free grammar
    def process_emerald(input)
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
    def check_new_indent(new_indent)
      if new_indent > @current_indent
        new_indent_greater(new_indent)
      elsif new_indent < @current_indent
        new_indent_lesser(new_indent)
      end
    end

    # Invoked by: check_new_indent
    def new_indent_greater(new_indent)
      return if @in_literal
      @output += "{\n"
      @b_count += 1
      @current_indent = new_indent
    end

    # Invoked by: check_new_indent
    def new_indent_lesser(new_indent)
      if @in_literal
        append_closing_braces(new_indent)
      else
        append_opening_braces(new_indent)
      end
      @current_indent = new_indent
    end

    # Append closing braces if in literal and new indent is less than old one
    def append_closing_braces(new_indent)
      @output += "$\n"
      @in_literal = false

      (2..((@current_indent - new_indent) / 2)).each do
        @output += "}\n"
        @b_count -= 1
      end
    end

    # Append opening braces if not in literal and new indent is less than old one
    def append_opening_braces(new_indent)
      (1..((@current_indent - new_indent) / 2)).each do
        @output += "}\n"
        @b_count -= 1
      end
    end

    # Crop off only Emerald indent whitespace to preserve whitespace in the
    # literal. Since $ is the end character, we need to escape it in the literal.
    def parse_literal_whitespace(line)
      @output += if @in_literal
                   (line[@current_indent..-1] || '').gsub('$', '\$')
                 else
                   line.lstrip
                 end
    end

    # Check if the suffic of the line is the 'arrow rule'
    def check_if_suffix_arrow(line)
      return unless line.rstrip.end_with?('->')
      @in_literal = true
      @current_indent += 2
    end

    # Iterate through the brace count and print the remaining braces.
    def print_remaining_braces
      (1..@b_count).each do
        @output += "}\n"
      end
    end
  end
end
