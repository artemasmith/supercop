module Supercop
  module Generators
    class ConfigGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __dir__)

      puts '=> Creates a Supercop idefault config for your application.'

      def copy_config_file
        puts '=> Copy config file to config/supercop.yml'
        copy_file 'supercop.yml', 'config/supercop.yml'
      end

      def load_dependencies
        Supercop::Actions::Loaders::Dependency.new.perform
      end
    end
  end
end
