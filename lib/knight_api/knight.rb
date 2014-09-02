require 'knight_api/point'
require 'knight_api/coordinate'
require 'knight_api/path'
require 'knight_api/path_finder'
require 'knight_api/knight_mover'
require 'knight_api/diagnostic'

module KnightApi
  class Knight
    include Diagnostic
    attr_reader :start_position
    def initialize(opts={})
      @start_position = translate_coordinate(opts[:start])
      @debug = opts[:debug]
    end


    def routes_to(destination, opts={})
      destination_position = translate_coordinate(destination)
      debug("Looking for path to #{destination_position} from #{start_position}")

      knight_mover = KnightMover.new
      # possible_moves = knight_mover.possible_moves_from(start_position)
      path_finder = PathFinder.new(initial_move: start_position,
                                   destination: destination_position,
                                   max_moves: opts.fetch(:limit, 6),
                                   mover: knight_mover,
                                   debug: @debug)
      valid_paths = path_finder.find_valid_paths
      found_moves = []
      valid_paths.each do |path|
        found_moves << path.moves
      end
      result = found_moves.inject([]) { |sum, moves|
        sum << [moves.map {|m| translate_coordinate_back(m)}].flatten
        sum
      }
      result

    end

    def point(coords)
      x_coords = ('a'..'h')
      y_coords = ('1'..'8')
      x = Coordinate.new(x_coords, coords.fetch(:x))
      y = Coordinate.new(y_coords, coords.fetch(:y))

      if x.valid? && y.valid?
        Point.new(x, y)
      else
        nil
      end
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
