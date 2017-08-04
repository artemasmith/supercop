require 'supercop/version'
require 'supercop/configuration'
require 'supercop/checker'
require 'generators/cops_config_generator'
require 'my_gem/railtie' if defined?(Rails)

module QualitativeCode
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
