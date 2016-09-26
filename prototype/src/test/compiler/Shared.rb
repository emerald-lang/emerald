
require_relative '../../ruby/compiler/Tokenizer'
require 'singleton'

class Shared
  include Singleton

  def get_tokens(file)
    input = File.open(file).read
    Tokenizer.instance.tokenize(input)
  end
end
