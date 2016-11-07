#!/usr/bin/env ruby

require 'test/unit'
require 'polyglot'
require 'treetop'

# Require all treetop nodes for grammar
Dir[File.dirname(__FILE__) + '/../ruby/nodes/*.rb'].each { |f| require f }

Treetop.load '../ruby/grammar/tokens'
Treetop.load '../ruby/grammar/emerald'

#
# Unit testing for Treetop parser. Asserts that valid preprocessed emerald is
# accepted and invalid preprocessed emerald is rejected.
#
class TreetopSuite < Test::Unit::TestCase
  def walk(path, list = [])
    parser = EmeraldParser.new

    Dir.foreach(path) do |file|
      new_path = File.join(path, file)

      next if file == '..' || file == '.'
      list = get_new_list(list, path, file, new_path, parser)
    end

    list
  end

  def get_new_list(list, path, file, new_path, parser)
    if File.directory?(new_path)
      walk(new_path, list)
    else
      f = File.open(path + '/' + file)
      list.push([parser.parse(f.read), path + '/' + file])
    end

    list
  end

  def test_valid_samples
    output = walk('samples/emerald/tests/valid/')

    output.each do |out|
      puts out[1] if out[0].nil?
      assert_not_equal(out[0], nil)
    end
  end

  def test_invalid_samples
    output = walk('samples/emerald/tests/invalid/')

    output.each do |out|
      assert_equal(out[0], nil)
    end
  end
end
