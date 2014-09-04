require 'knight_api/point'

module KnightApi
  class KnightMover
    KNIGHT_MOVES = [
      {x: 1, y: 2},
      {x: 1, y: -2},
      {x: 2, y: -1},
      {x: 2, y: 1},
      {x: -1, y: 2},
      {x: -1, y: -2},
      {x: -2, y: 1},
      {x: -2, y: -1}
    ]

    def possible_moves_from(position)
      possible_moves = []
      KNIGHT_MOVES.each do |direction|
        new_position = move_to({position: position}.merge(direction))
        possible_moves << new_position if new_position
      end
      possible_moves
    end

    private
    def move_to(opts={})
      position = opts.fetch(:position)
      x = opts.fetch(:x)
      y = opts.fetch(:y)
      Point.from_coordinates(x: position.x + x, y: position.y + y)
    end

  end
end
