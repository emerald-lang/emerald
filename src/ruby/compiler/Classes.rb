require 'singleton'
require_relative 'Token'

class Classes
  include Singleton

  def addClasses(tokens)
    output = ""
    tokens.each do |i|
      case i.type
      when 'KEYWORD'
        output += "<span class='keyword'>" + i.value + "</span>"
      when 'STRING'
        output += "<span class='string'>" + i.value + "</span>"
      when 'NEWLINE'
        output += "\n"
      when 'VAR'
        output += i.value
      else
        output += i.value
      end
    end
    output
  end
end
