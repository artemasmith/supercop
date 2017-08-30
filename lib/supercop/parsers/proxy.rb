module Supercop
  module Parsers
    class Proxy
      RUBOCOP = %w[SlimLint HamlLint].freeze

      attr_reader :json, :linter, :parser

      def initialize(json, linter)
        @linter = linter
        @json = json
        @parser = find_parser
      end

      def parse
        parser.call
      end

      private

      def find_parser
        return Rubocop.new(json) if rubocop_like_parser?

        ('Supercop::Parsers::' + linter.classify).constantize.new(json)
      rescue NameError
        Base.new(json)
      end

      def rubocop_like_parser?
        RUBOCOP.include?(linter.classify)
      end
    end
  end
end
