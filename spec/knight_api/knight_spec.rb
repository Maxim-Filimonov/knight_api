require 'knight_api/knight'

describe KnightApi::Knight do
  describe '#initialize' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end
  describe '#routes_to' do
    it 'finds single route within one step' do
      subject = described_class.new(start: 'a1')

      routes = subject.routes_to('b3', max_positions: 2).to_a

      expect(routes).to contain_exactly(%w(a1 b3))
    end

    it 'finds single route within two steps' do
      subject = described_class.new(start: 'a1')

      routes = subject.routes_to('e1', max_positions: 3).to_a

      expect(routes).to contain_exactly(%w(a1 c2 e1))
    end

    it 'finds multiple routes within two steps' do
      subject = described_class.new(start: 'a1')

      routes = subject.routes_to('d4', max_positions: 3).to_a

      expect(routes).to contain_exactly(%w(a1 b3 d4), %w(a1 c2 d4))
    end

    it 'finds multiple routes within three steps' do
      subject = described_class.new(start: 'a1')

      routes = subject.routes_to('d3', max_positions: 4).to_a

      expect(routes).to contain_exactly(
      %w(a1 b3 c5 d3),
      %w(a1 c2 e1 d3),
      %w(a1 b3 c1 d3),
      %w(a1 c2 b4 d3))
    end

    it 'finds the example routes' do
      subject = described_class.new(start: 'a1')

      routes = subject.routes_to('d4', max_positions: 6).to_a

      expect(routes).to contain_exactly(
                          %w(a1 b3 d4),
                          %w(a1 c2 d4),
                          %w(a1 c2 e3 f5 d4),
                          %w(a1 c2 a3 b5 d4),
                          %w(a1 c2 b4 c6 d4),
                          %w(a1 c2 e1 f3 d4),
                          %w(a1 b3 d2 f3 d4),
                          %w(a1 b3 c1 e2 d4),
                          %w(a1 b3 a5 c6 d4),
                          %w(a1 b3 c5 e6 d4)
                        )
    end

    it 'sorts routes by they length' do
      subject = described_class.new(start: 'a1')

      routes = subject.routes_to('d4', max_positions: 6).to_a
      result_order = routes.map(&:length)

      expect(result_order).to eq(result_order.sort)
    end

    context 'when trying to break the knight' do
      it 'returns fail when start is not defined' do
        subject = described_class.new(start: 'bogus')

        result = subject.routes_to('d4')

        expect(result).to_not be_valid
        expect(result.error_messages.first).to include('start')
      end

      it 'returns fail when destination is not defined' do
        subject = described_class.new(start: 'a1')

        result = subject.routes_to('bogus')

        expect(result).to_not be_valid
        expect(result.error_messages.first).to include('destination')
      end

      it 'returns fail when start and destination are the same' do
        subject = described_class.new(start: 'a1')

        result = subject.routes_to('a1')

        expect(result).to_not be_valid
        expect(result.error_messages.first).to include('repeated')
      end
    end
  end
end
