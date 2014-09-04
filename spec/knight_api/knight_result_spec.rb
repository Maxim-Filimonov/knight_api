require 'knight_api/knight_result'
require 'knight_api/path'

describe KnightApi::KnightResult do
  context 'successfull result' do
    let(:path) { KnightApi::Path.new }
    subject { described_class.new(paths: [path]) }

    describe '#to_a' do
      it 'returns all paths moves in array for each path' do
        path.add('a')
        path.add('b')
        path.add('c')

        expect(subject.to_a).to eq([['a','b','c']])
      end
    end
  end
end
