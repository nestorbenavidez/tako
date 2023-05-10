# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'tako/version'

Gem::Specification.new do |spec|
  spec.name          = 'tako'
  spec.version       = Tako::VERSION
  spec.authors       = ['Nestor Benavidez']
  spec.email         = ['nestor.benavidez@gmail.com']
  spec.summary       = 'A simple rule engine'
  spec.description   = 'A simple rule engine that supports forward and backward chaining, complex rule patterns, rule templates, fact tracking, rule ordering, custom operators, and functions'
  spec.homepage      = 'https://github.com/nestorbenavidez/tako'
  spec.license       = 'MIT'

  spec.files         = Dir['{lib,spec}/**/*'] + %w[LICENSE.txt README.md]
  spec.require_paths = ['lib']
  spec.bindir        = 'exe'

  spec.add_dependency 'json'

  spec.test_files    = Dir['spec/**/*_spec.rb']
end
