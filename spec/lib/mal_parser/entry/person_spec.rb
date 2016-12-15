describe MalParser::Entry::Person do
  let(:parser) { MalParser::Entry::Person.new id }
  let(:id) { 11 }

  describe '#call', :vcr do
    subject! { parser.call }

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
  end
end
