module KnightApi
  class KnightResult

    attr_reader :error_messages
    def initialize(opts={})
      @paths = opts[:paths] || []
      @valid = opts[:valid]
      @error_messages = opts[:error_messages] || []
    end

    def self.success(paths: paths)
      result = KnightResult.new(paths: paths, valid: true)
    end

    def self.fail(error_messages)
      result = KnightResult.new(error_messages: error_messages, valid: false)
    end

    def to_a
      paths.map { |path| path.moves.map(&:to_s) }
    end

    def to_s
      paths.map(&:to_s).to_s
    end

    def valid?
      @valid
    end

    private
    attr_reader :paths
  end
end
