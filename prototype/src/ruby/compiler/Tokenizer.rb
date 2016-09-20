# Tokenizer.rb
# Singleton tokenizer class

require_relative 'Token'

class Tokenizer
  def self.tokenize(input, tokens = [])
    puts "INPUT:\n#{input}\n"
    return tokens unless !input.empty?
    if input.match(/\Ahtml\b/)
      tokenize(input[4..-1], tokens.push(Token.new('html', 'KEYWORD')))
    elsif input.match(/\Ahead\b/)
      tokenize(input[4..-1], tokens.push(Token.new('head', 'KEYWORD')))
    elsif input.match(/\Abody\b/)
      tokenize(input[4..-1], tokens.push(Token.new('body', 'KEYWORD')))
    elsif input.match(/\Adoc\b/)
      tokenize(input[3..-1], tokens.push(Token.new('doc', 'KEYWORD')))
    elsif input.match(/\Ahref\b/)
      tokenize(input[4..-1], tokens.push(Token.new('href', 'KEYWORD')))
    elsif input.match(/\Ascript\b/)
      tokenize(input[6..-1], tokens.push(Token.new('script', 'KEYWORD')))
    elsif input.match(/\Adiv\b/)
      tokenize(input[6..-1], tokens.push(Token.new('div', 'TAG')))
    elsif input.match(/\Ah1\b/)
      tokenize(input[2..-1], tokens.push(Token.new('h1', 'HEADER')))
    elsif input.match(/\Ah2\b/)
      tokenize(input[2..-1], tokens.push(Token.new('h2', 'HEADER')))
    elsif input.match(/\Ah3\b/)
      tokenize(input[2..-1], tokens.push(Token.new('h3', 'HEADER')))
    elsif input.match(/\Ah4\b/)
      tokenize(input[2..-1], tokens.push(Token.new('h4', 'HEADER')))
    elsif input.match(/\Ah5\b/)
      tokenize(input[2..-1], tokens.push(Token.new('h5', 'HEADER')))
    elsif input.match(/\Ah6\b/)
      tokenize(input[2..-1], tokens.push(Token.new('h6', 'HEADER')))
    elsif input.match(/\A=/)
      tokenize(input[1..-1], tokens.push(Token.new('=', 'EQUALS')))
    elsif input.match(/\A,/)
      tokenize(input[1..-1], tokens.push(Token.new(',', 'COMMA')))
    elsif input.match(/\A\./)
      tokenize(input[1..-1], tokens.push(Token.new('.', 'PERIOD')))
    elsif input.match(/\A\+/)
      tokenize(input[1..-1], tokens.push(Token.new('+', 'SYMBOL')))
    elsif input.match(/\A-/)
      tokenize(input[1..-1], tokens.push(Token.new('-', 'SYMBOL')))
    elsif input.match(/\A\//)
      tokenize(input[1..-1], tokens.push(Token.new('/', 'SYMBOL')))
    elsif input.match(/\Ahref\b|\Ahref=/)
      tokenize(input[4..-1], tokens.push(Token.new('href', 'ATTR')))
    elsif input.match(/\Arel\b|\Arel=/)
      tokenize(input[3..-1], tokens.push(Token.new('rel', 'ATTR')))
    elsif input.match(/\A(click|hover)\b/)
      tokenize(input[5..-1], tokens.push(Token.new('[event_name]', 'EVENT')))
    elsif input.start_with? "'"
      i = input[1..-1].index("'")
      if i.nil?
        puts "String error on line: #.\nNo closing quotation."
      else
        tokenize(input[(i + 2)..-1], tokens.push(Token.new(input[0..i + 1], 'STRING')))
      end
    elsif input.start_with? "\n"
      tokenize(input[1..-1], tokens.push(Token.new("\n", 'NEWLINE')))
    elsif input.match(/\A(\w+)\b/)
      var = input.match(/\A(\w+)\b/).to_s
      len = var.length
      tokenize(input[len..-1], tokens.push(Token.new(var, 'VAR')))
    elsif input.start_with? ' '
      spaces = input.lstrip!
      len = input.length - spaces.length

      # Inefficient, change for prod version.
      spaces = ''
      for i in 0..len
        spaces += ' '
      end

      tokenize(input[len..-1], tokens.push(Token.new(spaces, 'SPACE')))
    else
      puts "ERROR: #{input}"
      tokenize(input[1..-1], tokens)
    end
  end

  input = File.read('src/samples/emerald/' + ARGV[0])
  tokens = tokenize(input)

  output = ''
  for i in tokens
    output += i.value
  end

  puts output
end
