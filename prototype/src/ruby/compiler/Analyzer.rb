# Creates syntax tree
# from token stream

require 'singleton'

class Analyzer
  include Singleton

  def make_tree(tokens, level = 0, flag = false)
    i = tokens.shift
    return unless !i.nil?
    if i.type == "NEWLINE"
      make_tree(tokens, 0, true)
    elsif i.type == "SPACE" and flag
      puts i.value.length
    end
    make_tree(tokens, 0)
  end
end
