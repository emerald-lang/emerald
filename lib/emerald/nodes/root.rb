#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'Node'

# A base piece of an Emerald file
class Root < Node
  def to_html(context)
    elements
      .map { |e| e.to_html(context) }
      .join("\n")
  end
end
