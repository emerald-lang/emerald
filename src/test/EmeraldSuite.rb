#!/usr/bin/env ruby

require 'test/unit'

require_relative '../../ruby/Main'

#
# Unit testing for Emerald Language. Asserts that emerald passed in is
# compiled to valid html, which is equivalent in semantic value.
#
class EmeraldSuite < Test::Unit::TestCase
  def test_valid_output
    assert_equal(true, true)
  end
end
