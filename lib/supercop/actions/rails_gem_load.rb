module Supercop
  module Actions
    require 'rails/generators'

    class RailsGemLoad
      attr_reader :gem_name, :config

      def initialize(gem_name)
        @gem_name = gem_name
        @config = Supercop.configuration.public_send(gem_name)
      end

      def perform
        require gem_name
      rescue LoadError
        add_gem

        puts "#{gem_name} wass added as dependency."
      end

      private

      def add_gem
        inject_into_file(Supercop.configuration.file_path,
                         gem_config)
      end

      def gem_config
        result = %W[gem '#{gem_name}']
        result << ", #{config[:version]}" if option?(:version)
        result << ", path: '#{config[:path]}'" if option?(:path)
        result << ", git: '#{config[:git]}'" if option?(:git) && !option?(:path)
        result << "\n"
        result.join(' ')
      end

      def option?(option)
        config.keys.include?(option)
      end
    end
  end
end
