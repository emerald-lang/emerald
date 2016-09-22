require_relative 'Analyzer'
require_relative 'Tokenizer'

class Main
  input = File.read('src/samples/emerald/' + ARGV[0].to_s)
  tokens = Tokenizer.instance.tokenize(input)
  Analyzer.instance.make_tree(tokens)

  output = ''
  tokens.each do |token|
    output += token.value
  end

  puts output
end
