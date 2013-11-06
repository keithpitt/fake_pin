# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fake_pin/version'

Gem::Specification.new do |spec|
  spec.name          = "fake_pin"
  spec.version       = FakePin::VERSION
  spec.authors       = ["Keith Pitt"]
  spec.email         = ["me@keithpitt.com"]
  spec.description   = %q{A rack-mountable version of the Pin Payments API}
  spec.summary       = %q{A rack-mountable version of the Pin Payments API}
  spec.homepage      = "https://github.com/keithpitt/fake_pin"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rack'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
