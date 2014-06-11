Introduction
------------

This repository contains a Named Entity Disambiguation tool that queries a DBpedia spotlight server. The client takes KAF as input (containing `<entities>` nodes).

### Confused by some terminology?

This software is part of a larger collection of natural language processing tools known as "the OpeNER project". You can find more information about the project at [the OpeNER portal](http://opener-project.github.io). There you can also find references to terms like KAF (an XML standard to represent linguistic annotations in texts), component, cores, scenario's and pipelines.


Quick Use Example
-----------------

Installing the ned can be done by executing:

    gem install opener-ned

Please bare in mind that all components in OpeNER take KAF as an input and output KAF by default.


### Command line interface

The NED client connects to the [DBPedia spotlight demo servers](http://dbpedia-spotlight.github.io/demo/).

A simple example:

    cat some_input_file.kaf | ned

An example output (excerpt) could look like this:

```xml
<entity eid="e3" type="organization">
  <references>
    <!--North Yorkshire Police-->
    <span>
      <target id="t17" />
      <target id="t18" />
      <target id="t19" />
    </span>
  </references>
  <externalReferences>
    <externalRef resource="spotlight_v1" reference="http://dbpedia.org/resource/North_Yorkshire_Police" />
  </externalReferences>
</entity>
```

### Webservices

You can launch a language identification webservice by executing:

    ned-server

This will launch a mini webserver with the webservice. It defaults to port 9292, so you can access it at <http://localhost:9292>.

To launch it on a different port provide the `-p [port-number]` option like this:

    ned-server -p 1234

It then launches at <http://localhost:1234>

Documentation on the Webservice is provided by surfing to the urls provided above. For more information on how to launch a webservice run the command with the ```-h``` option.


### Daemon

Last but not least the NED comes shipped with a daemon that can read jobs (and write) jobs to and from Amazon SQS queues. For moreinformation type:

    ned-daemon -h


Description of dependencies
---------------------------

This component runs best if you run it in an environment suited for OpeNER components. You can find an installation guide and helper tools in the [OpeNER installer](ttps://github.com/opener-project/opener-installer) and an
[installation guide on the Opener Website](http://opener-project.github.io/getting-started/how-to/local-installation.html)

At least you need the following system setup:

### Depenencies for normal use:

* Jruby (1.7.9 or newer)
* Java 1.7 or newer (There are problems with encoding in older versions).

### Dependencies if you want to modify the component:

* Maven (for building the Gem)

### Structure

This repository comes in two parts: a collection of Java source files and Ruby source files. The Java code can be found in the `core/` directory, everything else will be Ruby source code.

Language Extension
------------------

  TODO

Where to go from here
---------------------

* [Check the project website](http://opener-project.github.io)
* [Checkout the webservice](http://opener.olery.com/ned)

Report problem/Get help
-----------------------

If you encounter problems, please email <support@opener-project.eu> or leave an issue in the 
[issue tracker](https://github.com/opener-project/ned/issue).


Contributing
------------

1. Fork it <http://github.com/opener-project/ned/fork>
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

