require 'knight_api/point'
require 'knight_api/coordinate'
require 'knight_api/path'
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

      possible_moves = possible_moves_from(start_position)

      found_moves = []
      possible_moves.each {|move|
        valid_patches = []
        path = Path.new
        result = handle_tree(valid_patches: valid_patches, path: path, move: move, destination_position: destination_position, limit: opts[:limit])
        valid_patches.each do |path|
          debug("Valid path - #{path}, #{path}")
          found_moves << path.moves
        end
      }
      found_moves.inject([]) { |sum, moves|
        sum << [translate_coordinate_back(start_position), moves.map {|m| translate_coordinate_back(m)}].flatten
        sum
      }
    end

    private
    def handle_tree(opts={})
      limit = opts[:limit] || 6
      path = opts.fetch(:path)
      move = opts.fetch(:move)
      destination_position = opts.fetch(:destination_position)
      valid_patches = opts.fetch(:valid_patches)
      return nil if path.moves.length >= limit
      path.add(move)
      debug("Checking path #{path} for #{move}, level: #{path.moves.length}, limit: #{limit}")
      if(move.eql?(destination_position))
        path.valid = true
        debug("Found valid path #{path}")
        valid_patches << path
      else
        possible_moves = possible_moves_from(move)
        possible_moves.map { |possible_move|
          child_path = Path.new(path)
          handle_tree(valid_patches: valid_patches, path: child_path, move: possible_move, destination_position: destination_position,  limit: limit)
        }
      end
    end


    def possible_moves_from(position)
      possible_moves = []
      [{x: 1, y: 2}, {x: 2, y: 1}, {x: 2, y: -1}, { x: -1, y: 2}, { x: 1, y: -2}].each do |direction|
        new_position = move_to({position: position}.merge(direction))
        possible_moves << new_position if new_position
      end
      possible_moves
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


