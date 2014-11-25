require 'java'
require 'stringio'

require 'slop'
require 'nokogiri'

require File.expand_path('../../../core/target/ehu-ned-1.0.jar', __FILE__)

require_relative 'ned/version'
require_relative 'ned/cli'

module Opener
  ##
  # Ruby wrapper around the Java based NED tool that's powered by DBpedia.
  #
  # @!attribute [r] options
  #  @return [Hash]
  #
  class Ned
    attr_reader :options

    ##
    # The DBpedia endpoints for every language code.
    #
    # @return [Hash]
    #
    LANGUAGE_ENDPOINTS = {
      "en" => "http://spotlight.sztaki.hu:2222",
      "nl" => "http://nl.dbpedia.org/spotlight",
      "fr" => "http://spotlight.sztaki.hu:2225",
      "de" => "http://de.dbpedia.org/spotlight",
      "es" => "http://spotlight.sztaki.hu:2231",
      "it" => "http://spotlight.sztaki.hu:2230",
      "ru" => "http://spotlight.sztaki.hu:2227",
      "pt" => "http://spotlight.sztaki.hu:2228",
      "hu" => "http://spotlight.sztaki.hu:2229",
      "tr" => "http://spotlight.sztaki.hu:2235"
    }

    ##
    # Hash containing the default options to use.
    #
    # @return [Hash]
    #
    DEFAULT_OPTIONS = {
      :args        => [],
      :logging     => false,
      :enable_time => true
    }.freeze

    ##
    # @param [Hash] options
    #
    # @option options [Array] :args Arbitrary arguments to pass to the
    #  underlying kernel.
    #
    # @option options [TrueClass|FalseClass] :logging When set to `true`
    #  logging is enabled. This is disabled by default.
    #
    # @option options [TrueClass|FalseClass] :enable_time When set to `true`
    #  the output will include timestamps.
    #
    def initialize(options = {})
      @options = DEFAULT_OPTIONS.merge(options)
    end

    ##
    # Performs NED on the given input document. The return value is the
    # resulting KAF document.
    #
    # @param [String] input The input KAF document.
    # @return [String]
    #
    def run(input)
      if !input or input.strip.empty?
        raise ArgumentError, 'No input specified'
      end

      language  = language_from_kaf(input)
      input_io  = StringIO.new(input)
      reader    = Java::java.io.InputStreamReader.new(input_io.to_inputstream)
      document  = Java::ixa.kaflib.KAFDocument.create_from_stream(reader)
      annotator = new_annotator
      endpoint  = options.fetch(:endpoint, uri_for_language(language))

      annotator.disambiguateNEsToKAF(
        document,
        endpoint.to_s
      )

      return document.to_string
    end

    private

    ##
    # Creates and configures a new Annotate class.
    #
    # @return [Java::ehu.ned.Annotate]
    #
    def new_annotator
      annotator = Java::ehu.ned.Annotate.new

      unless options[:logging]
        annotator.disableLogging
      end

      unless options[:enable_time]
        annotator.disableTimestamp
      end

      return annotator
    end

    ##
    # Returns the language from the KAF document.
    #
    # @param [String] input The input KAF document.
    # @return [String]
    #
    def language_from_kaf(input)
      document = Nokogiri::XML(input)

      return document.at('KAF').attr('xml:lang')
    end

    ##
    # Returns the endpoint URL for the given language.
    #
    # @param [String] language
    # @return [String]
    #
    def uri_for_language(language)
      return LANGUAGE_ENDPOINTS[language] + "/rest/disambiguate"
    end
  end # Ned
end # Opener
