require 'optparse'
require 'java'
require 'stringio'

require File.expand_path('../../../core/target/ehu-ned-1.0.jar', __FILE__)

require_relative 'ned/version'
require_relative 'ned/cli'

import 'java.io.InputStreamReader'

import 'ehu.ned.Annotate'
import 'ixa.kaflib.KAFDocument'

module Opener
  ##
  # Ruby wrapper around the Java based Ned tool that's powered by DBpedia.
  #
  # @!attribute [r] options
  #  @return [Hash]
  #
  class Ned
    attr_reader :options

    ##
    # @return [String]
    #
    DEFAULT_HOST = 'http://localhost'

    ##
    # @return [Numeric]
    #
    DEFAULT_PORT = 2020 # English

    ##
    # Hash containing the default options to use.
    #
    # @return [Hash]
    #
    DEFAULT_OPTIONS = {
      :args => [],
      :port => DEFAULT_PORT,
      :host => DEFAULT_HOST
    }.freeze

    ##
    # @param [Hash] options
    #
    # @option options [Array] :args Arbitrary arguments to pass to the
    #  underlying kernel.
    # @option options [String|Numeric] :port The port number to connect to.
    # @option options [String] :host The hostname of the DBpedia server.
    # @option options [String] :language When set the port number will be based
    #  on this value.
    #
    def initialize(options = {})
      @options = DEFAULT_OPTIONS.merge(options)

      @options[:host] ||= DEFAULT_HOST
      @options[:port] ||= DEFAULT_PORT
    end

    ##
    # Processes the input and returns an Array containing the output of STDOUT,
    # STDERR and an object containing process information.
    #
    # @param [String] input The text of which to detect the language.
    # @return [Array]
    #
    def run(input)
      if !input or input.strip.empty?
        raise ArgumentError, 'No input specified'
      end

      input_io  = StringIO.new(input)
      reader    = InputStreamReader.new(input_io.to_inputstream)
      document  = KAFDocument.create_from_stream(reader)
      annotator = Java::ehu.ned.Annotate.new

      annotator.disambiguateNEsToKAF(
        document,
        options[:host],
        options[:port].to_s
      )

      return document.to_string
    end
  end # Ned
end # Opener
