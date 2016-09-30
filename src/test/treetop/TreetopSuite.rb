require "test/unit"
require 'polyglot'
require 'treetop'

Treetop.load "../../ruby/treetop/grammar/tokens"
Treetop.load "../../ruby/treetop/grammar/emerald"

class TreetopSuite < Test::Unit::TestCase

  @@parser = EmeraldParser.new

  def walk(path)
    Dir.foreach(path) do |file|
      new_path = File.join(path, file)

      if file == ".." or file == "."
        next
      elsif File.directory?(new_path)
        walk(new_path)
      else
        f = File.open(path + "/" + file)
        assert_not_equal(@@parser.parse(f.read), nil)
      end
    end
  end

  def test_samples
    path = "samples/emerald/tests/valid/"
    walk(path)

    invalid = "samples/emerald/tests/invalid/"

    Dir.foreach(invalid) do |file|
      next if file == ".." or file == "."
      f = File.open(invalid + file).read
      assert_equal(@@parser.parse(f), nil)
    end
  end

end
