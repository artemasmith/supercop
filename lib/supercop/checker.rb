module Supercop
  class Checker
    attr_reader :linters, :printer, :cop
    def initialize(printer = TableFormatter)
      @linters = Supercop.configuration.cops_settings.keys
      @printer = printer
      @cop = Cop
    end

    def call
      checks_result = linters.map { |linter| cop.new(linter).handle }

      printer.new.print_table(checks_result)
    end
  end
end
