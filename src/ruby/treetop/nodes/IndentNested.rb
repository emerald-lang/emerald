require 'treetop'
require_relative 'Node'

class IndentNested < Node
  def to_html
    log("INDENT NESTED")
    puts "---"
    puts elements[1].text_value
    puts "---"
  end
end
