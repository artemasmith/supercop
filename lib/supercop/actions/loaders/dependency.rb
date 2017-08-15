module Supercop
  module Actions
    module Loaders
      class Dependency
        attr_reader :gem_list, :loader

        def initialize(loader = nil)
          @gem_list = Supercop.configuration.cops_settings.keys
          @loader = loader || Base
        end

        def perform
          gem_list.each { |gem_name| loader.new(gem_name).perform }

          install
        end

        private

        def install
          `bundle install`
        end
      end
    end
  end
end
