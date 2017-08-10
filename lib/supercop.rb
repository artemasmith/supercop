require 'active_support'
require 'active_support/core_ext'
require 'active_support/core_ext/hash/indifferent_access'

require 'supercop/version'
require 'supercop/configuration'
require 'supercop/checker'
require 'supercop/actions/create_file'
require 'supercop/actions/empty_folder'
require 'supercop/actions/dependency_load'

require 'supercop/railtie' if defined?(Rails)

module Supercop
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
