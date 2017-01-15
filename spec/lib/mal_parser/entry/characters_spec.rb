describe MalParser::Entry::Characters do
  let(:parser) { MalParser::Entry::Characters.new id, type }
  let(:id) { 32_948 }
  let(:type) { :anime }

  describe '#call', :vcr do
    subject { parser.call }

    it do
      is_expected.to eq(
        characters: [
          {
            id: 143_628,
            role: 'Main'
          }, {
            id: 139_108,
            role: 'Main'
          }, {
            id: 139_109,
            role: 'Main'
          }, {
            id: 145_176,
            role: 'Supporting'
          }, {
            id: 145_177,
            role: 'Supporting'
          }, {
            id: 145_678,
            role: 'Supporting'
          }, {
            id: 145_178,
            role: 'Supporting'
          }
        ],
        staff: [
          {
            id: 33_365,
            role: 'Director'
          }, {
            id: 30_337,
            role: 'Sound Director'
          }, {
            id: 40_790,
            role: 'Theme Song Performance'
          }, {
            id: 40_122,
            role: 'Character Design'
          }, {
            id: 6_573,
            role: 'Music'
          }, {
            id: 9_622,
            role: 'Original Character Design'
          }, {
            id: 29_447,
            role: 'Original Creator'
          }, {
            id: 9_572,
            role: 'Series Composition'
          }
        ]
      )
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
            role: 'Main'
          }],
          staff: []
        )
      end
    end
  end
end
