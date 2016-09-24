# Creates syntax tree
# from token stream

require 'singleton'
require_relative 'Node'

class Analyzer
  include Singleton

  def make_tree(tokens, nodes, level = 0, parent = nil, flag = false)
    i = Node.new(tokens.shift, parent)

    return unless !i.nil?
    if i.type == "NEWLINE"
      make_tree(
        tokens,
        nodes.push(i),
        level,
        parent,
        true
      )
    elsif i.type == "SPACE" and flag
      puts "NEW LINE: #{level}"

      if i.value.length < level
        puts "no more children"
      end

      make_tree(
        tokens,
        nodes.push(i),
        i.value.length,
        parent
      )
    else
      puts "LEVEL: #{level}"
      make_tree(
        tokens,
        nodes.push(i),
        level,
        parent
      )
    end
  end
end
