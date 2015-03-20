# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'punditry/version'

Gem::Specification.new do |spec|
  spec.name          = "punditry"
  spec.version       = Punditry::VERSION
  spec.authors       = ["Jason Kriss"]
  spec.email         = ["jasonkriss@gmail.com"]
  spec.summary       = %q{A super-slim wrapper on top of Pundit.}
  spec.homepage      = "https://github.com/jasonkriss/punditry"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "pundit"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
