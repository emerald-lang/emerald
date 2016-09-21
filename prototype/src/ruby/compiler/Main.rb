require_relative 'Tokenizer'

class Main
  input = File.read('src/samples/emerald/' + ARGV[0].to_s)
  tokens = tokenize(input)

  output = ''
  for i in tokens
    output += i.value
  end

  puts output
end
