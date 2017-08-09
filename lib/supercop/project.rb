module Supercop
  class Project
    DEFAULT_NAME = 'project'.freeze
    CONFIG_PATH = %w[lib supercop templates].freeze

    class << self
      def name
        other_name = Dir.pwd.split('/').last || DEFAULT_NAME

        defined?(Rails) ? Rails.application.class.parent_name.downcase : other_name
      end

      def config_files(filename)
        File.join(root, CONFIG_PATH, filename)
      end

      def root
        Dir.pwd
      end

      # TODO: Check if I really need this
      # def templates_to_generate
      #   FileList.new('**/*.temp') do |fl|
      #     fl.exclude(File.join(Bundler.settings[:path],'/**/*')) if defined?(Bundler) && Bundler.settings[:path]
      #   end
      # end
    end
  end
end
