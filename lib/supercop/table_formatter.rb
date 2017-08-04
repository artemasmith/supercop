module Supercop
  class TableFormatter
    CELL_WIDTH = 20
    DEFAULT_COLUMNS = %w[linter alerts max status].freeze

    def initialize(columns = nil)
      @columns = columns || DEFAULT_COLUMNS
    end

    def print_table(lines)
      puts header

      lines.each { |elements| puts line(elements) }

      puts footer
    end

    private

    def header
      dash_line + "\n" + line(@columns) + "\n" + dash_line
    end

    def dash_line
      line = '+'
      @columns.count.times { line += Array.new(CELL_WIDTH, '-').join + '+' }
      line
    end

    def footer
      dash_line
    end

    def line(elements)
      '|' + elements.map { |element| cell(element.to_s) }.join
    end

    def cell(word)
      word.center(word.length + (CELL_WIDTH - word.length).abs) + '|'
    end
  end
end
