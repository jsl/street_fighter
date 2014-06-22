# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'failable/version'

Gem::Specification.new do |spec|
  spec.name          = "failable"
  spec.version       = Failable::VERSION
  spec.authors       = ["Justin Leitgeb"]
  spec.email         = ["justin@stackbuilders.com"]
  spec.summary       = %q{An implementation of an Either monad in Ruby}
  spec.description   = %q{Implements an Either monad in Ruby for cleaner error handling.}
  spec.homepage      = "http://github.com/stackbuilders/failable"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10"
  spec.add_development_dependency 'mocha', "~> 1"
end
