# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'street_fighter/version'

Gem::Specification.new do |spec|
  spec.name          = "street_fighter"
  spec.version       = StreetFighter::VERSION
  spec.authors       = ["Justin Leitgeb"]
  spec.email         = ["support@stackbuilders.com"]
  spec.summary       = %q{An implementation of an Either monad in Ruby}
  spec.description   = %q{Implements an Either monad in Ruby for cleaner error handling.}
  spec.homepage      = "http://github.com/stackbuilders/street_fighter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10"
  spec.add_development_dependency 'mocha', "~> 1"
end
