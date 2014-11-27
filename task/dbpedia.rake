# The version of DBPedia to install.
dbpedia_version = '0.7'

jar_name = "dbpedia-spotlight-#{dbpedia_version}.jar"
tmp_jar  = "tmp/#{jar_name}"

file(tmp_jar) do |task|
  url = "https://github.com/dbpedia-spotlight/dbpedia-spotlight/releases/" \
    "download/release-#{dbpedia_version}/#{jar_name}"

  sh "wget #{url} -O #{task.name}"

  sh "mvn install:install-file -Dfile=#{tmp_jar} -DgroupId=ixa " \
    "-DartifactId=dbpedia-spotlight " \
    "-Dversion=#{dbpedia_version} " \
    "-Dpackaging=jar " \
    "-DgeneratePom=true"
end

desc 'Installs a local copy of DBPedia Spotlight'
task :dbpedia => [tmp_jar]
