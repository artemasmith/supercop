require 'supercop/version'
require 'supercop/configuration'
require 'supercop/checker'
require 'supercop/actions/create_file'
require 'supercop/actions/empty_folder'
require 'supercop/railtie' if defined?(Rails)

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
