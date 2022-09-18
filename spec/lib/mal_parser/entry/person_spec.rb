describe MalParser::Entry::Person do
  let(:parser) { MalParser::Entry::Person.new id }
  let(:id) { 11 }

  describe '#call', :vcr do
    subject { parser.call }

    it do
      is_expected.to eq(
        id: id,
        name: 'Kouichi Yamadera',
        image: 'https://cdn.myanimelist.net/images/voiceactors/3/60992.jpg',
        japanese: '山寺 宏一',
        website: nil,
        birth_on: Date.parse('1961-06-17')
      )
    end

    context 'birthday unknown' do
      let(:id) { 38_062 }
      it do
        is_expected.to eq(
          id: id,
          name: 'Aya',
          image: 'https://cdn.myanimelist.net/images/voiceactors/3/40196.jpg',
          japanese: '亜矢',
          website: 'http://www.sonymusic.co.jp/artist/Aya/',
          birth_on: nil
        )
      end
    end

    context 'record not found' do
      let(:id) { 999_999_999 }
      it { expect { subject }.to raise_error MalParser::RecordNotFound }
    end

    context 'website' do
      let(:id) { 869 }
      it { expect(subject[:website]).to eq 'https://hayamisaoriofficial.com/' }
    end

    context 'no year in birthday' do
      let(:id) { 10_929 }
      it { expect(subject[:birth_on]).to eq Date.parse('1992-06-01') }
    end
  end
end
