require_relative '../../ruby/compiler/Tokenizer'
require "test/unit"

class TokenizerSuite < Test::Unit::TestCase
  def test_simple
    test_file("src/samples/emerald/valid/html.emr")
  end

  def test_attr
    test_file("src/samples/emerald/valid/attr.emr")
  end

  def test_sample
    test_file("sample.emr")
  end

  def test_file(file)
    input = File.open(file).read
    tokens = Tokenizer.instance.tokenize(input)

    output = ''
    for i in tokens
      output += i.value
    end

    assert_equal(input, output)
  end

  def test_directory(path)
  end
end
