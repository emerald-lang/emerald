require 'treetop'
require_relative 'Node'

# elements[2] is the attributes
# call to_html() on them.
class AttributeList < Node
  def to_html
    #log("ATTR_LIST")
    elements[2].to_html()
  end
end
