require 'supercop'

desc 'Create config file in your project'
namespace :supercop do
  task :generate_config do
    if defined?(Rails)
      generate_for_rails
    else
      generate_for_other
    end
  end

  def generate_for_rails
    puts 'Please, use rails generator instead!'
  end

  def generate_for_other
    puts 'Generate config for your supercop linters'

    destination = File.expand_path('../../', __dir__)

    puts Supercop::Actions::CreateFile.new(destination: destination).perform
  end
end
