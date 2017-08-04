class CopsConfigGenerator < Rails::Generators::Base
  desc 'It creates initializer file for supercop gem'
  def create_initializer_file
    default_config = YAML.load_file('../.config.yml')
    create_file 'config/initializer/supercop.rb', YAML.load_file('../.config.yml')
  end
end
