require_relative '../project'

module Supercop
  module Actions
    class EmptyFolder
      require 'fileutils'

      def initialize(args)
        @destination = args.fetch(:destination)
        @options = args.fetch(:options, force: false)
      end

      def perform
        return "Folder already exists #{destination}" if invalid_destination?

        FileUtils.mkdir_p(destination, options)

        "folders #{destination} was created"
      rescue => e
        "Could not create folders. #{e.message}"
      end

      private

      attr_reader :destination, :options

      def invalid_destination?
        Dir.exist?(destination)
      end
    end
  end
end
