#!/usr/bin/env ruby

require 'opener/daemons'

require_relative '../lib/opener/ned'

daemon = Opener::Daemons::Daemon.new(Opener::Ned)

daemon.start
