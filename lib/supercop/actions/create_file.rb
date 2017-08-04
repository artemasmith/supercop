module Supercop
  module Actions
    class CreateFile
      require 'fileutils'

      def initialize(args)
        @filename = args.fetch(:filename)
        @destination = args.fetch(:destination)
        @template_file = args.fetch(:template_file)
      end

      def perform
        puts "file #{filename} created"
      end

      private

      attr_reader :filename, :destination, :template_file

      def check_destination
        Dir.exists?(destination)
      end
    end
  end
end
