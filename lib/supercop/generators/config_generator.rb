module Supercop
  module Generators
    class ConfigGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __dir__)

      puts '=> Creates a Supercop idefault config for your application.'

      def copy_config_file
        destination = 'config/supercop.yml'

        puts "=> Copy config file to #{destination}"

        copy_file 'supercop.yml', destination
      end
    end
  end
end
