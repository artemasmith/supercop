require_relative 'table_formatter'

module Supercop
  class Checker
    require 'json'
    require 'yaml'

    MAX = 99

    attr_reader :cops_config

    def initialize(config = '.quality.yml', printer = TableFormatter)
      @cops_config = YAML.load_file(config)
      @cops_config[:verbose] ||= false
      @printer = printer
    end

    def cops_everything
      cops = cops_config['config'].map { |cop| handle_cops(parse_cop_config(cop)) }

      @printer.new.print_table(cops)
    end

    private

    def handle_cops(warnings_actual:, warnings_max:, linter:)
      [linter, warnings_actual, warnings_max, linter_status(warnings_actual, warnings_max)]
    end

    def linter_status(actual, max)
      actual.to_i < max ? 'ok' : 'fail'
    end

    def actual_warnings_count(cop)
      output = `#{cop.fetch('linter')} #{cop.fetch('options')}`

      count = JSON.parse(output)['summary']['offense_count']
    rescue => e
      puts %Q(Wrong configuration for linter, please check the path provided.
              Options: '#{cop.fetch('options')}'. Error: #{e.message}) if cops_config[:verbose]
      'none'
    end

    def parse_cop_config(cop)
      return unless cop.fetch('linter')

      { warnings_actual: actual_warnings_count(cop),
        warnings_max: cop.fetch('max'),
        linter: cop.fetch('linter') }
    end
  end
end
