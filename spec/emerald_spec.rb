# frozen_string_literal: true
require 'spec_helper'

describe Emerald do
  it 'has a version number' do
    expect(Emerald::VERSION).not_to be nil
  end

  it 'shows meaningful errors' do
    input = <<~EMR
      html
        body
          h1 Hello, world (
            class something
          )
          p Test
    EMR
    expect{ Emerald.convert(input) }.to raise_error(Grammar::ParserError) do |e|
      expect(e.message).to include('>>>       class something')
    end
  end
end
