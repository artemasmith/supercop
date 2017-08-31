module Supercop
  module Actions
    class ConfigCopier
      require 'fileutils'
      CONFIG_PATH = %w[lib supercop templates].freeze

      def initialize(args)
        @filename = args.fetch(:filename, 'supercop.yml')
        @destination = args.fetch(:destination)
        @options = args.fetch(:options, {})
        @source = args.fetch(:source, 'supercop.yml')
      end

      def call
        return "There is no destination #{destination}" if invalid_destination?
        return "#{destination_file} already exists" if File.file?(destination_file)

        FileUtils.copy(source_file, destination_file, options)

        "file #{destination_file} was created"
      rescue => e
        "Could not create file. #{e.message}"
      end

      private

      attr_reader :filename, :destination, :source, :options

      def invalid_destination?
        destination.empty? || !Dir.exist?(destination)
      end

      def source_file
        File.join(root, CONFIG_PATH, source)
      end

      def destination_file
        File.join(destination, filename)
      end

      def root
        Gem.loaded_specs['supercop'].full_gem_path
      end
    end
  end
end
