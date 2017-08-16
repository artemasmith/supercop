module Supercop
  class Checker
    attr_reader :linters, :printer, :config

    def initialize(printer = TableFormatter)
      @linters = Supercop.configuration.cops_settings.keys
      @config = Supercop.configuration
      @printer = printer
    end

    def perform
      cops = linters.map { |linter| handle_cops(parse_cop_config(linter)) }

      printer.new.print_table(cops)
    end

    private

    def handle_cops(warnings_actual:, warnings_max:, linter:)
      [linter,
       warnings_actual,
       warnings_max,
       linter_status(warnings_actual, warnings_max)]
    end

    def linter_status(actual, max)
      actual.to_i < max ? 'ok' : 'fail'
    end

    def actual_warnings_count(cop, linter)
      output = `#{linter} #{cop.fetch('options')}`

      # FYI: I didnt' find workaround: it doesn't work without variable
      count = JSON.parse(output)['summary']['offense_count']
    rescue => e
      if config.verbose
        puts %Q(Wrong configuration for linter, please check the path provided.
              Options: '#{cop.fetch('options')}'. Error: #{e.message})
      end

      'none'
    end

    def parse_cop_config(linter)
      return if linter.blank?
      cop = config.public_send(linter)

      { warnings_actual: actual_warnings_count(cop, linter),
        warnings_max: cop.fetch('max'),
        linter: linter }
    rescue => e
      puts "Problems with linter config load. #{e.message}" if config.verbose

      { warnings_actual: :none, warnings_max: :none, linter: linter }
    end
  end
end
