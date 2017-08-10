module Supercop
  class Configuration
    attr_accessor :cops_settings, :verbose, :file_path

    def initialize
      @cops_settings = config_file.fetch(:config)
      @verbose = config_file.fetch(:verbose)
      @file_path = config_path
    end

    private

    def config_file
      @_config_file ||= YAML.load_file(config_path).with_indifferent_access
    rescue => e
      puts "Can't find or read config file, did you run initialize command? #{e.message}"
    end

    def config_path
      @_config_path ||= defined?(Rails) ? rails_path : other_path
    end

    def rails_path
      Rails.root.join('config', 'supercop.yml')
    end

    def other_path
      File.join(Dir.pwd, 'supercop.yml')
    end

    def method_missing(m, *args, &block)
      cops_settings.dig(m) || super
    end

    # https://robots.thoughtbot.com/always-define-respond-to-missing-when-overriding
    def respond_to_missing?(method_name, include_private = false)
      cops_settings.keys.include?(method_name) || super
    end
  end
end
