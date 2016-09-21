require_relative 'Tokenizer'

class Main
  input = File.read('src/samples/emerald/' + ARGV[0].to_s)
  tokens = tokenize(input)

  output = ''
  tokens.each do |token|
    output += token.value
  end

  puts output
end
