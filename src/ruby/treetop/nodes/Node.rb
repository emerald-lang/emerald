require 'treetop'

class Node < Treetop::Runtime::SyntaxNode
  def to_html
    puts "default to_html"
  end

  def to_html_non_terminal(type)
    # Converts non-terminal nodes to html, calls to_html on its children
  end

  def to_html_terminal(type)
    # Converts terminal nodes to html
    case type
    when "COMMENT"
      "<!--#{val}-->"
    when "H_NUM"
      "<h#{num}>#{val}</h#{num}>"
    end
  end
end
