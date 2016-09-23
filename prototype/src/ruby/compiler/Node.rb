# Node for syntax tree

class Node
  def initialize(type)
    @type = type
    @children = Set.new
  end

  def addChild(child)
    @children.push(child)
  end
end
