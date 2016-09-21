#
# Token
# Object representation of token
#

class Token
  def initialize (value, type)
    #puts "Token created: #{value} :#{type}"
    @value = value
    @type = type
  end

  attr_reader :value, :type
end
