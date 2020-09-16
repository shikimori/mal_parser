describe MalParser::Entry::Characters do
  let(:parser) { MalParser::Entry::Characters.new id, type }
  let(:type) { :anime }

  describe '#call', :vcr do
    subject(:characters) { parser.call }

    context 'anime' do
      let(:id) { 32_948 }
      it do
        expect(characters).to have(2).items
        expect(characters[:characters]).to have(18).items
        expect(characters[:characters].first).to eq(
          id: 139_108,
          roles: %w[Main]
        )
        expect(characters[:staff]).to have(19).items
        expect(characters[:staff].first).to eq(
          id: 33_365,
          roles: %w[Director Script]
        )
      end
    end

    context 'manga' do
      let(:type) { :manga }
      let(:id) { 55_215 }

      it do
        expect(characters).to have(2).items
        expect(characters[:characters]).to have(19).items
        expect(characters[:characters].first).to eq(
          id: 87_719,
          roles: %w[Main]
        )
        expect(characters[:staff]).to have(2).items
        expect(characters[:staff].first).to eq(
          id: 23_549,
          roles: %w[Story]
        )
      end
    end

    describe 'record not found' do
      let(:id) { 999_999_999 }
      it { expect { subject }.to raise_error MalParser::RecordNotFound }
    end

    describe 'no roles' do
      let(:id) { 34_312 }
      it do
        is_expected.to eq(
          characters: [{
            id: 126_511,
            roles: %w[Main]
          }],
          staff: []
        )
      end
    end
  end
end
