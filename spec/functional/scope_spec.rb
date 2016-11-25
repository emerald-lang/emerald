#!/usr/bin/env ruby
# frozen_string_literal: true

require 'spec_helper'

#
# Unit testing for Emerald Language. Asserts that emerald passed in is
# compiled to valid html, which is equivalent in semantic value.
#
describe Emerald do
  context 'given/unless' do
    it 'can determine truthiness' do
      expect(convert(
        context: {test: true},
        input: <<~EMR,
          given test
            h1 True
          unless test
            h1 False
        EMR
      )).to eq('<h1>True</h1>')
    end

    it 'can determine falsiness' do
      expect(convert(
        context: {test: false},
        input: <<~EMR,
          given test
            h1 True
          unless test
            h1 False
        EMR
      )).to eq('<h1>False</h1>')
    end

    it 'can check if a variable is present' do
      expect(convert(
        context: {},
        input: <<~EMR,
          given test
            h1 True
          unless test
            h1 False
        EMR
      )).to eq('<h1>False</h1>')
    end
  end

  context 'boolean expressions' do
    it 'can do OR checks' do
      expect(convert(
        context: {a: true, b: false},
        input: <<~EMR,
          given a or b
            h1 True
        EMR
      )).to eq('<h1>True</h1>')

      expect(convert(
        context: {a: false, b: false},
        input: <<~EMR,
          given a or b
            h1 True
        EMR
      )).to eq('')
    end

    it 'can do AND checks' do
      expect(convert(
        context: {a: true, b: true},
        input: <<~EMR,
          given a and b
            h1 True
        EMR
      )).to eq('<h1>True</h1>')

      expect(convert(
        context: {a: true, b: false},
        input: <<~EMR,
          given a and b
            h1 True
        EMR
      )).to eq('')
    end

    it 'can do negation' do
      expect(convert(
        context: {a: false},
        input: <<~EMR,
          given not a
            h1 True
        EMR
      )).to eq('<h1>True</h1>')

      expect(convert(
        context: {a: true},
        input: <<~EMR,
          given not a
            h1 True
        EMR
      )).to eq('')
    end

    it 'can combine expressions' do
      expect(convert(
        context: {a: true, b: true, c: true},
        input: <<~EMR,
          given a and b and c
            h1 True
        EMR
      )).to eq('<h1>True</h1>')

      expect(convert(
        context: {a: false, b: true, c: true},
        input: <<~EMR,
          given a or (b and c)
            h1 True
        EMR
      )).to eq('<h1>True</h1>')

      expect(convert(
        context: {a: false, b: true, c: true},
        input: <<~EMR,
          given a or (b and c)
            h1 True
        EMR
      )).to eq('<h1>True</h1>')
    end
  end

  context 'loops' do
    it 'can loop over arrays' do
      expect(convert(
        context: {a: [1, 2, 3]},
        input: <<~EMR,
          each a as element
            h1 |element|
        EMR
      )).to eq('<h1>1</h1> <h1>2</h1> <h1>3</h1>')
    end

    it 'can loop over arrays with indices' do
      expect(convert(
        context: {a: ['a', 'b', 'c']},
        input: <<~EMR,
          each a as element, i
            h1 |i|
        EMR
      )).to eq('<h1>0</h1> <h1>1</h1> <h1>2</h1>')
    end

    it 'can loop over hashes' do
      expect(convert(
        context: {a: {b: 'c'}},
        input: <<~EMR,
          each a as v, k
            h1 |v| |k|
        EMR
      )).to eq('<h1>b c</h1>')
    end
  end

  context 'with' do
    it 'can push scope' do
      expect(convert(
        context: {a: {b: 'c'}},
        input: <<~EMR,
          with a
            h1 |b|
        EMR
      )).to eq('<h1>c</h1>')
    end
  end
end
