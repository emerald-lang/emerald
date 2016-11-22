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

SCOPE_TESTS = [
  {
    context: {test: true},
    in: <<~EMR,
      given test
        h1 True
      unless test
        h1 False
    EMR
    out: '<h1>True</h1>'
  },
  {
    context: {test: false},
    in: <<~EMR,
      given test
        h1 True
      unless test
        h1 False
    EMR
    out: '<h1>False</h1>'
  },
  {
    context: {},
    in: <<~EMR,
      given test
        h1 True
      unless test
        h1 False
    EMR
    out: '<h1>False</h1>'
  },
  {
    context: {a: true, b: false},
    in: <<~EMR,
      given a or b
        h1 True
    EMR
    out: '<h1>True</h1>'
  },
  {
    context: {a: false, b: false},
    in: <<~EMR,
      given a or b
        h1 True
    EMR
    out: ''
  },
  {
    context: {a: true, b: true},
    in: <<~EMR,
      given a and b
        h1 True
    EMR
    out: '<h1>True</h1>'
  },
  {
    context: {a: true, b: false},
    in: <<~EMR,
      given a and b
        h1 True
    EMR
    out: ''
  },
  {
    context: {a: false},
    in: <<~EMR,
      given not a
        h1 True
    EMR
    out: '<h1>True</h1>'
  },
  {
    context: {a: true},
    in: <<~EMR,
      given not a
        h1 True
    EMR
    out: ''
  },
  {
    context: {a: true, b: true, c: true},
    in: <<~EMR,
      given a and b and c
        h1 True
    EMR
    out: '<h1>True</h1>'
  },
  {
    context: {a: false, b: true, c: true},
    in: <<~EMR,
      given a or (b and c)
        h1 True
    EMR
    out: '<h1>True</h1>'
  },
  {
    context: {a: false, b: true, c: true},
    in: <<~EMR,
      given a or (b and c)
        h1 True
    EMR
    out: '<h1>True</h1>'
  },
  {
    context: {a: [1, 2, 3]},
    in: <<~EMR,
      each a as element
        h1 |element|
    EMR
    out: '<h1>1</h1> <h1>2</h1> <h1>3</h1>'
  },
  {
    context: {a: ['a', 'b', 'c']},
    in: <<~EMR,
      each a as element, i
        h1 |i|
    EMR
    out: '<h1>0</h1> <h1>1</h1> <h1>2</h1>'
  },
  {
    context: {a: {b: 'c'}},
    in: <<~EMR,
      each a as v, k
        h1 |v| |k|
    EMR
    out: '<h1>b c</h1>'
  },
  {
    context: {a: {b: 'c'}},
    in: <<~EMR,
      with a
        h1 |b|
    EMR
    out: '<h1>c</h1>'
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

  def test_all
    [
      TEMPLATE_TESTS,
      SCOPE_TESTS
    ].flatten.each do |test|
      output = whitespace_agnostic test[:out]
      expected = whitespace_agnostic Emerald.convert(test[:in], test[:context])

      assert_equal(output, expected)
    end
  end
end
