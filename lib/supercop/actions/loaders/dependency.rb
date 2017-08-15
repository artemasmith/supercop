module Supercop
  module Actions
    module Loaders
      class Dependency
        BUNDLE_REQUIRED = :bundle_required
        attr_reader :gem_list, :loader

        def initialize(loader = nil)
          @gem_list = Supercop.configuration.cops_settings.keys
          @loader = loader || Base
        end

        def perform
          new_gems_added? ? install : say_nothing_needed
        end

        private

        def new_gems_added?
          gem_list.any? { |gem_name| loader.new(gem_name).perform == BUNDLE_REQUIRED }
        end

        def install
          puts 'Updateing your bundle, please wait'
          `bundle update`
        end

        def say_nothing_needed
          puts 'No need to install anything.'
        end
      end
    end
  end
end
