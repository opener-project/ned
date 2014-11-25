module Opener
  class Ned
    ##
    # CLI wrapper around {Opener::Ned} using Slop.
    #
    # @!attribute [r] parser
    #  @return [Slop]
    #
    class CLI
      attr_reader :parser

      def initialize
        @parser = configure_slop
      end

      ##
      # @param [Array] argv
      #
      def run(argv = ARGV)
        parser.parse(argv)
      end

      ##
      # @return [Slop]
      #
      def configure_slop
        return Slop.new(:strict => false, :indent => 2, :help => true) do
          banner 'Usage: ned [OPTIONS]'

          separator <<-EOF.chomp

About:

    Named Entity Disambiguation for various languages using DBPedia.
    This command reads input from STDIN.

Example:

    cat some_file.kaf | ned
          EOF

          separator "\nOptions:\n"

          on :v, :version, 'Shows the current version' do
            abort "ned v#{VERSION} on #{RUBY_DESCRIPTION}"
          end

          on :l, :logging, 'Enables debug logging output',
            :default => false

          on :'disable-time', 'Disables adding of dynamic timestamps',
            :default => false

          run do |opts, args|
            ned = Ned.new(
              :args        => args,
              :logging     => opts[:logging],
              :enable_time => !opts[:'disable-time']
            )

            input = STDIN.tty? ? nil : STDIN.read

            puts ned.run(input)
          end
        end
      end
    end # CLI
  end # Ned
end # Opener
