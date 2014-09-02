module KnightApi
  module Diagnostic
    def debug(message)
      puts message if @debug
    end
  end
end
