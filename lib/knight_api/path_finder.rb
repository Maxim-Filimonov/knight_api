require 'knight_api/path'
require 'knight_api/diagnostic'
module KnightApi
  class PathFinder
    include Diagnostic
    attr_reader :valid_paths, :initial_move, :destination, :mover
    attr_accessor :max_positions
    def initialize(opts={})
      @initial_move = opts.fetch(:initial_move)
      @destination = opts.fetch(:destination)
      @mover = opts.fetch(:mover)
      @valid_paths = []
      @max_positions = opts[:max_positions]
      @debug = opts[:debug]
    end

    def find_valid_paths
      path = Path.new
      path.add(initial_move)

      check_possible_moves(path, initial_move)

      valid_paths.sort_by { |p| p.number_of_moves }
    end

    private
    def check_path(path, next_move)
      if non_recursive_path?(path, next_move) && under_max_positions_limit?(path)
        path.add(next_move)
        debug("Checking path #{path}")
        if next_move.eql?(destination)
          path.valid = true
          debug("Found valid path #{path}")
          valid_paths << path
        else
          check_possible_moves(path, next_move)
        end
      end
    end

    def non_recursive_path?(path, next_move)
      debug "#{path} contains #{next_move}"
      not path.contains?(next_move)
    end

    def under_max_positions_limit?(path)
      if (max_positions || 0) > 0
        path.number_of_moves < max_positions
      else
        true
      end
    end

    def check_possible_moves(path, next_move)
      moves = mover.possible_moves_from(next_move)
      moves.each do |possible_move|
        child_path = Path.new(path)
        check_path(child_path, possible_move)
      end
    end
  end
end
