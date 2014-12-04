desc 'Runs the tests'
task :test => [:dbpedia, :compile] do
  sh 'cucumber features'
  sh 'rspec spec'
end
