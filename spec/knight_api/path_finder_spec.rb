require 'knight_api/path_finder'

describe KnightApi::PathFinder do
  describe '#find_valid_paths' do
    let(:mover) { instance_double('KnightApi::Mover', possible_moves_from: []) }
    let(:pathfinder) { described_class.new(initial_move: 'initial', destination: 'dest', mover: mover) }
    it 'returns path with next move if it is destination' do
      allow(mover).to receive(:possible_moves_from).with('initial').and_return(['dest'])

      subject = pathfinder.find_valid_paths

      expect(subject.length).to eq(1)
      expect(subject.first).to be_valid
      expect(subject.first.moves).to contain_exactly('initial', 'dest')
    end

    context 'when next move is not destination' do
      it 'searches further' do
        allow(mover).to receive(:possible_moves_from).with('initial').and_return(['non_destination'])
        allow(mover).to receive(:possible_moves_from).with('non_destination').and_return(['dest'])

        subject = pathfinder.find_valid_paths

        expect(subject.length).to eq(1)
        expect(subject.first).to be_valid
        expect(subject.first.moves).to contain_exactly('initial', 'non_destination', 'dest')
      end

      it 'ignores path repeating itself' do
        allow(mover).to receive(:possible_moves_from).with('initial').and_return(['non_destination'], ['dest'])
        allow(mover).to receive(:possible_moves_from).with('non_destination').and_return(['initial'])

        subject = pathfinder.find_valid_paths

        expect(subject.length).to eq(0)
      end

      it 'does not allow path with number of moves the same as max positions' do
        allow(mover).to receive(:possible_moves_from).with('initial').and_return(['middle'])
        allow(mover).to receive(:possible_moves_from).with('middle').and_return(['dest'])
        pathfinder.max_positions = 2

        subject = pathfinder.find_valid_paths

        expect(subject.length).to eq(0)
      end
    end
  end
end
