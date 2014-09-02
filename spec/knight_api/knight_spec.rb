require 'knight_api/knight'

describe KnightApi::Knight do
  describe '#routes_to' do
    it 'finds single route within one step' do
      subject = described_class.new(start: 'a1')

      routes = subject.routes_to('b3', limit: 1)

      expect(routes).to contain_exactly(['a1', 'b3'])
    end

    it 'finds single route within two steps' do
      subject = described_class.new(start: 'a1')

      routes = subject.routes_to('e1', limit: 2)

      expect(routes).to contain_exactly(['a1', 'c2', 'e1'])
    end

    it 'finds multiple routes within two steps' do
      subject = described_class.new(start: 'a1')

      routes = subject.routes_to('d4', limit: 2)

      expect(routes).to contain_exactly(['a1', 'b3', 'd4'], ['a1', 'c2', 'd4'])
    end

    it 'finds multiple routes within three steps' do
      subject = described_class.new(start: 'a1', debug: true)

      routes = subject.routes_to('d3', limit: 3)

      expect(routes).to contain_exactly(
      ['a1', 'b3', 'c5', 'd3'],
      ['a1', 'c2', 'e1','d3'],
      ['a1', 'b3', 'c1', 'd3'],
      ['a1', 'c2', 'b4', 'd3'])
    end
  end
end
