#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'BaseScopeFn'

# Base class for scope functions
class With < BaseScopeFn
  def to_html(body, context)
    var = elements[2].content(context)

    body.to_html(var)
  end
end
