require 'knight_api/knight'
module KnightApi
  class Runner
    def run(opts={})
      knight = Knight.new(start: opts.fetch(:start))
      result = knight.routes_to(opts.fetch(:destination), max_positions: opts.fetch(:max_limit))
      if result.valid?
        result.to_s
      else
        result.error_messages.join(", ")
      end
    end

    private
  end
end
