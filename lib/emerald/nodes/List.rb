#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'Node'

# TODO: Refactor this and update doc comment
# Multiple head elements I think
class List < Node
  def to_html(_context)
    if elements[0].text_value == 'styles'
      elements[4].elements.map do |e|
        "<link rel='stylesheet' href=#{e.text_value.strip} />"
      end.join("\n")
    elsif elements[0].text_value == 'scripts'
      elements[4].elements.map do |e|
        "<script type='text/javascript' src=#{e.text_value.strip}></script>"
      end.join("\n")
    elsif elements[0].text_value == 'metas'
      elements[4].elements.map do
        ''
      end.join("\n")
    end
  end
end
