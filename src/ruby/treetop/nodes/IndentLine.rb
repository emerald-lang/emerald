require 'treetop'
require_relative 'Node'

class IndentLine < Node
  def to_html
    puts "INDENT LINE"
    elements[1].to_html()
  end
end
