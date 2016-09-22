# Tokenizer.rb
# Singleton tokenizer class

require_relative 'Token'
require 'singleton'

class Tokenizer
  include Singleton

  def tokenize(input, tokens = [])
    #puts "INPUT:\n#{input}\n"
    return tokens unless !input.empty?
    if input.match(/\A(html|head|body|doctype|title|metas|scripts|styles)\b/)
      reg = input.match(/\A(html|head|body|doctype|title|metas|scripts|styles)\b/).to_s

      tokenize(
        input[reg.length..-1],
        tokens.push(
          Token.new(reg, 'KEYWORD')
        )
      )
    elsif input.match(/\A(a|abbr|address|area|article|aside|audio|b|base|bdi|bdo|blockquote|body|br|button|canvas|caption|cite|code|col|colgroup|datalist|dd|del|details|dfn|dialog|div|dl|em|embed|fieldset|figcaption|figure|footer|form|head|header|hr|html|i|iframe|img|input|ins|kbd|keygen|label|legend|li|link|main|map|mark|menu|menuitem|meta|meter|nav|noscript|object|ol|optgroup|option|output|p|param|pre|progress|q|rp|rt|ruby|s|samp|script|section|select|small|source|span|strong|style|sub|summary|sup|table|tbody|td|textarea|tfoot|th|thead|time|title|tr|track|u|ul|var|video|wbr)\b/)
      reg = input.match(/\A(a|abbr|address|area|article|aside|audio|b|base|bdi|bdo|blockquote|body|br|button|canvas|caption|cite|code|col|colgroup|datalist|dd|del|details|dfn|dialog|div|dl|em|embed|fieldset|figcaption|figure|footer|form|head|header|hr|html|i|iframe|img|input|ins|kbd|keygen|label|legend|li|link|main|map|mark|menu|menuitem|meta|meter|nav|noscript|object|ol|optgroup|option|output|p|param|pre|progress|q|rp|rt|ruby|s|samp|script|section|select|small|source|span|strong|style|sub|summary|sup|table|tbody|td|textarea|tfoot|th|thead|time|title|tr|track|u|ul|var|video|wbr)\b/).to_s

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
    elsif input.match(/\A(\(|\)|"|'|\>|\<|\@|=|!|\?|#|,|\.|\+|-|\$|\/)/)
      reg = input.match(/\A(\(|\)|"|'|\>|\<|\@|=|!|\?|#|,|\.|\+|-|\$|\/)/).to_s

      tokenize(
        input[reg.length..-1],
        tokens.push(Token.new(reg, 'SYMBOL'))
      )
    elsif input.match(/\A(href|rel)\b/)
      reg = input.match(/\A(href|rel)\b/).to_s

      tokenize(
        input[reg.length..-1],
        tokens.push(Token.new(reg, 'ATTR'))
      )
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
