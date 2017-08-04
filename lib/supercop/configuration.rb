module Supercop
  class Configuration
    attr_accessor :cops_settings

    def initialize
      @cops_settings = YAML.load_file(config)
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configuration=(config)
      @configuration = config
    end

    def self.configure
      yield configuration
    end
  end
end
