#!/usr/bin/env ruby

require 'opener/daemons'
require_relative '../lib/opener/ned'

options = Opener::Daemons::OptParser.parse!(ARGV)
daemon  = Opener::Daemons::Daemon.new(Opener::Ned, options)

daemon.start