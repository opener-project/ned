require File.expand_path('../lib/opener/ned/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'opener-ned'
  gem.version     = Opener::Ned::VERSION
  gem.authors     = ['development@olery.com']
  gem.summary     = 'NED client using DBpedia'
  gem.description = gem.summary
  gem.has_rdoc    = 'yard'
  gem.license     = 'Apache 2.0'

  gem.required_ruby_version = '>= 1.9.2'

  gem.files = Dir.glob([
    'core/target/ehu-ned-*.jar',
    'lib/**/*',
    '*.gemspec',
    'config.ru',
    'README.md',
    'LICENSE.txt',
    'exec/**/*'
  ]).select { |file| File.file?(file) }

  gem.executables = Dir.glob('bin/*').map { |file| File.basename(file) }

  gem.add_dependency 'opener-daemons', '~> 2.2'
  gem.add_dependency 'opener-webservice', '~> 2.1'
  gem.add_dependency 'opener-core', '~> 2.3'

  gem.add_dependency 'nokogiri'
  gem.add_dependency 'slop', '~> 3.5'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'cliver'
  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'rspec'
end
