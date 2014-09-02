module KnightApi
  class Knight
    attr_reader :start_position
    POINT = Struct.new(:x, :y)
    def initialize(opts={})
      @start_position = translate_coordinate(opts[:start])
    end


    def routes_to(destination)
      destination_position = translate_coordinate(destination)
      debug("Looking for path to #{destination_position} from #{start_position}")

      possible_routes = []
      possible_routes << move_to(position: start_position, x: 1, y: 2)
      possible_routes << move_to(position: start_position, x: 2, y: 1)

      routes = possible_routes.select { |route| route.eql?(destination_position)}
      found_routes = [translate_coordinate_back(start_position)]
      routes.inject([]) { |sum, route|
        sum << [translate_coordinate_back(start_position), translate_coordinate_back(route)]
        sum
      }
    end

    private
    def debug(message)
      puts message if @debug
    end

    def move_to(opts={})
      position = opts.fetch(:position)
      x = opts.fetch(:x)
      y = opts.fetch(:y)
      point(x: position.x + x, y: position.y + y)
    end

    def point(coords)
      x_coords = ('a'..'h')
      y_coords = ('1'..'8')
      x = Coordinate.new(x_coords, coords.fetch(:x))
      y = Coordinate.new(y_coords, coords.fetch(:y))

      POINT.new(x, y)
    end

    def translate_coordinate(coordinate)
      translator = /(?<x>\w+)(?<y>\d+)/
      match = translator.match(coordinate)

      point(x: match[:x], y: match[:y])
    end

    def translate_coordinate_back(point)
      "#{point.x}#{point.y}"
    end
  end
end

class Coordinate
  attr_reader :range, :value
  def initialize(range, value)
    @range, @value = range.to_a, value
  end

  def +(new_value)
    index_of_current_value = range.index(value)
    index_of_new_value = index_of_current_value + new_value
    range[index_of_new_value]
  end

  def to_s
    value
  end

  def eql?(other)
    value == other.value
  end
end
