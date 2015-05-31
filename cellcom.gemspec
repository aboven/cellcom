# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cellcom/version'

Gem::Specification.new do |spec|
  spec.name          = "cellcom"
  spec.version       = Cellcom::VERSION
  spec.authors       = ["gregory"]
  spec.email         = ["greg2502@gmail.com"]
  spec.summary       = %q{Ruby Wrapper around the Cellcom api}
  spec.description   = %q{More info here: https://www.cellcom.eu/en/}
  spec.homepage      = "https://github.com/gregory/cellcom"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "attestor", "~> 2.2.1"
end
