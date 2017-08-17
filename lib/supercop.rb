require 'active_support'
require 'active_support/core_ext'
require 'active_support/core_ext/hash/indifferent_access'

require 'supercop/version'
require 'supercop/checker'
require 'supercop/project'
require 'supercop/configuration'
require 'supercop/table_formatter'
require 'supercop/actions/file_creator'
require 'supercop/actions/file_injector'
require 'supercop/actions/loaders/base'
require 'supercop/actions/loaders/dependency'
require 'supercop/parsers/base'
require 'supercop/parsers/proxy'
require 'supercop/parsers/scss_lint'
require 'supercop/parsers/rubocop'

require 'json'
require 'yaml'

if defined?(Rails)
  require 'supercop/railtie'
  require 'rails/generators'
end

module Supercop
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
