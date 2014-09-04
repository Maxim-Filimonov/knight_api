module KnightApi
  class KnightResult

    def initialize(opts={})
      @paths = opts[:paths]
    end

    def self.success(paths: paths)
      result = KnightResult.new(paths: paths, valid: true)
    end

    def to_a
      paths.map { |path| path.moves.map(&:to_s) }
    end


    private
    attr_reader :paths
  end
end
