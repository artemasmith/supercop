module Supercop
  class Cop
    attr_reader :linter, :cop_config, :parser, :config

    def initialize(linter)
      @linter = linter
      @parser = Supercop::Parsers::Proxy
      @config = Supercop.configuration
      @cop_config = config.public_send(linter)
    end

    def handle
      result = parse_cop_config

      output = %i[linter warnings_actual warnings_max].map { |key| result[key] }
      output << linter_status(result[:warnings_actual], result[:warnings_max])
    end

    private

    def linter_status(actual, max)
      actual.to_i < max ? 'ok' : 'fail'
    end

    def actual_warnings_count
      output = `#{cop_config.fetch('cmd')} #{cop_config.fetch('options')}`

      parser.new(output, linter).parse.to_s
    end

    def parse_cop_config
      return if linter.blank?

      { warnings_actual: actual_warnings_count,
        warnings_max: cop_config.fetch('max'),
        linter: linter }
    rescue => e
      puts "Problems with linter config load. #{e.message}" if config.verbose

      { linter: linter, warnings_actual: 0, warnings_max: 0 }
    end
  end
end
