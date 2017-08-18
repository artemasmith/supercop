module Supercop
  module Parsers
    class Rubocop < Base
      private

      def parse
        JSON.parse(json).fetch('summary').fetch('offense_count')
      end
    end
  end
end
