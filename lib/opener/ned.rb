require 'open3'
require 'optparse'

require_relative 'ned/version'
require_relative 'ned/cli'

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
    # Builds the command to use for executing the kernel.
    #
    # @return [String]
    #
    def command
      return "java -jar #{kernel} #{command_arguments.join(' ')}"
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

      unless File.file?(kernel)
        raise "The Java kernel (#{kernel}) does not exist"
      end

      return Open3.capture3(command, :stdin_data => input)
    end

    protected

    ##
    # Returns the arguments to pass to the underlying kernel as an Array.
    #
    # @return [Array]
    #
    def command_arguments
      arguments = [
        "-p #{options[:port]}",
        "-H #{options[:host]}"
      ]

      return arguments
    end

    ##
    # @return [String]
    #
    def core_dir
      return File.expand_path('../../../core/target', __FILE__)
    end

    ##
    # @return [String]
    #
    def kernel
      return File.join(core_dir, 'ehu-ned-1.0.jar')
    end
  end # Ned
end # Opener
