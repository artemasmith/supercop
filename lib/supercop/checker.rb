require_relative 'table_formatter'

module Supercop
  class Checker
    require 'json'
    require 'yaml'

    MAX = 99

    attr_reader :cops_config, :linters

    def initialize(printer = TableFormatter)
      @cops_config = Supercop.configuration.cops_settings
      @linters = Supercop.configuration.cops_settings.keys
      @printer = printer
    end

    def cops_everything
      cops = linters.map { |linter| handle_cops(parse_cop_config(Supercop.configuration.public_send(linter), linter))}

      @printer.new.print_table(cops)
    end

    private

    def handle_cops(warnings_actual:, warnings_max:, linter:)
      [linter, warnings_actual, warnings_max, linter_status(warnings_actual, warnings_max)]
    end

    def linter_status(actual, max)
      actual.to_i < max ? 'ok' : 'fail'
    end

    def actual_warnings_count(cop, linter)
      output = `#{linter} #{cop.fetch('options')}`

      count = JSON.parse(output)['summary']['offense_count']
    rescue => e
      puts %Q(Wrong configuration for linter, please check the path provided.
              Options: '#{cop.fetch('options')}'. Error: #{e.message}) if Supercop.configuration.verbose
      'none'
    end

    def parse_cop_config(cop, linter)
      return if linter.blank?

      { warnings_actual: actual_warnings_count(cop, linter),
        warnings_max: cop.fetch('max'),
        linter: linter }
    end
  end
end
