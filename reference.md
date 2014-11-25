## Reference

### Command Line Interface

#### Examples:

### Command line interface

A simple example:

    cat some_input_file.kaf | ned

An example output (excerpt) could look like this:

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

### Webservice

You can launch a webservice by executing:

    ned-server

After launching the server, you can reach the webservice at
<http://localhost:9292>.

The webservice takes several options that get passed along to
[Puma](http://puma.io), the webserver used by the component. The options are:

    -h, --help                Shows this help message
        --puma-help           Shows the options of Puma
    -b, --bucket              The S3 bucket to store output in
        --authentication      An authentication endpoint to use
        --secret              Parameter name for the authentication secret
        --token               Parameter name for the authentication token
        --disable-syslog      Disables Syslog logging (enabled by default)

### Daemon

The daemon has the default OpeNER daemon options. Being:

    -h, --help                Shows this help message
    -i, --input               The name of the input queue (default: opener-ner)
    -b, --bucket              The S3 bucket to store output in (default: opener-ner)
    -P, --pidfile             Path to the PID file (default: /var/run/opener/opener-ner-daemon.pid)
    -t, --threads             The amount of threads to use (default: 10)
    -w, --wait                The amount of seconds to wait for the daemon to start (default: 3)
        --disable-syslog      Disables Syslog logging (enabled by default)

When calling ner without "start", "stop" or "restart" the daemon will start as a
foreground process.

#### Environment Variables

These daemons make use of Amazon SQS queues and other Amazon services. For these
services to work correctly you'll need to have various environment variables
set. These are as following:

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `AWS_REGION`

For example:

    AWS_REGION='eu-west-1' language-identifier start [other options]

### Languages

The NED component currently supports the following languages:

* English (en)
* Dutch (nl)
* French (fr)
* German (de)
* Spanish (es)
* Italian (it)
* Russian (ru)
* Portuguese (pt)
* Hungarian (hu)
* Turkish (tr)
