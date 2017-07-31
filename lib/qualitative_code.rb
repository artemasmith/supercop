require 'qualitative_code/version'
require 'my_gem/railtie' if defined?(Rails)

module QualitativeCode
  class Checker
    require 'json'
    require 'yaml'

    MAX = 99

    attr_reader :cops_config

    def initialize(config = '.quality.yml')
      @cops_config = YAML.load_file(config)
    end

    def cops_everything
      cops_config['config'].each do |cop|
        handle_cops(parse_cop_config(cop))
      end
    end

    private

    def handle_cops(warnings_actual:, warnings_max:, linter:)
      if warnings_actual > warnings_max
        puts "количество предупреждений для '#{linter}' не должно превышать #{warnings_max} (сейчас #{warnings_actual})"
        exit(1)
      else
        puts "#{linter}: количество предупреждений - #{warnings_actual}/#{warnings_max}"
      end
    end

    def actual_warnings_count(cop)
      output = `#{cop.fetch('linter')} #{cop.fetch('options')}`

      count = JSON.parse(output)['summary']['offense_count']
    rescue => e
      puts "Wrong configuration for linter, please check the path provided. Options: '#{cop.fetch('options')}'. Error: #{e.message}"
      0
    end

    def parse_cop_config(cop)
      return unless cop.fetch('linter')

      { warnings_actual: actual_warnings_count(cop),
        warnings_max: cop.fetch('max'),
        linter: cop.fetch('linter') }
    end
  end
end
