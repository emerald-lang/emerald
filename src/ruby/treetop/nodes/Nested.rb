require 'treetop'
require_relative 'Node'

class Nested < Node
  @@isTrue = lambda {|e, i| e.elements.length * 2 < i ? true : false}

  def to_html(elem=nil, indent=nil)
    #log("NESTED")
    indent = 0 if indent.nil?
    elem = elements if elem.nil?

    elem.map do |e|
      if e.is_a?(TagStatement)
        inner = 0

        puts "#{e.to_html()}"
        x = to_html(elem[1..-1], indent)
        puts "</#{e.elements[0].text_value}>"

        if x.flatten.compact.any?
          inner = x.flatten.compact.first
          nodes = x.flatten.compact.grep(Node)
        end

        to_html(nodes, indent) unless nodes.nil? if inner == indent
        break inner, nodes
      elsif e.is_a?(IndentNested)
        if @@isTrue.(e.elements[0], indent)
          indent = e.elements[0].elements.length * 2
          return indent, elem
        else
          indent = e.elements[0].elements.length * 2
          e.elements[1].to_html(nil, indent)
        end
      elsif e.is_a?(IndentLine)
        if @@isTrue.(e.elements[0], indent)
          indent = e.elements[0].elements.length * 2
          return indent, elem
        else
          indent = e.elements[0].elements.length * 2
          e.to_html()
        end
      elsif e.is_a?(Node)
        e.to_html()
      elsif !e.is_a?(TagStatement)
        to_html(e.elements, indent)
      end
    end

  end
end
