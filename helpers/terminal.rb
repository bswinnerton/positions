class Terminal
  class Row
    class Element
      attr_accessor :color
      attr_reader :string

      def initialize(string, color:)
        @string = string
        @color  = color
      end

      def length
        @string.length
      end

      def to_s
        case color
        when :cyan
          "\e[36m#{@string}\e[0m"
        when :green
          "\e[32m#{@string}\e[0m"
        when :purple
          "\e[35m#{@string}\e[0m"
        when :red
          "\e[31m#{@string}\e[0m"
        end
      end
    end

    attr_accessor :elements

    def initialize
      @elements = []
    end

    def <<(string)
      @elements << string.to_s
    end

    def add_element(*opts)
      @elements << Element.new(*opts)
    end

    def add_newline
      @elements.freeze
    end

    def frozen?
      @elements.frozen?
    end

    def to_s
      @elements.join(' ')
    end
  end

  def initialize
    @rows = []
    @column_widths = Hash.new(0)
  end

  def row
    if @row && !@row.frozen?
      @row
    else
      @row = Terminal::Row.new.tap { |row| @rows << row }
    end
  end

  def to_s
    calculate_column_widths

    @rows.map do |row|
      row.elements.each_with_index.map do |element, index|
        padding = @column_widths[index] - element.length
        if padding != 0
          "#{element}#{' ' * padding}"
        else
          element
        end
      end.join('  ')
    end
  end

  private

  def calculate_column_widths
    @rows.map do |row|
      row.elements.each_with_index do |element, index|
        if element.length > @column_widths[index]
          @column_widths[index] = element.length
        end
      end
    end

    @column_widths
  end
end
