require 'knight_api/coordinate'
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

    def self.from_s(str)
      translator = /(?<x>\w+)(?<y>\d+)/
      match = translator.match(str)

      if match
        coords = { x: match[:x], y: match[:y] }
        from_coordinates(coords)
      end
    end

    def self.from_coordinates(coords)
      x_coords = ('a'..'h')
      y_coords = ('1'..'8')
      x = Coordinate.new(x_coords, coords.fetch(:x))
      y = Coordinate.new(y_coords, coords.fetch(:y))

      if x.valid? && y.valid?
        self.new(x, y)
      end
    end
  end
end
