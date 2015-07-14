# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'traktion/version'

Gem::Specification.new do |spec|
  spec.name          = "traktion"
  spec.version       = Traktion::VERSION
  spec.authors       = ["Alan Ly"]
  spec.email         = ["hello@alan.ly"]

  spec.summary       = %q{An ORM-styled client for server-side applications that use the Trakt.tv API v2.}
  spec.description   = %q{This is an API client built on-top of Her, which allows for ActiveRecord-like
    interactions with the Trakt.tv API. It is intended to be used in server-side applications that do not
    require client-side authentication (i.e. OAuth).}
  spec.homepage      = "https://github.com/alanly/traktion"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "her", "~> 0.7"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "pry", "~> 0.10"
end
