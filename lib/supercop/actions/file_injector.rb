module Supercop
  module Actions
    class FileInjector
      attr_reader :filename, :line

      def initialize(filename:, line:)
        @filename = filename
        @line = line
      end

      def perform
        return if file_include?

        insert_into_file
      end

      private

      def file_include?
        File.foreach(filename).grep(/#{sanitized}/).present?
      end

      def insert_into_file
        File.open(filename, 'a') do |f|
          f.write(line)
        end
      end

      def sanitized
        line.sub(/\s\n$/, '')
      end
    end
  end
end
