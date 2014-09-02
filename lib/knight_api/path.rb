module KnightApi
  class Path
    attr_reader :moves
    def initialize(parent_path = nil)
      @moves = []
      @valid = false
      if parent_path
        @moves.concat(parent_path.moves)
      end
    end

    def add(move)
      @moves << move
    end

    def to_s
      @moves.join(' - ')
    end

    def valid?
      @valid
    end

    def valid=(value)
      @valid = value
    end

    def contains?(move)
      moves.include?(move)
    end

    def number_of_moves
      moves.length
    end
  end
end
