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

  def generate_for_rails
    puts 'Please, use rails generator instead!'
  end

  def generate_for_other
    puts 'Generate config for your supercop linters'

    destination = File.expand_path('../../', __dir__)

    puts Supercop::Actions::CreateFile.new(destination: destination).perform
  end

  def loader
    Supercop::Actions::Loaders::Dependency.new
  end
end
