require 'knight_api/point'

describe KnightApi::Point do
  describe '#to_s' do
    it 'returns x, y together' do
      subject = described_class.new(:foo, :bar)

      expect(subject.to_s).to eq('foobar')
    end
  end
end
