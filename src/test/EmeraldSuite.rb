#!/usr/bin/env ruby
# frozen_string_literal: true

require 'test/unit'

require_relative '../ruby/Main.rb'

TEMPLATE_TESTS = [
  {
    context: {},
    in: <<~EMR,
      h1 Hello, world
    EMR
    out: <<~HTML,
      <h1>Hello, world</h1>
    HTML
  },
  {
    context: {name: 'Dave'},
    in: <<~EMR,
      h1 Hello, |name|
    EMR
    out: <<~HTML,
      <h1>Hello, Dave</h1>
    HTML
  },
  {
    context: {person: {name: 'Dave'}},
    in: <<~EMR,
      h1 Hello, |person.name|
    EMR
    out: <<~HTML,
      <h1>Hello, Dave</h1>
    HTML
  }
].freeze

#
# Unit testing for Emerald Language. Asserts that emerald passed in is
# compiled to valid html, which is equivalent in semantic value.
#
class EmeraldSuite < Test::Unit::TestCase
  def whitespace_agnostic(str)
    str.gsub(/\s+/, ' ').strip
  end

  def test_templating
    TEMPLATE_TESTS.each do |test|
      output = whitespace_agnostic test[:out]
      expected = whitespace_agnostic Emerald.convert(test[:in], test[:context])

      assert_equal(output, expected)
    end
  end
end
