require 'treetop'
require_relative 'Node'

class Nested < Node
  @@isTrue = lambda {|e, i| e.elements.length * 2 < i ? true : false}

  def to_html(elem=nil, indent=nil)
    log("NESTED")
    indent = 0 if indent.nil?
    elem = elements if elem.nil?

    elem.each do |e|
      if e.is_a?(TagStatement)
        puts "#{e.to_html()}"
        x = to_html(elem[1..-1], indent)
        puts "</#{e.elements[0].text_value}>"

        puts x
        # to_html(elem[1..-1], indent) if br

        break
      elsif e.is_a?(TagStatement)
        puts "<#{e.elements[0].text_value}>"
        to_html(elem[1..-1], indent)
        puts "</#{e.elements[0].text_value}>"
      elsif e.is_a?(IndentNested)
        if @@isTrue.(e.elements[0], indent)
          indent = e.elements[0].elements.length * 2
          return true
          # call to_html on remaining stuff.
        else
          indent = e.elements[0].elements.length * 2
          e.elements[1].to_html(nil, indent)
        end
      elsif e.is_a?(IndentLine)
        if @@isTrue.(e.elements[0], indent)
          indent = e.elements[0].elements.length * 2
          return true
          # call to_html on remaining stuff.
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
