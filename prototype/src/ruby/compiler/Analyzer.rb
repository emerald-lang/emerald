# Creates syntax tree
# from token stream

require 'singleton'
require_relative 'Node'
require_relative 'Token'

class Analyzer
  include Singleton

  def initialize
    @root = Node.new(Token.new(nil, "ROOT"), nil)
  end

  def make_tree(tokens, nodes = [], level = 0, parent = nil, flag = false)
    parent ||= @root

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
        make_tree(
          tokens,
          nodes.push(i),
          i.value.length,
          parent
        )
      else
        make_tree(
          tokens,
          nodes.push(i),
          i.value.length,
          parent
        )
      end
    else
      puts "LEVEL: #{level}"
      make_tree(
        tokens,
        nodes.push(i),
        level,
        parent.addChild(i)
      )
    end
  end
end
