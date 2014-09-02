require 'knight_api/knight'

describe KnightApi::Knight do
  describe '#routes_to' do
    it 'finds single route within one step' do
      subject = described_class.new(start: 'a1')

      routes = subject.routes_to('b3')

      expect(routes).to contain_exactly(['a1', 'b3'])
    end
  end
end
