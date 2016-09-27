require_relative 'Shared'
require "test/unit"

class TokenizerSuite < Test::Unit::TestCase

  def test_simple
    test_file_output("../samples/emerald/valid/html.emr")
  end

  def test_attr
    test_file_output("../samples/emerald/valid/attr.emr")
  end

  def test_sample
    test_file_output("sample.emr")
  end

  def test_tokens(file)
    tokens = Shared.instance.get_tokens(file)
    expected = File.open("expected/" + file)

    asset_equal(tokens, expected)
  end

  def test_file_output(file)
    tokens = Shared.instance.get_tokens(file)

    output = ''
    tokens.each do |i|
      output += i.value
    end

    assert_equal(input, output)
  end

  def test_directory_output(path)
    Dir.foreach("../samples/emerald/valid") do |file|
      next if file == ".." or file == "." # skips these files
      test_file_output(file)
    end
  end
end
