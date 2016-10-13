require 'treetop'
require_relative 'Node'

class Line < Node
  def to_html
    log("LINE")
    e = elements[0]
    
    if e.is_a?(TagStatement)
      puts "<#{e.elements[0].text_value}><#{e.elements[0].text_value}>"
    end
  end
end
