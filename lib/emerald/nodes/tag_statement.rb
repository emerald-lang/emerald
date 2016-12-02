#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'node'

# A tag
class TagStatement < Node
  def to_html(context)
    opening_tag(context) +
      (
        if !body.empty?
          body.to_html(context)
        else
          ''
        end
      ) +
      closing_tag(context)
  end

  def class_attribute
    unless classes.empty?
      class_names = classes
        .elements
        .map{ |c| c.name.text_value }
        .join(' ')

      " class=\"#{class_names}\""
    else
      ''
    end
  end

  def id_attribute
    unless identifier.empty?
      " id=\"#{identifier.name.text_value}\""
    else
      ''
    end
  end

  def opening_tag(context)
    "<#{tag.text_value}" +
      id_attribute +
      class_attribute +
      (
        if !attributes.empty?
          ' ' + attributes.to_html(context)
        else
          ''
        end
      ) + '>'
  end

  def closing_tag(_context)
    "</#{tag.text_value}>"
  end
end
