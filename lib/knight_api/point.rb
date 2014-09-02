module KnightApi
  class Point
    attr_reader :x,:y
    def initialize(x, y)
      @x, @y = x,y
    end

    def eql?(other)
      self.x == other.x && self.y == other.y
    end

    def ==(other)
      eql?(other)
    end

    def to_s
      [x,y].join("")
    end
  end
end
