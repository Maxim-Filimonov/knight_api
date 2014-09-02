require 'knight_api/coordinate'

describe KnightApi::Coordinate do
  describe '#initialize' do
    it 'can be initialized with range' do
      subject = described_class.new(1..5, 2)

      expect(subject.range).to eq([1,2,3,4,5])
    end
  end

  describe '#+' do
    subject { described_class.new(%w(a b c), 'a') }

    it 'uses supplied value to determine next index' do
      result = subject + 1
      expect(result).to eq('b')
    end

    it 'returns nil if value it goes over index' do
      result = subject + 100
      expect(result).to be_nil
    end

    it 'returns nil if value is less then zero' do
      result = subject + (-2)

      expect(result).to be_nil
    end
  end

  describe '#eql?' do
    it 'returns true when other coordinate has the same value' do
      other = described_class.new([], 'a')
      subject = described_class.new(['a'], 'a')

      expect(subject).to eql(other)
    end

    it 'return false when other coordinate has different value' do
      other = described_class.new([], 'b')
      subject = described_class.new(['a'], 'a')

      expect(subject).to_not eql(other)
    end
  end

  describe '#valid?' do
    it 'returns false when value is not in range' do
      subject = described_class.new([], 'a')

      expect(subject).to_not be_valid
    end

    it 'returns true when value is in range' do
      subject = described_class.new(['a'], 'a')

      expect(subject).to be_valid
    end
  end
end
