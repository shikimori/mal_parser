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
            id: 20707,
            name: '"0"',
            type: :anime
          )
        end
      end

      context 'manga' do
        let(:type) { 'manga' }

        it do
          is_expected.to have(MalParser::Catalog::Page::ENTRIES_PER_PAGE).items
          expect(results.first).to eq(
            id: 62783,
            name: '',
            type: :manga
          )
        end
      end
    end

    describe 'page' do
      let(:page) { 20 }

      it do
        is_expected.to have(MalParser::Catalog::Page::ENTRIES_PER_PAGE).items
        expect(results.first).to eq(
          id: 30152,
          name: 'au x Rope',
          type: :anime
        )
      end
    end

    describe 'sorting' do
      let(:sorting) { :updated_at }

      it do
        is_expected.to have(MalParser::Catalog::Page::ENTRIES_PER_PAGE).items
        expect(results.first).to eq(
          id: 42896,
          name: 'Mou Ii Kai',
          type: :anime
        )
      end
    end
  end
end
