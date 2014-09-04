require 'knight_api/knight_result'
require 'knight_api/path'

describe KnightApi::KnightResult do
  context 'failed result' do
    let(:errors) { [] }
    subject { described_class.fail(errors) }

    it 'is not valid' do
      expect(subject).to_not be_valid
    end

    it 'contains all error messages' do
      errors << 'bla'

      expect(subject.error_messages).to contain_exactly('bla')
    end
  end
  context 'successfull result' do
    let(:path) { KnightApi::Path.new }
    subject { described_class.success(paths: [path]) }

    it 'is valid' do
      expect(subject).to be_valid
    end

    describe '#to_a' do
      it 'returns all paths moves in array for each path' do
        path.add('a')
        path.add('b')
        path.add('c')

        expect(subject.to_a).to eq([['a','b','c']])
      end
    end

    describe '#to_s' do
      it 'returns all pathes as string repsentation in single array' do
        path.add('a')
        path.add('b')
        path.add('c')

        expect(subject.to_s).to eq("[\"a-b-c\"]")
      end
    end
  end
end
