require 'knight_api/path'

describe KnightApi::Path do
  describe '#initialize' do
    context 'when parent path is not supplied' do
      it 'has no moves' do
        subject = described_class.new

        expect(subject.moves).to be_empty
      end
    end
    context 'when parent path supplied' do
      it 'uses it moves as start' do
        parent_path = described_class.new
        parent_path.add('move1')

        subject = described_class.new(parent_path)

       expect(subject.moves).to contain_exactly('move1')
      end
    end
  end

  describe '#to_s' do
    it 'returns all the moves chained' do
      subject = described_class.new
      subject.add('move1')
      subject.add('move2')
      subject.add('move3')

      expect(subject.to_s).to eq('move1-move2-move3')
    end
  end

  describe '#contains' do
    it 'returns true when move is in the list of moves' do
      subject = described_class.new
      subject.add('move1')

      expect(subject.contains?('move1')).to eq(true)
    end

    it 'returns false when move is not in the list of moves' do
      subject = described_class.new
      subject.add('move1')

      expect(subject.contains?('not a move')).to eq(false)
    end
  end

  describe '#number_of_moves' do
    it 'returns 0 when there is no moves' do
      expect(subject.number_of_moves).to eq(0)
    end

    it 'returns number of moves in path' do
      subject = described_class.new

      subject.add('move1')

      expect(subject.number_of_moves).to eq(1)
    end
  end
end
