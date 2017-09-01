module Supercop
  module Actions
    module Loaders
      class Base
        BUNDLE_REQUIRED = :bundle_required

        attr_reader :gem_name, :config, :injector, :file

        def initialize(gem_name)
          @gem_name = gem_name
          @config = Supercop.configuration.public_send(gem_name)
          @injector = Supercop::Actions::FileInjector
          @file = Supercop.configuration.path('Gemfile')
        end

        def installed?
          load_gem
          true
        rescue LoadError
          false
        end

        def call
          add_gem

          puts "'#{gem_name}' was added as dependency.\n"
          BUNDLE_REQUIRED
        end

        private

        def load_gem
          require gem_name.to_s
        end

        def add_gem
          puts "Inserting into #{file} \n"
          puts "gem config #{gem_config}\n"

          injector.new(filename: file, line: gem_config).call
        end

        def gem_config
          result = ["gem '#{gem_name}'"]
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
end
