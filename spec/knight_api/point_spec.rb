require 'knight_api/point'

describe KnightApi::Point do
  describe '#to_s' do
    it 'returns x, y together' do
      subject = described_class.new(:foo, :bar)

      expect(subject.to_s).to eq('foobar')
    end
  end

  describe 'equality' do
    context 'when x and y are the same' do
      it 'eql? to other when x and y are the same' do
        other = described_class.new(0,1)
        subject = described_class.new(0,1)

        expect(subject.eql?(other)).to eq(true)
      end

      it '== to other' do
        other = described_class.new(0,1)
        subject = described_class.new(0,1)

        expect(subject == other).to eq(true)
      end
    end
  end
end
