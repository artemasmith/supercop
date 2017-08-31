require 'supercop'

namespace :supercop do
  desc 'Create config file in your project, and load dependecies'
  task :generate_config do
    if defined?(Rails)
      generate_for_rails
    else
      generate_for_other
    end
  end

  desc 'Add missing dependencies to your Gemfile and run bundle install'
  task :load_dependencies do
    loader.load_dependencies
  end

  desc 'Clean up changes made by supercop: config, gems'
  task :cleanup do
    cleaner.call
  end

  def generate_for_rails
    puts 'Please, use rails generator instead!'
  end

  def generate_for_other
    puts 'Generate config for your supercop linters'

    destination = Dir.pwd

    puts Supercop::Actions::ConfigCopier.new(destination: destination).call
  end

  def loader
    Supercop::Actions::Loaders::Dependency.new
  end

  def cleaner
    Supercop::Actions::Clean
  end
end
