require File.expand_path('../lib/opener/ned/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'opener-ned'
  gem.version     = Opener::Ned::VERSION
  gem.authors     = ['development@olery.com']
  gem.summary     = 'NED client using DBpedia'
  gem.description = gem.summary
  gem.has_rdoc    = 'yard'

  gem.required_ruby_version = '>= 1.9.2'

  gem.files = Dir.glob([
    'core/target/ehu-ned-*.jar',
    'lib/**/*',
    '*.gemspec',
    'config.ru',
    'README.md',
    'exec/**/*'
  ]).select { |file| File.file?(file) }

  gem.executables = Dir.glob('bin/*').map { |file| File.basename(file) }

  gem.add_dependency 'sinatra', '~> 1.4'
  gem.add_dependency 'httpclient'
  gem.add_dependency 'opener-webservice'
  gem.add_dependency 'nokogiri'
  gem.add_dependency 'puma'
  gem.add_dependency 'opener-daemons'
  gem.add_dependency 'opener-core', ['>= 0.1.2']

  gem.add_development_dependency 'opener-build-tools'
  gem.add_development_dependency 'rake'
end
