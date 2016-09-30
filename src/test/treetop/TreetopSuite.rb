require 'test/unit'
require 'polyglot'
require 'treetop'

Treetop.load '../../ruby/treetop/grammar/tokens'
Treetop.load '../../ruby/treetop/grammar/emerald'

class TreetopSuite < Test::Unit::TestCase
  @@parser = EmeraldParser.new

  def walk(path, list = [])
    Dir.foreach(path) do |file|
      new_path = File.join(path, file)

      if file == '..' || file == '.'
        next
      elsif File.directory?(new_path)
        walk(new_path, list)
      else
        f = File.open(path + '/' + file)
        list.push(@@parser.parse(f.read))
      end
    end
    list
  end

  def test_invalid_samples
    output = walk('samples/emerald/tests/valid/')
    output.each do |out|
      assert_not_equal(out, nil)
    end
  end

  def test_valid_samples
    output = walk('samples/emerald/tests/invalid/')

    output.each do |out|
      assert_equal(out, nil)
    end
  end
end
