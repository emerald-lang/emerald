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
end
