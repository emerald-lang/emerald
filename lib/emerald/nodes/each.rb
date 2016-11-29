#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'base_scope_fn'

# Function to map over elements in the context
class Each < BaseScopeFn
  def to_html(body, context)
    vars = collection.content(context)
    key_name = indexed.text_value.length.positive? ? indexed.key_name : nil

    # TODO: clean up somehow
    if vars.is_a? Hash
      vars
        .map do |var, key|
          new_ctx = context.clone
          new_ctx[val_name.text_value] = var
          new_ctx[key_name.text_value] = key if key_name

          body.to_html(new_ctx)
        end
        .join("\n")
    elsif vars.is_a? Array
      vars
        .map.with_index do |var, idx|
          new_ctx = context.clone
          new_ctx[val_name.text_value] = var
          new_ctx[key_name.text_value] = idx if key_name

          body.to_html(new_ctx)
        end
        .join("\n")
    else
      raise 'bad variable type :('
    end
  end
end
