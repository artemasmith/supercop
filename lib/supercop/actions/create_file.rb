require_relative '../project'

module Supercop
  module Actions
    class CreateFile
      require 'fileutils'

      def initialize(args)
        @filename = args.fetch(:filename)
        @destination = args.fetch(:destination)
        @options = args.fetch(:options, force: false)
      end

      def perform
        puts 'Please provide filename and destination' && return if invalid_attributes?
        puts "There is no destination #{destination}" && return if invalid_destination?

        FileUtils.copy(template_file, destination_file)

        puts "file #{filename} created"
      end

      private

      attr_reader :filename, :destination

      def invalid_destination?
        !Dir.exists?(destination)
      end

      def invalid_attributes?
        filename.blank? || destination.blank?
      end

      def template_file
        Project.config_files(filename)
      end

      def destination_file
        File.join(destination, filename)
      end
    end
  end
end
