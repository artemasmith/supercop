module Supercop
  module Parsers
    class Base
      attr_reader :json, :config

      def initialize(json)
        @json = json
        @config = Supercop.configuration
      end

      def call
        warnings_count
      end

      private

      def parse
        JSON.parse(json).count
      end

      def warnings_count
        parse
      rescue => e
        parse_error(e)

        'none'
      end

      def parse_error(e)
        msg = %Q[Wrong configuration for linter,
                 please check the path and options provided.
                 Error: #{e.message}]

        puts msg if config.verbose
      end
    end
  end
end
