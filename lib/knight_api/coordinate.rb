module KnightApi
  class Coordinate
    attr_reader :range, :value

    def initialize(range, value)
      @range, @value = range.to_a, value
    end

    def +(new_value)
      index_of_current_value = range.index(value)
      index_of_new_value = index_of_current_value + new_value
      range[index_of_new_value] if index_of_new_value >= 0
    end

    def to_s
      value
    end

    def eql?(other)
      value == other.value
    end

    def valid?
      !range.index(value).nil?
    end
  end
end
