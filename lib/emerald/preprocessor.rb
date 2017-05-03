#!/usr/bin/env ruby
# frozen_string_literal: true

require 'htmlentities'
require_relative 'grammar'

module Emerald
  #
  # Preprocess the emerald code and add notion of indentation so it may be parsed
  # by a context free grammar. Removes all whitespace and adds braces to denote
  # indentation.
  #
  class PreProcessor
    def initialize
      reset
    end

    # Reset class variables, used for testing
    def reset
      @in_literal = false
      @templateless_literal = false
      @current_indent = 0
      @b_count = 0
      @output = ''
      @encoder = HTMLEntities.new
      @source_map = {}
    end

    # Process the emerald to remove indentation and replace with brace convention
    # for an easier time parsing with context free grammar
    def process_emerald(input)
      input.each_line.with_index do |line, line_number|
        if @in_literal
          if line[0...-1].empty?
            new_indent = @current_indent
            line = " " * @current_indent + "\n"
          else
            new_indent = line.length - line.lstrip.length
          end
        else
          next if line.lstrip.empty?
          new_indent = line.length - line.lstrip.length
        end

        check_new_indent(new_indent)
        @output += remove_indent_whitespace(line)
        @source_map[@output.lines.length] = {
          source_line: line_number + 1
        }
        check_and_enter_literal(line)
      end

      close_tags(0)

      [@output, @source_map]
    end

    # Compares the value of the new_indent with the old indentation.
    # Invoked by: process_emerald
    def check_new_indent(new_indent)
      if new_indent > @current_indent
        open_tags(new_indent)
      elsif new_indent < @current_indent
        close_tags(new_indent)
      end
    end

    def open_tags(new_indent)
      return if @in_literal
      @output += "{\n"
      @b_count += 1
      @current_indent = new_indent
    end

    def close_tags(new_indent)
      if @in_literal
        close_literal(new_indent)
      else
        close_entered_tags(new_indent)
      end
      @current_indent = new_indent
    end

    # Append closing braces if in literal and new indent is less than old one
    def close_literal(new_indent)
      @output += "$\n"
      @in_literal = false

      (2..((@current_indent - new_indent) / 2)).each do
        @output += "}\n"
        @b_count -= 1
      end
    end

    # Append closing braces if not in literal and new indent is less than old one
    def close_entered_tags(new_indent)
      (1..((@current_indent - new_indent) / 2)).each do
        @output += "}\n"
        @b_count -= 1
      end
    end

    # Crop off only Emerald indent whitespace to preserve whitespace in the
    # literal. Since $ is the end character, we need to escape it in the literal.
    def remove_indent_whitespace(line)
      if @in_literal
        # Ignore indent whitespace, only count post-indent as the literal,
        # but keep any extra whitespace that might exist for literals
        cropped = line[@current_indent..-1] || ''
        if @templateless_literal
          # this is a fun one https://www.ruby-forum.com/topic/143645
          cropped = cropped.gsub("\\"){ "\\\\" }
        end

        unless @preserve_html_literal
          cropped = @encoder.encode cropped
        end

        # Escape $ since we use it as a terminator for literals, and encode HTML
        cropped.gsub('$', "\\$")
      else
        line.lstrip
      end
    end

    def check_and_enter_literal(line)
      if line.rstrip.end_with?('->')
        @in_literal = true
        @current_indent += 2
        @templateless_literal = false
        @preserve_html_literal = false
      elsif line.rstrip.end_with?('=>')
        @in_literal = true
        @current_indent += 2
        @templateless_literal = true
        @preserve_html_literal = false
      elsif line.rstrip.end_with?('~>')
        @in_literal = true
        @current_indent += 2
        @templateless_literal = true
        @preserve_html_literal = true
      end
    end
  end
end
