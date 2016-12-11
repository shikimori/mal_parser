Gem::Specification.new do |gem|
  gem.name = 'mal_parser'
  gem.version = '0.0.1'
  gem.date = '2016-12-11'
  gem.summary = 'MAL Parser'
  gem.description = 'myanimelist.net parsing library'
  gem.authors = ['https://github.com/morr']
  gem.email = 'takandar@gmail.com'
  gem.files = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.require_paths = ['lib']
  gem.license = 'MIT'
  # gem.homepage    = 'http://rubygems.org/gems/url'

  gem.required_ruby_version = '>= 2.2.2'

  gem.add_dependency 'vcr'

  gem.add_development_dependency 'rspec'
  # gem.add_development_dependency 'rspec-core'
  # gem.add_development_dependency 'rspec-expectations'
  # gem.add_development_dependency 'rspec-mocks'
  # gem.add_development_dependency 'rspec-rails'
  # gem.add_development_dependency 'rspec-collection_matchers'
  # gem.add_development_dependency 'rspec-its'

  gem.add_development_dependency 'pry-byebug'
  gem.add_development_dependency 'pry-stack_explorer'

  gem.add_development_dependency 'rb-inotify'
  gem.add_development_dependency 'rb-fsevent'
  gem.add_development_dependency 'rb-fchange'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'guard-bundler'
  gem.add_development_dependency 'guard-rubocop'
end
