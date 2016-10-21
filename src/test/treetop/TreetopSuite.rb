require 'test/unit'
require 'polyglot'
require 'treetop'

Dir[File.dirname(__FILE__) + '/../../ruby/treetop/nodes/*.rb'].each {|f| require f}

Treetop.load '../../ruby/treetop/grammar/tokens'
Treetop.load '../../ruby/treetop/grammar/emerald_spacing'

#
# Unit testing for Treetop parser. Asserts that valid
# emerald is accepted and invalid emerald is rejected.
#
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
        list.push([@@parser.parse(f.read), path + '/' + file])
      end
    end
    list
  end

  #def test_valid_samples
    #output = walk('samples/emerald/tests/valid/')

    #output.each do |out|
      #puts out[1] if out[0].nil?
      #assert_not_equal(out[0], nil)
    #end
  #end

  #def test_invalid_samples
    #output = walk('samples/emerald/tests/invalid/')

    #output.each do |out|
      #assert_equal(out[0], nil)
    #end
  #end

  def test_indents
    test = <<END
html
  head

  body
    section
  div
END
    tree = @@parser.parse(test)
    puts tree.inspect
    if tree
        puts "succesful"
    else
        puts "unsuccesful at #{@@parser.index}"
        puts @@parser.failure_reason
    end
  end
end
