require 'treetop'
require_relative 'Node'

class AttributeList < Node
  def to_html
    log("ATTR_LIST")
  end
end
