require File.expand_path('../lib/opener/ned/version', __FILE__)

generated = Dir.glob('core/target/ehu-ned-*.jar')

Gem::Specification.new do |gem|
  gem.name        = 'opener-ned'
  gem.version     = Opener::Ned::VERSION
  gem.authors     = ['development@olery.com']
  gem.summary     = 'Ned client using DBpedia'
  gem.description = gem.summary
  gem.has_rdoc    = 'yard'

  gem.required_ruby_version = '>= 1.9.2'

  gem.files       = (`git ls-files`.split("\n") + generated).sort
  gem.executables = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files  = gem.files.grep(%r{^(test|spec|features)/})

  gem.add_dependency 'sinatra', '~> 1.4'
  gem.add_dependency 'httpclient'
  gem.add_dependency 'opener-webservice'

  gem.add_development_dependency 'opener-build-tools'
  gem.add_development_dependency 'rake'
end
