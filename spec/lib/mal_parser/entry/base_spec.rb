describe MalParser::Entry::Base do
  let(:parser) { described_class.new id }

  describe '#call', :vcr do
    before { allow(parser).to receive(:type).and_return type }
    subject! { parser.call }

    context 'anime' do
      let(:type) { :anime }
      let(:id) { 1 }

      it do
        is_expected.to eq(
          id:,
          name: 'Cowboy Bebop',
          image: 'https://cdn.myanimelist.net/images/anime/4/19644.jpg'
        )
      end
    end

    context 'manga' do
      let(:type) { :manga }
      let(:id) { 1 }

      it do
        is_expected.to eq(
          id:,
          name: 'Monster',
          image: 'https://cdn.myanimelist.net/images/manga/3/258224.jpg'
        )
      end
    end

    context 'character' do
      let(:type) { :character }
      let(:id) { 1 }

      it do
        is_expected.to eq(
          id:,
          name: 'Spike Spiegel',
          image: 'https://cdn.myanimelist.net/images/characters/11/516853.jpg'
        )
      end
    end

    context 'person' do
      let(:type) { :people }
      let(:id) { 1 }

      it do
        is_expected.to eq(
          id:,
          name: 'Tomokazu Seki',
          image: 'https://cdn.myanimelist.net/images/voiceactors/1/55486.jpg'
        )
      end
    end
  end
end
