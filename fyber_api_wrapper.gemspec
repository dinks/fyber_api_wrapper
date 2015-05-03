# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fyber_api_wrapper/version'

Gem::Specification.new do |spec|
  spec.name          = "fyber_api_wrapper"
  spec.version       = FyberApiWrapper::VERSION
  spec.authors       = ["Dinesh Vasudevan"]
  spec.email         = ["dineshvasudevan2003@yahoo.com"]
  spec.summary       = %q{ Fyber API Wrapper }
  spec.description   = %q{ This serves as a Wrapper to http://developer.fyber.com/content/ios/offer-wall/offer-api/ }
  spec.homepage      = "https://github.com/dinks/fyber_api_wrapper"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "faker"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"

  spec.add_dependency "httparty"
  spec.add_dependency "json"
  spec.add_dependency "addressable"
end
