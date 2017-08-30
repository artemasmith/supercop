module Supercop
  module Actions
    module Loaders
      class Dependency
        BUNDLE_REQUIRED = :bundle_required
        START_COMMENT   = "####### SUPERCOP #######\n".freeze
        END_COMMENT     = "#### ENDOF SUPERCOP ####\n".freeze

        attr_reader :gem_list, :loader, :file_injector

        def initialize(loader = nil)
          @gem_list = Supercop.configuration.cops_settings.keys
          @loader = loader || Base
          @file_injector = Supercop::Actions::FileInjector
        end

        def call
          puts 'Loading dependecies, please wait..'

          if gems_to_add.empty?
            say_nothing_needed
          else
            wrap_for_gemfile do
              gems_to_add.each { |gem_name| loader.new(gem_name).call }
            end

            install
          end
        end

        alias load_dependencies call

        private

        def gems_to_add
          res = gem_list.select { |gem_name| !loaded?(gem_name) }
          puts "#{gem_list} ALL GEMS = #{res}\n"
          res
        end

        def loaded?(gem_name)
          res = loader.new(gem_name).installed? ? true : false
          puts "LOADED #{gem_name} #{res}\n"
          res
        end

        def install
          puts 'Updating your bundle, please wait'
          `bundle install`
        rescue => e
          error = 'Something goes wrong while installing your bundle' \
                  "Please try to install in manually\n #{e}"
          puts error
        end

        def say_nothing_needed
          puts 'No need to install anything.'
        end

        def wrap_for_gemfile(&_block)
          file = Supercop.configuration.path('Gemfile')
          file_injector.new(filename: file, line: START_COMMENT).call

          yield

          file_injector.new(filename: file, line: END_COMMENT).call
        end
      end
    end
  end
end
