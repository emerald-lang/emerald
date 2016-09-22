# Tokenizer.rb
# Singleton tokenizer class

require_relative 'Token'
require 'singleton'

class Tokenizer
  include Singleton

  def tokenize(input, tokens = [])
    #puts "INPUT:\n#{input}\n"
    return tokens unless !input.empty?
    if input.match(/\A(html|head|body|doc|href|title|metas|scripts|styles)\b/)
      reg = input.match(/\A(html|head|body|doc|href|title|metas|scripts|styles)\b/).to_s

      tokenize(
        input[reg.length..-1],
        tokens.push(
          Token.new(reg, 'KEYWORD')
        )
      )
    elsif input.match(/\A(div|section|article|figure|figcaption)\b/)
      reg = input.match(/\A(div|section|article|figure|figcaption)\b/).to_s

      tokenize(
        input[reg.length..-1],
        tokens.push(Token.new(reg, 'TAG'))
      )
    elsif input.match(/\Ah[1-6]\b/)
      reg = input.match(/\Ah[1-6]\b/).to_s

      tokenize(
        input[reg.length..-1],
        tokens.push(Token.new(reg, 'HEADER'))
      )
    elsif input.match(/\A\(/)
      tokenize(input[1..-1], tokens.push(Token.new('(', 'LPAREN')))
    elsif input.match(/\A\)/)
      tokenize(input[1..-1], tokens.push(Token.new(')', 'RPAREN')))
    elsif input.match(/\A"/)
      tokenize(input[1..-1], tokens.push(Token.new('"', 'QUOTE')))
    elsif input.match(/\A'/)
      tokenize(input[1..-1], tokens.push(Token.new('\'', 'QUOTE')))
    elsif input.match(/\A\>/)
      tokenize(input[1..-1], tokens.push(Token.new('>', 'GREATER')))
    elsif input.match(/\A\</)
      tokenize(input[1..-1], tokens.push(Token.new('<', 'LESS')))
    elsif input.match(/\A\@/)
      tokenize(input[1..-1], tokens.push(Token.new('@', 'AT')))
    elsif input.match(/\A=/)
      tokenize(input[1..-1], tokens.push(Token.new('=', 'EQUALS')))
    elsif input.match(/\A\!/)
      tokenize(input[1..-1], tokens.push(Token.new('!', 'SYMBOL')))
    elsif input.match(/\A\?/)
      tokenize(input[1..-1], tokens.push(Token.new('?', 'QUESTION')))
    elsif input.match(/\A#/)
      tokenize(input[1..-1], tokens.push(Token.new('#', 'HASH')))
    elsif input.match(/\A,/)
      tokenize(input[1..-1], tokens.push(Token.new(',', 'COMMA')))
    elsif input.match(/\A\./)
      tokenize(input[1..-1], tokens.push(Token.new('.', 'PERIOD')))
    elsif input.match(/\A\+/)
      tokenize(input[1..-1], tokens.push(Token.new('+', 'SYMBOL')))
    elsif input.match(/\A-/)
      tokenize(input[1..-1], tokens.push(Token.new('-', 'SYMBOL')))
    elsif input.match(/\A\$/)
      tokenize(input[1..-1], tokens.push(Token.new('$', 'SYMBOL')))
    elsif input.match(/\A\//)
      tokenize(input[1..-1], tokens.push(Token.new('/', 'SYMBOL')))
    elsif input.match(/\Ahref\b|\Ahref=/)
      tokenize(input[4..-1], tokens.push(Token.new('href', 'ATTR')))
    elsif input.match(/\Arel\b|\Arel=/)
      tokenize(input[3..-1], tokens.push(Token.new('rel', 'ATTR')))
    elsif input.match(/\A(click|hover)\b/)
      reg = input.match(/\A(click|hover)\b/).to_s

      tokenize(
        input[reg.length..-1],
        tokens.push(Token.new(reg, 'EVENT'))
      )
    elsif input.start_with? "\n"
      tokenize(input[1..-1], tokens.push(Token.new("\n", 'NEWLINE')))
    elsif input.match(/\A(\w+)\b/)
      reg = input.match(/\A(\w+)\b/).to_s
      tokenize(input[reg.length..-1], tokens.push(Token.new(reg, 'VAR')))
    elsif input.start_with? ' '
      tokenize(input[1..-1], tokens.push(Token.new(' ', 'SPACE')))
    else
      puts "ERROR: #{input}"
      tokenize(input[1..-1], tokens)
    end
  end
end
