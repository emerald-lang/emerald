require_relative '../../ruby/compiler/Tokenizer'
require "test/unit"

class TestSuite < Test::Unit::TestCase
  def test_equality
    assert_equal(1, 1)
  end

  def test_simple
    input = File.open("src/samples/emerald/valid/html.emr").read
    tokens = Tokenizer.instance.tokenize(input)

    output = ''
    for i in tokens
      output += i.value
    end

    assert_equal(input, output)
  end
end
