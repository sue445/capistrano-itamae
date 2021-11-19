# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/itamae/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-itamae"
  spec.version       = Capistrano::Itamae::VERSION
  spec.authors       = ["sue445"]
  spec.email         = ["sue445@sue445.net"]

  spec.summary       = %q{Run itamae in capistrano task}
  spec.description   = %q{Run itamae in capistrano task}
  spec.homepage      = "https://github.com/sue445/capistrano-itamae"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler"
  spec.add_dependency "capistrano", ">= 3.5.0"
  spec.add_dependency "itamae"

  spec.add_development_dependency "bcrypt_pbkdf", ">= 1.0", "< 2.0"
  spec.add_development_dependency "ed25519", ">= 1.2", "< 2.0"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake", ">= 11.0"
  spec.add_development_dependency "serverspec"
end
