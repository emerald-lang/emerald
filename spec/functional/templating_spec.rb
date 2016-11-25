#!/usr/bin/env ruby
# frozen_string_literal: true

require 'spec_helper'

describe Emerald do
  it 'works with no templating' do
    expect(convert(
      context: {},
      input: <<~EMR,
        h1 Hello, world
      EMR
    )).to eq('<h1>Hello, world</h1>')
  end

  it 'works with simple templating' do
    expect(convert(
      context: {name: 'Dave'},
      input: <<~EMR,
        h1 Hello, |name|
      EMR
    )).to eq('<h1>Hello, Dave</h1>')
  end

  it 'works with nested templating' do
    expect(convert(
      context: {person: {name: 'Dave'}},
      input: <<~EMR,
        h1 Hello, |person.name|
      EMR
    )).to eq('<h1>Hello, Dave</h1>')
  end

  it 'works in multiline literals' do
    expect(convert(
      context: {name: 'Dave'},
      input: <<~EMR,
        h1 ->
          Hello, world,
          my name is |name|
      EMR
    )).to eq(whitespace_agnostic(<<~HTML))
      <h1>Hello, world,
      my name is Dave</h1>
    HTML
  end

  it 'does not template in multiline templateless literals' do
    expect(convert(
      context: {name: 'Dave'},
      input: <<~EMR,
        h1 =>
          Hello, world,
          my name is |name|
      EMR
    )).to eq(whitespace_agnostic(<<~HTML))
      <h1>Hello, world,
      my name is |name|</h1>
    HTML
  end

  context 'escaping' do
    it 'handles escaped pipes' do
      expect(convert(
        context: {name: 'Dave'},
        input: <<~EMR,
          h1 Hello, \\||name|
        EMR
      )).to eq('<h1>Hello, |Dave</h1>')
    end

    it 'handles escaped escaped pipes' do
      expect(convert(
        context: {name: 'Dave'},
        input: <<~EMR,
          h1 Hello, \\\\|name|
        EMR
      )).to eq('<h1>Hello, \Dave</h1>')
    end

    it 'handles braces in multiline literals' do
      expect(convert(
        context: {},
        input: <<~EMR,
          h1 =>
            hey look a brace
            }
        EMR
      )).to eq('<h1>hey look a brace }</h1>')
    end

    it 'handles braces in inline literals' do
      expect(convert(
        context: {},
        input: <<~EMR,
          h1 hey look a brace }
        EMR
      )).to eq('<h1>hey look a brace }</h1>')
    end
  end
end
