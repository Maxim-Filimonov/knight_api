module KnightApi
  class KnightMover
    def possible_moves_from(position)
      possible_moves = []
      [{x: 1, y: 2}, {x: 2, y: 1}, {x: 2, y: -1}, { x: -1, y: 2}, { x: 1, y: -2}, {x: -2, y: 1}, {x: -1, y: -2}, {x: -2, y: -1}].each do |direction|
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
  end
end
