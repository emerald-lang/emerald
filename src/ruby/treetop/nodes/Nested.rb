require 'treetop'
require_relative 'Node'

class Nested < Node
  @@isTrue = lambda {|e, i| e.elements.length * 2 < i ? true : false}

  def to_html(elem=nil, indent=nil)
    #log("NESTED")
    indent = 0 if indent.nil?
    elem = elements if elem.nil?
    temp = false

    elem.map do |e|
      if e.is_a?(TagStatement)
        inner = 0

        puts "#{e.to_html()} [#{indent}]"
        x = to_html(elem[1..-1], indent)
        puts "</#{e.elements[0].text_value}> [#{indent}]"

        inner = x.flatten.compact.first if x.flatten.compact.any?
        p inner

        if inner == indent
          p elem
          to_html(elem[1..-1], indent)
        else
          break inner
        end
      elsif e.is_a?(IndentNested)
        if @@isTrue.(e.elements[0], indent)
          indent = e.elements[0].elements.length * 2
          return indent
        else
          indent = e.elements[0].elements.length * 2
          e.elements[1].to_html(nil, indent)
        end
      elsif e.is_a?(IndentLine)
        if @@isTrue.(e.elements[0], indent)
          indent = e.elements[0].elements.length * 2
          return indent
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
