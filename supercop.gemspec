# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'supercop/version'

Gem::Specification.new do |spec|
  spec.name          = 'supercop'
  spec.version       = Supercop::VERSION
  spec.authors       = ['Artem Kuznetsov']
  spec.email         = ['artemasmith@gmailcom']

  spec.summary       = %q{Utility for get easy and simple code quality report
                          based on different linters, like rubocop or reek}
  spec.description   = %q{This gem allows you to use multiply lnters to check
                          your code quality and get nice table-view report}
  spec.homepage      = 'http://github.com/artemasmith/supercop'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 1.13'
  spec.add_development_dependency 'rake', '>= 10.0'
  spec.add_development_dependency 'rspec', '>= 3.0'
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'fakefs'
  spec.add_development_dependency 'activesupport'
  spec.add_development_dependency 'json'
end
