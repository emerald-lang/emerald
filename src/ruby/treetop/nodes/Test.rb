require 'treetop'

class Test < Node
  def to_html
    elements.each do |e|
      e.to_html()
    end
  end

  def end_html
    puts "default end_html"
  end

  # Printing method
  def log(type)
    puts "Type: #{type}"
  end
end
