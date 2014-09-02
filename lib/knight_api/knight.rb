module KnightApi
  class Knight
    attr_reader :start_position
    POINT = Struct.new(:x, :y)
    def initialize(opts={})
      @start_position = translate_coordinate(opts[:start])
    end


    def routes_to(destination)
      destination_position = translate_coordinate(destination)
      puts "Looking for path to #{destination_position} from #{start_position}"

      possible_routes = []
      possible_routes << point(x: start_position.x + 1, y: start_position.y + 2)
      possible_routes << point(x: start_position.x + 2, y: start_position.y + 1)

      routes = possible_routes.select { |route| route.eql?(destination_position)}
      found_routes = [translate_coordinate_back(start_position)]
      routes.inject([]) { |sum, route|
        sum << [translate_coordinate_back(start_position), translate_coordinate_back(route)]
        sum
      }
    end

    private
    def point(coords)
      POINT.new(coords.fetch(:x), coords.fetch(:y))
    end

    def translate_coordinate(coordinate)
      translator = /(?<x>\w+)(?<y>\d+)/
      match = translator.match(coordinate)
      x_coords = ('a'..'h').to_a
      x = x_coords.index(match[:x])

      point(x: x, y: match[:y].to_i)
    end

    def translate_coordinate_back(point)
      x_coords = ('a'..'h').to_a
      x = x_coords[point.x]
      "#{x}#{point.y}"
    end
  end
end
