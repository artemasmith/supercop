module Supercop
  module Actions
    class FileInjector
      attr_reader :filename
      attr_accessor :strings

      def initialize(filename:, strings:)
        @filename = filename
        @strings = strings
      end

      def perform
        puts "STRINGS\n #{strings}"
        # strings.delete_if { |string| file_include?(string) }

        insert_into_file
      end

      private

      def file_include?(string)
        File.foreach(filename).grep(/#{string}/)
      end

      def insert_into_file
        puts "strings \n#{strings}\n"
        File.open(filename, 'a').write(strings)
      end
    end
  end
end
