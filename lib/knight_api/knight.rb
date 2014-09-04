require 'knight_api/path_finder'
require 'knight_api/knight_mover'
require 'knight_api/diagnostic'
require 'knight_api/knight_result'

module KnightApi
  class Knight
    include Diagnostic
    attr_reader :start_position, :destination_position, :knight_mover, :errors, :start

    def initialize(opts={})
      @knight_mover = KnightMover.new
      @start = opts[:start]
      @debug = opts[:debug]
      @errors = []
    end


    def routes_to(destination, opts={})
      @start_position = Point.from_s(start)
      @destination_position = Point.from_s(destination)
      validate(destination, opts)
      if valid?
        debug("Looking for path to #{destination_position} from #{start_position}")

        path_finder = PathFinder.new(initial_move: start_position,
                                     destination: destination_position,
                                     max_positions: opts.fetch(:max_positions, 6),
                                     mover: knight_mover,
                                     debug: @debug)

        valid_paths = path_finder.find_valid_paths
        debug("Found paths: #{valid_paths.map(&:to_s).join(",")}")
        KnightResult.success(paths: valid_paths)
      else
        debug("Invalid input #{errors.inspect}")
        KnightResult.fail(errors)
      end
    end

    def valid?
      errors.empty?
    end

    private
    def validate(destination, opts)
      errors << "invalid start coordinate #{start}" unless start_position
      errors << "invalid destination coordinate #{destination}" unless destination_position
    end
  end
end
