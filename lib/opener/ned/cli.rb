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

          opts.on('-h', '--help', 'Shows this help message') do
            show_help
          end

          opts.on('-v', '--version', 'Shows the current version') do
            show_version
          end

          opts.on('-p', '--port [VALUE]', 'Use a custom port') do |value|
            @options[:port] = value
          end

          opts.on('-H', '--host [VALUE]', 'Use a custom hostname') do |value|
            @options[:host] = value
          end

          opts.separator <<-EOF

Examples:

  cat input_file.kaf | #{opts.program_name}
  cat input_file.kaf | #{opts.program_name} --host=http://some-host.com/

Port Numbers:

  Port numbers are required. Each language has its own port number (unless
  specified otherwise):

  * German: 2010
  * English: 2020
  * Spanish: 2030
  * French: 2040
  * Italian: 2050
  * Dutch: 2060

  By default port 2020 (English) is used.
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
