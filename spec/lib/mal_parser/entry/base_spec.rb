describe MalParser::Entry::Base do
  let(:parser) { MalParser::Entry::Base.new id }

  describe '#call', :vcr do
    before { allow(parser).to receive(:type).and_return type }
    subject! { parser.call }

    context 'anime' do
      let(:type) { :anime }
      let(:id) { 1 }

      it do
        is_expected.to eq(
          id: id,
          name: 'Cowboy Bebop',
          image: 'https://myanimelist.cdn-dena.com/images/anime/4/19644.jpg'
        )
      end
    end

    context 'manga' do
      let(:type) { :manga }
      let(:id) { 1 }

      it do
        is_expected.to eq(
          id: id,
          name: 'Monster',
          image: 'https://myanimelist.cdn-dena.com/images/manga/3/54525.jpg'
        )
      end
    end

    context 'character' do
      let(:type) { :character }
      let(:id) { 1 }

      it do
        is_expected.to eq(
          id: id,
          name: 'Spike Spiegel',
          image: 'https://myanimelist.cdn-dena.com/images/characters/4/50197.jpg'
        )
      end
    end

    context 'person' do
      let(:type) { :people }
      let(:id) { 1 }

      it do
        is_expected.to eq(
          id: id,
          name: 'Tomokazu Seki',
          image: 'https://myanimelist.cdn-dena.com/images/voiceactors/3/44649.jpg'
        )
      end
    end
  end
end
