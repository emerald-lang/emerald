#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'node'

# Rule for lists of styles, scripts, and metas
class List < Node
  def to_html(context)
    if elements[4].elements[0].text_value.match(/^\"(.*?)\"/)
      base_list_rule(elements[0].text_value)
    else
      list_attributes_rule(context, elements[0].text_value)
    end
  end

  def base_list_rule(keyword)
    elements[4].elements.map do |e|
      case keyword
      when 'styles'  then "<link rel='stylesheet' href=#{e.text_value.strip} />"
      when 'scripts' then "<script type='text/javascript' src=#{e.text_value.strip}></script>"
      when 'metas' then ''
      end
    end.join("\n")
  end

  def list_attributes_rule(context, keyword)
    output = ''
    elements[4].elements.each do |e|
      temp = ''
      e.elements[0].elements.each do |j|
        temp += "#{j.elements[0].text_value}='#{j.elements[2].to_html(context)}' "
      end

      case keyword
      when 'metas' then output += "<meta #{temp} />"
      when 'styles' then output += "<link #{temp} />"
      when 'script' then output += "<script #{temp} />"
      end
    end
    output
  end
end
