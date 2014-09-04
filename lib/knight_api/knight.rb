require 'knight_api/path_finder'
require 'knight_api/knight_mover'
require 'knight_api/diagnostic'
require 'knight_api/knight_result'

module KnightApi
  class Knight
    include Diagnostic
    attr_reader :start_position, :knight_mover

    def initialize(opts={})
      @knight_mover = KnightMover.new
      @start_position = translate_coordinate(opts[:start])
      @debug = opts[:debug]
    end


    def routes_to(destination, opts={})
      destination_position = translate_coordinate(destination)
      debug("Looking for path to #{destination_position} from #{start_position}")

      path_finder = PathFinder.new(initial_move: start_position,
                                   destination: destination_position,
                                   max_positions: opts.fetch(:max_positions, 6),
                                   mover: knight_mover,
                                   debug: @debug)

      valid_paths = path_finder.find_valid_paths
      debug("Found paths: #{valid_paths.map(&:to_s).join(",")}")
      KnightResult.success(paths: valid_paths)
    end


    end
  end
end
