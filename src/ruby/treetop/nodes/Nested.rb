require 'treetop'
require_relative 'Node'

class Nested < Node
  def to_html(elem=nil)
    puts "NESTED"
    elem = elements if elem.nil?
    puts elem.length

    elem.each do |e|
      if e.is_a?(TagStatement)
        e.to_html() # name open_tag or something
        to_html(elem[1..-1])
        e.end_html() # name close_tag or something
      elsif e.is_a?(IndentLine)
        puts "value #{e.elements[1].text_value}"
        # e.elements[1].to_html()
        # to_html(elem[1..-1])
        # e.elements[1].end_html()
      elsif e.is_a?(Node)
        e.to_html()
      elsif !e.is_a?(TagStatement)
        to_html(e.elements)
      end
    end
  end
end
