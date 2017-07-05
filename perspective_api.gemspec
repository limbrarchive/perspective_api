# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "perspective_api"
  spec.version       = "0.0.1"
  spec.authors       = ["Pat Allan"]
  spec.email         = ["pat@freelancing-gods.com"]

  spec.summary       = %q{Ruby Wrapper for the Google Perspective API.}
  spec.homepage      = "https://github.com/limbrup/perspective_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "multi_json"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec",   ">= 3.6.0"
  spec.add_development_dependency "webmock", ">= 3.0.0"
end
