# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bouncer/version'

Gem::Specification.new do |spec|
  spec.name          = "bouncer"
  spec.version       = Bouncer::VERSION
  spec.authors       = ["Arjun Kavi"]
  spec.email         = ["arjun.kavi@gmail.com"]

  spec.summary       = %q{Finer grained method visibilty controls }
  spec.homepage      = "https://github.com/akavi/bouncer"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "binding_of_caller"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
end
