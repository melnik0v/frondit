# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "frondit/version"

Gem::Specification.new do |gem|
  gem.name          = "frondit"
  gem.version       = Frondit::VERSION
  gem.authors       = ["Alexey Melnikov"]
  gem.email         = ["alexbeat96@gmail.com"]

  gem.summary       = 'Pundit through javascript'
  gem.description   = 'Move your own Pundit policies to your frontend part on JS'
  gem.homepage      = "https://github.com/melnik0v/frondit"
  gem.license       = "MIT"
  gem.files         = `git ls-files`.split($\)

  gem.required_ruby_version = '>= 2.2'
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'activesupport', '~> 5.0', '>= 5.0.0'
  gem.add_runtime_dependency 'gon', '~> 6.2', '>= 6.2.0'
  gem.add_runtime_dependency 'pundit', '~> 1.1.0', '>= 1.1.0'

  gem.add_development_dependency "bundler", "~> 1.16"
  gem.add_development_dependency "rake", "~> 10.0"
  gem.add_development_dependency "rubocop", "~> 0.50"
end
