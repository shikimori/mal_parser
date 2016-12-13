describe MalParser::Catalog::Page do
  let(:parser) do
    MalParser::Catalog::Page.new(
      type: type,
      page: page,
      sorting: sorting
    )
  end

  let(:type) { 'anime' }
  let(:page) { 0 }
  let(:sorting) { 'name' }

  describe '#call', :vcr do
    subject!(:results) { parser.call }

    describe 'type' do
      context 'anime' do
        let(:type) { 'anime' }

        it do
          is_expected.to have(MalParser::Catalog::Page::ENTRIES_PER_PAGE).items
          expect(results.first).to eq(
            id: 20_707,
            name: '"0"'
          )
        end
      end

      context 'manga' do
        let(:type) { 'manga' }

        it do
          is_expected.to have(MalParser::Catalog::Page::ENTRIES_PER_PAGE).items
          expect(results.first).to eq(
            id: 85_868,
            name: '!'
          )
        end
      end
    end

    describe 'page' do
      let(:page) { 20 }

      it do
        is_expected.to have(MalParser::Catalog::Page::ENTRIES_PER_PAGE).items
        expect(results.first).to eq(
          id: 5624,
          name: 'Biohazard 4D-Executer',
          url: 'https://myanimelist.net/anime/5624/Biohazard_4D-Executer'
        )
      end
    end

    describe 'sorting' do
      let(:sorting) { :updated_at }

      it do
        is_expected.to have(MalParser::Catalog::Page::ENTRIES_PER_PAGE).items
        expect(results.first).to eq(
          id: 34_514,
          name: 'Pokemon Generations',
          url: 'https://myanimelist.net/anime/34514/Pokemon_Generations'
        )
      end
    end
  end
end
