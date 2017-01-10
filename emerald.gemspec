# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'emerald/version'

Gem::Specification.new do |spec|
  spec.name          = 'emerald-lang'
  spec.version       = Emerald::VERSION
  spec.authors       = ['Andrew McBurney', 'Dave Pagurek', 'Yu Chen Hu']
  spec.email         = ['andrewrobertmcburney@gmail.com', 'davepagurek@gmail.com', 'me@yuchenhou.com']

  spec.summary       = 'A language agnostic templating engine designed with event driven applications in mind.'
  spec.description   = 'A language agnostic templating engine designed with event driven applications in mind.' # TODO: make better description
  spec.homepage      = 'https://github.com/emerald-lang/emerald' # TODO: replace with website once created
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = ['emerald']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'test-unit'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'pre-commit'

  spec.add_runtime_dependency 'htmlentities'
  spec.add_runtime_dependency 'treetop'
  spec.add_runtime_dependency 'thor'
  spec.add_runtime_dependency 'htmlbeautifier', '~> 1.1', '>= 1.1.1'
end
