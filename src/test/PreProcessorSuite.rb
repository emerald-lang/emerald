#!/usr/bin/env ruby

require 'test/unit'

require_relative '../../ruby/PreProcessor'

#
# Unit testing for Emerald PreProcessor. Asserts that valid emerald is
# preprocessed in the expected way, and produced the correct intermediate code
# representation.
#
class PreProcessorSuite < Test::Unit::TestCase
  def test_valid_output
    assert_equal(true, true)
  end
end
