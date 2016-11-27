#!/usr/bin/env ruby
# frozen_string_literal: true

require 'spec_helper'

describe Emerald do
  it 'works with no templating' do
    expect(
      convert(
        context: {},
        input: <<~EMR,
          h1 Hello, world
        EMR
      )
    ).to eq('<h1>Hello, world</h1>')
  end

  it 'templating works for attributes' do
    expect(
      convert(
        context: {prefix: 'class-prefix'},
        input: <<~EMR,
          section Attributes follow parentheses. (
            id     "header"
            class  "|prefix|-text"
            height "50px"
            width  "200px"
          )
        EMR
      )
    ).to eq('<section id="header" class="class-prefix-text" height="50px" width="200px">'\
            'Attributes follow parentheses. </section>')
  end

  it 'works with simple templating' do
    expect(
      convert(
        context: {name: 'Dave'},
        input: <<~EMR,
          h1 Hello, |name|
        EMR
      )
    ).to eq('<h1>Hello, Dave</h1>')
  end

  it 'works with nested templating' do
    expect(
      convert(
        context: {person: {name: 'Dave'}},
        input: <<~EMR,
          h1 Hello, |person.name|
        EMR
      )
    ).to eq('<h1>Hello, Dave</h1>')
  end

  it 'works in multiline literals' do
    expect(
      convert(
        context: {name: 'Dave'},
        input: <<~EMR,
          h1 ->
            Hello, world,
            my name is |name|
        EMR
      )
    ).to eq(whitespace_agnostic(<<~HTML))
      <h1>Hello, world,
      my name is Dave</h1>
    HTML
  end

  it 'does not template in multiline templateless literals' do
    expect(
      convert(
        context: {name: 'Dave'},
        input: <<~EMR,
          h1 =>
            Hello, world,
            my name is |name|
        EMR
      )
    ).to eq(whitespace_agnostic(<<~HTML))
      <h1>Hello, world,
      my name is |name|</h1>
    HTML
  end

  context 'escaping' do
    it 'handles escaped pipes' do
      expect(
        convert(
          context: {name: 'Dave'},
          input: <<~EMR,
            h1 Hello, \\||name|
          EMR
        )
      ).to eq('<h1>Hello, |Dave</h1>')
    end

    it 'handles escaped escaped pipes' do
      expect(
        convert(
          context: {name: 'Dave'},
          input: <<~EMR,
            h1 Hello, \\\\|name|
          EMR
        )
      ).to eq('<h1>Hello, \Dave</h1>')
    end

    it 'handles braces in multiline literals' do
      expect(
        convert(
          context: {},
          input: <<~EMR,
            h1 =>
              hey look a brace
              }
          EMR
        )
      ).to eq('<h1>hey look a brace }</h1>')
    end

    it 'handles braces in inline literals' do
      expect(
        convert(
          context: {},
          input: <<~EMR,
            h1 hey look a brace }
          EMR
        )
      ).to eq('<h1>hey look a brace }</h1>')
    end

    it 'does not alter templateless literals' do
      expect(
        convert(
          context: {},
          input: <<~EMR,
            h1 =>
              if (a || b) {
                console.log("truthy\\n");
              }
          EMR
        )
      ).to eq(whitespace_agnostic(<<~HTML))
        <h1>if (a || b) {
          console.log("truthy\\n");
        }</h1>
      HTML
    end
  end
end
