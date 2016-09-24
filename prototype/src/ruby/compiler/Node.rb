# Node for syntax tree

require_relative 'Token'

class Node
  def initialize(token, parent)
    @type = token.type
    @value = token.value
    @children = Array.new
    @parent = parent
  end

  def addChild(child)
    @children.push(child)
  end

  attr_reader :type, :value
end
