# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'closeio/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "closeio-rails"
  spec.version       = Closeio::Rails::VERSION
  spec.authors       = ["Ed Jones", "Paul Hendrick"]
  spec.email         = ["ed@error.agency", "paul@error.agency"]

  spec.summary       = %q{A wrapper around the closeio gem to provide some useful functionality in Rails}
  spec.homepage      = "https://github.com/errorstudio/close-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "require_all", "~> 1.3"
  spec.add_dependency "closeio", "~> 2.6"
  spec.add_dependency "rails", ">= 4.2", "< 6.0.0"

end
