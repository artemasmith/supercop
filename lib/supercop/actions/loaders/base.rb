module Supercop
  module Actions
    module Loaders
      class Base
        attr_reader :gem_name, :config

        def initialize(gem_name)
          @gem_name = gem_name
          @config = Supercop.configuration.public_send(gem_name)
        end

        def perform
          require gem_name
        rescue LoadError
          add_gem

          puts "#{gem_name} wass added as dependency.\n"
        end

        private

        def add_gem
          file = Supercop.configuration.path('Gemfile')
          if defined?(Rails)
            inject_into_file(file, gem_config)
          else
            Supercop::Actions::FileInjector.new(filename: file, strings: gem_config).perform
          end
        end

        def gem_config
          result = ["gem '#{gem_name}'"]
          result << ", #{config[:version]}" if option?(:version)
          result << ", path: '#{config[:path]}'" if option?(:path)
          result << ", git: '#{config[:git]}'" if option?(:git) && !option?(:path)
          result << "\n"
          puts "\ngem_config #{result}\n"
          result.join(' ')
        end

        def option?(option)
          config.keys.include?(option)
        end
      end
    end
  end
end
