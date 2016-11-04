#!/usr/bin/env ruby

require 'test/unit'

require_relative '../ruby/PreProcessor'

#
# Unit testing for Emerald PreProcessor. Asserts that valid emerald is
# preprocessed in the expected way, and produced the correct intermediate code
# representation.
#
class PreProcessorSuite < Test::Unit::TestCase
  include PreProcessor

  # Recursively walk directory and get all test case files for the test suite.
  # Performs preprocessing operation on each file and stores the results in a
  # list.
  def walk(path, list = [])
    Dir.foreach(path) do |file|
      new_path = File.join(path, file)

      next if file == '..' || file == '.'

      if File.directory?(new_path)
        walk(new_path, list)
      else
        f = File.open(path + '/' + file)
        list.push([PreProcessor.process_emerald(), path + '/' + file])
      end
    end

    list
  end

  # We only test the valid samlpes, because the invalid emerald samples will
  # also be preprocessed regardless of their semantics. Error checking happens
  # in the parsing and code generation phase.
  def test_valid_output
    output = walk('samples/emerald/tests/valid')
  end
end
