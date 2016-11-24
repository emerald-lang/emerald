#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'BaseScopeFn'

# Base class for scope functions
class ScopeFn < BaseScopeFn
  def to_html(body, context)
    elements[0].to_html(body, context)
  end
end
