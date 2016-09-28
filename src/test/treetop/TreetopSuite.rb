require "test/unit"
require 'polyglot'
require 'treetop'

Treetop.load "../../ruby/treetop/grammar/tokens"
Treetop.load "../../ruby/treetop/grammar/emerald"

class TreetopSuite < Test::Unit::TestCase

  def test_samples
    parser = EmeraldParser.new
    path = "samples/emerald/valid/test/"

    Dir.foreach(path) do |file|
      next if file == ".." or file == "."

      f = File.open(path + file).read
      puts f

      assert_not_equal(parser.parse(f), nil)
    end
  end

end
