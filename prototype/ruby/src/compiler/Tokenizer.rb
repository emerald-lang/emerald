# Tokenizer.rb
# Singleton tokenizer class

require_relative 'Token'

class Tokenizer
  def self.init(argv)
    puts argv[0]
    input = File.read('src/samples/emerald/' + argv[0])
    tokenize(input)
  end

  def self.tokenize(input, tokens = [])
    puts "INPUT: #{input}"
    return unless input.empty?
    if input.match(/\Ahtml\b/)
      tokenize(input[4..-1], tokens.push(Token.new('html', 'KEYWORD')))
    elsif input.match(/\Ahead\b/)
      tokenize(input[4..-1], tokens.push(Token.new('head', 'KEYWORD')))
    elsif input.match(/\Abody\b/)
      tokenize(input[4..-1], tokens.push(Token.new('body', 'KEYWORD')))
    elsif input.match(/\Adoc\b/)
      tokenize(input[3..-1], tokens.push(Token.new('doc', 'KEYWORD')))
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
    elsif input.match(/\A=\b/)
      tokenize(input[1..-1], tokens.push(Token.new('=', 'SYMBOL')))
    elsif input.start_with? "'"
      i = input[1..-1].index("'")
      if i.nil?
        puts 'String error on line: #.'
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
      tokenize(input[1..-1], tokens.push(Token.new(' ', 'garb')))
    else
      puts "ERROR: #{input}"
      tokenize(input[1..-1], tokens)
    end
  end

  init(ARGV)
end
