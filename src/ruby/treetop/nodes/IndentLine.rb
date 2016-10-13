require 'treetop'
require_relative 'Node'

# Call to_html on elements[1]. This is becaues elements[0] is an 'Indent' rule,
# which does not get converted via a to_html method, but is important for
# semantic validation in the grammar. elements[1] is the 'Line' rule, which is
# converted to html in the code generation phase.
class IndentLine < Node
  def to_html
    log("INDENT LINE")
    elements[1].to_html()
  end
end
