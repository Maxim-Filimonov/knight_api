require 'knight_api/runner'

describe KnightApi::Runner do
  describe '#run' do
    it 'outputs paths in required format format' do
      result = subject.run(start: 'a1', destination: 'd4', max_limit: 3)

      expect(result).to eq("[\"a1-b3-d4\", \"a1-c2-d4\"]")
    end

    it 'returns error when input is invalid' do
      result = subject.run(start: 'x', destination: 'y', max_limit: 0)

      expect(result).to include("invalid")
    end

    it 'can be run without limit' do
      expect{ subject.run(start: 'x', destination: 'y') }.to_not raise_error
    end
  end
end
