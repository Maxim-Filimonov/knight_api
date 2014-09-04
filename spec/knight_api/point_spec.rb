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

  describe '.from_s' do
    context 'when coordinates are valid' do
      it 'returns point with coords set' do
        subject = described_class.from_s('a1')

        expect(subject.x.value).to eq('a')
        expect(subject.y.value).to eq('1')
      end
    end
    context 'when coordinates are not valid' do
      it 'returns no point' do
        subject = described_class.from_s('not_valid')

        expect(subject).to be_nil
      end
    end
    context 'when coordinate is out of border' do
      it 'returns no point' do
        subject = described_class.from_s('a20')

        expect(subject).to be_nil
      end
    end
  end

  describe '.from_coordinates' do
    context 'when coordinates are valid' do
      it 'returns point with coords set' do
        subject = described_class.from_coordinates(x: 'a', y: '1')

        expect(subject.x.value).to eq('a')
        expect(subject.y.value).to eq('1')
      end
    end
    context 'when coordinates are not valid' do
      it 'returns no point' do
        subject = described_class.from_coordinates(x: 'y', y: '42')

        expect(subject).to be_nil
      end
    end
  end
end
