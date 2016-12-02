#!/usr/bin/env ruby
# frozen_string_literal: true

require 'spec_helper'

describe Emerald do
  it 'supports nested tags with attributes' do
    expect(
      convert(
        context: {},
        input: <<~EMR,
          section (
            class "something"
          )
            h1 Test
        EMR
      )
    ).to eq('<section class="something"><h1>Test</h1></section>')
  end

  it 'text rule works with attributes' do
    expect(
      convert(
        context: {},
        input: <<~EMR,
          h1 Attributes follow parentheses. (
            id     "header"
            class  "main-text"
            height "50px"
            width  "200px"
          )
        EMR
      )
    ).to eq('<h1 id="header" class="main-text" height="50px" width="200px">Attributes follow parentheses.</h1>')
  end

  it 'tag statement rule works with attributes' do
    expect(
      convert(
        context: {},
        input: <<~EMR,
          section Attributes follow parentheses. (
            id     "header"
            class  "main-text"
            height "50px"
            width  "200px"
          )
        EMR
      )
    ).to eq('<section id="header" class="main-text" height="50px" width="200px">'\
      'Attributes follow parentheses.</section>')
  end

  it 'escaping parentheses works' do
    expect(
      convert(
        context: {},
        input: <<~EMR,
          section here's some text \\(and some stuff in brackets\\) (
            class "something"
          )
        EMR
      )
    ).to eq('<section class="something">here\'s some text (and some stuff in brackets)</section>')
  end

  it 'supports single line comments' do
    expect(
      convert(
        context: {},
        input: <<~EMR,
          * test
          h1 test
        EMR
      )
    ).to eq('<!-- test --> <h1>test</h1>')
  end

  it 'supports multiline comments' do
    expect(
      convert(
        context: {},
        input: <<~EMR,
          * ->
            test
          h1 test
        EMR
      )
    ).to eq('<!-- test --> <h1>test</h1>')
  end

  context 'inline identifiers' do
    it 'converts classes' do
      expect(
        convert(
          context: {},
          input: <<~EMR,
            h1.something test
          EMR
        )
      ).to eq('<h1 class="something">test</h1>')
    end

    it 'converts multiple classes' do
      expect(
        convert(
          context: {},
          input: <<~EMR,
            h1.a.b test
          EMR
        )
      ).to eq('<h1 class="a b">test</h1>')
    end

    it 'supports ids' do
      expect(
        convert(
          context: {},
          input: <<~EMR,
            h1#some-id_ test
          EMR
        )
      ).to eq('<h1 id="some-id_">test</h1>')
    end

    it 'supports classes and ids' do
      expect(
        convert(
          context: {},
          input: <<~EMR,
            h1#a.b.c test
          EMR
        )
      ).to eq('<h1 id="a" class="b c">test</h1>')
    end
  end

  it 'self-closes void tags' do
    expect(
      convert(
        context: {},
        input: <<~EMR,
          img
        EMR
      )
    ).to eq('<img />')
  end
end
