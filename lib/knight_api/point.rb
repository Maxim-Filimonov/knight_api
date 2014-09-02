module KnightApi
  class Point < Struct.new(:x, :y)
    def to_s
      [x,y].join("")
    end
  end
end
