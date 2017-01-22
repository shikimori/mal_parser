describe MalParser::Entry::Person do
  let(:parser) { MalParser::Entry::Person.new id }
  let(:id) { 11 }

  describe '#call', :vcr do
    subject { parser.call }

    it do
      is_expected.to eq(
        id: id,
        name: 'Kouichi Yamadera',
        image: 'https://myanimelist.cdn-dena.com/images/voiceactors/3/44674.jpg',
        japanese: '山寺 宏一',
        website: nil,
        birthday: Date.parse('1961-06-17')
      )
    end

    describe 'record not found' do
      let(:id) { 999_999_999 }
      it { expect { subject }.to raise_error MalParser::RecordNotFound }
    end

    describe 'website' do
      let(:id) { 869 }
      it { expect(subject[:website]).to eq 'http://whv-amusic.com/hayamisaori/' }
    end
  end
end
