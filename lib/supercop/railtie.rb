module Supercop
  # FYI: Here we defined rake tasks and generators for Rails use
  require 'rails/railtie'
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load 'tasks/config_generator.rake'
    end

    generators do
      require_relative 'generators/config_generator'
    end
  end
end
