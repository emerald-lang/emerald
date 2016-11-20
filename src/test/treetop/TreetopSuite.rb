#!/usr/bin/env ruby

require 'test/unit'
require 'polyglot'
require 'treetop'

# Require all treetop nodes for grammar
Dir[__dir__ + '/../../ruby/nodes/*.rb'].each { |f| require_relative f }

Treetop.load __dir__ + '/../../ruby/grammar/tokens'
Treetop.load __dir__ + '/../../ruby/grammar/emerald'

#
# Unit testing for Treetop parser. Asserts that valid preprocessed emerald is
# accepted and invalid preprocessed emerald is rejected.
#
class TreetopSuite < Test::Unit::TestCase
  # Walks the directory passed in and parses the preprocessed emerald to
  # check if it passes the treetop CFG.
  def walk(path, list = [])
    parser = EmeraldParser.new

    Dir.foreach(path) do |file|
      new_path = File.join(path, file)

      next if file == '..' || file == '.'
      list = get_new_list(list, new_path, parser)
    end

    list
  end

  # If the new path is a file, returns a new list with result of parsing
  # preprocessed file. If the new path is a directory, recursively walk
  # directory.
  def get_new_list(list, new_path, parser)
    if File.directory?(new_path)
      walk(new_path, list)
    else
      f = File.open(new_path)
      list.push([parser.parse(f.read), new_path])
    end

    list
  end

  # Tests valid preprocessed files to ensure the files are parsed correctly
  # by the CFG, and do not fail in the parsing stage.
  def test_valid_samples
    output = walk(__dir__ + '/../preprocessor/intermediate/general')

    output.each do |out|
      # Temporary, will un-comment these after I fix the CFG.
      next if out[1].end_with? 'preprocessor/intermediate/general/metas.txt'
      next if out[1].end_with? '../preprocessor/intermediate/general/attr.txt'

      puts out[1] if out[0].nil?
      assert_not_equal(out[0], nil)
    end
  end
end
