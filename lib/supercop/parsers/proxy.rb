module Supercop
  module Parsers
    class Proxy
      RUBOCOP = %w[SlimLint HamlLint].freeze

      attr_accessor :parser
      attr_reader :json, :linter

      def initialize(json, linter)
        @linter = linter
        @json = json
        @parser = find_parser
      end

      def parse
        parser.perform
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
