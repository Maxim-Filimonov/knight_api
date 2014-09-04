require 'knight_api/knight_mover'

describe KnightApi::KnightMover do
  describe '#possible_moves_for' do
    it 'allows to move in 8 possible directions' do
      point = KnightApi::Point.from_coordinates(x:'e', y:'5')
      moves = subject.possible_moves_from(point)
      expect(moves.length).to eq(8)
    end

    it 'every direction allow to return back to original position' do
      point = KnightApi::Point.from_coordinates(x:'e', y:'5')
      moves = subject.possible_moves_from(point)

      moves.each do |move|
        possible_moves = subject.possible_moves_from(move)
        expect(possible_moves.map(&:to_s)).to include(point.to_s)
      end
    end
  end
end
