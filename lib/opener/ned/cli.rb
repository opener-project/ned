module Opener
  class Ned
    ##
    # CLI wrapper around {Opener::Ned} using OptionParser.
    #
    # @!attribute [r] options
    #  @return [Hash]
    # @!attribute [r] option_parser
    #  @return [OptionParser]
    #
    class CLI
      attr_reader :options, :option_parser

      ##
      # @param [Hash] options
      #
      def initialize(options = {})
        @options = DEFAULT_OPTIONS.merge(options)

        @option_parser = OptionParser.new do |opts|
          opts.program_name   = 'ned'
          opts.summary_indent = '  '

          opts.separator "\nOptions:\n\n"

          opts.on('-h', '--help', 'Shows this help message') do
            show_help
          end

          opts.on('-v', '--version', 'Shows the current version') do
            show_version
          end

          opts.on('-l', '--logging', 'Enables logging output') do
            @options[:logging] = true
          end

          opts.on('--no-time', 'Disables timestamps') do
            @options[:enable_time] = false
          end

          opts.separator <<-EOF

Examples:

  cat input_file.kaf | #{opts.program_name}

          EOF
        end
      end

      ##
      # @param [String] input
      #
      def run(input)
        option_parser.parse!(options[:args])

        ned = Ned.new(options)

        puts ned.run(input)
      end

      private

      ##
      # Shows the help message and exits the program.
      #
      def show_help
        abort option_parser.to_s
      end

      ##
      # Shows the version and exits the program.
      #
      def show_version
        abort "#{option_parser.program_name} v#{VERSION} on #{RUBY_DESCRIPTION}"
      end
    end # CLI
  end # Ned
end # Opener
