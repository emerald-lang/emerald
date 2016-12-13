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

  context 'list rules' do
    it 'supports \'images\' special rule' do
      expect(
        convert(
          context: {},
          input: <<~EMR,
            images
              "images/nav/home.png"
              "images/nav/about.png"
              "images/nav/blog.png"
              "images/nav/contact.png"
          EMR
        )
      ).to eq("<img src=\"images/nav/home.png\"/> <img src=\"images/nav/about.png\"/> <img src=\"images/nav/blog.png\"/> <img src=\"images/nav/contact.png\"/>")
    end

    it 'supports \'images\' base rule' do
      expect(
        convert(
          context: {},
          input: <<~EMR,
            images
              src "images/nav/home.png"
              src "images/nav/about.png"
              src "images/nav/blog.png"
              src "images/nav/contact.png"
          EMR
        )
      ).to eq("<img src='images/nav/home.png'/> <img src='images/nav/about.png'/> <img src='images/nav/blog.png'/> <img src='images/nav/contact.png'/>")
    end

    it 'supports \'scripts\' special rule' do
      expect(
        convert(
          context: {},
          input: <<~EMR,
            scripts
              "vendor/jquery.js"
              "js/main.js"
          EMR
        )
      ).to eq("<script type='text/javascript' src=\"vendor/jquery.js\"></script> <script type='text/javascript' src=\"js/main.js\"></script>")
    end

    it 'supports \'scripts\' base rule' do
      expect(
        convert(
          context: {},
          input: <<~EMR,
            scripts
              type "text/javascript" src "vendor/jquery.js"
              type "text/javascript" src "js/main.js"
          EMR
        )
      ).to eq("<script type='text/javascript' src='vendor/jquery.js'></script> <script type='text/javascript' src='js/main.js'></script>")
    end

    it 'supports \'styles\' special rule' do
      expect(
        convert(
          context: {},
          input: <<~EMR,
            styles
              "css/main.css"
              "css/footer.css"
          EMR
        )
      ).to eq("<link rel='stylesheet' href=\"css/main.css\"/> <link rel='stylesheet' href=\"css/footer.css\"/>")
    end

    it 'supports \'styles\' base rule' do
      expect(
        convert(
          context: {},
          input: <<~EMR,
            styles
              href "css/main.css" type "text/css"
              href "css/footer.css" type "text/css"
          EMR
        )
      ).to eq("<link href='css/main.css' type='text/css'/> <link href='css/footer.css' type='text/css'/>")
    end

    it 'supports \'metas\' base rule' do
      expect(
        convert(
          context: {},
          input: <<~EMR,
            metas
              name "test-name" content "test-content"
              name "test-name-2" content "test-content-2"
          EMR
        )
      ).to eq("<meta name='test-name' content='test-content'> <meta name='test-name-2' content='test-content-2'>")
    end
  end
end
