require 'treetop'
require_relative 'Node'

class TagStatement < Node
  def to_html
    puts "TAG STATEMENT"
    elements[0].to_html()
  end
  def end_html
    elements[0].end_html()
  end
end
