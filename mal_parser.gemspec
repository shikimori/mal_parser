# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mal_parser/version'

Gem::Specification.new do |spec|
  spec.name            = 'mal_parser'
  spec.version        = MalParser::VERSION
  spec.date            = '2016-12-11'
  spec.summary         = 'MAL Parser'
  spec.description     = 'myanimelist.net parsing library'
  spec.authors         = ['https://github.com/morr']
  spec.email           = 'takandar@gmail.com'
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths   = ['lib']
  spec.license         = 'MIT'
  # spec.homepage        = 'http://rubygems.org/gems/url'

  spec.required_ruby_version = '>= 2.2.2'

  spec.add_dependency 'attr_extras'
  spec.add_dependency 'nokogiri'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-collection_matchers'

  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'

  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'pry-stack_explorer'
  spec.add_development_dependency 'awesome_print'

  spec.add_development_dependency 'rb-inotify'
  spec.add_development_dependency 'rb-fsevent'
  spec.add_development_dependency 'rb-fchange'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'guard-rubocop'
end
