describe MalParser::Entry::Manga do
  let(:parser) { MalParser::Entry::Manga.new id }

  describe '#call', :vcr do
    subject { parser.call }
    let(:id) { 11757 }

    it do
      is_expected.to eq(
        id: id,
        name: 'Genryuu Butouden: Origin',
        image: 'https://cdn.myanimelist.net/images/manga/2/101429.jpg',
        english: 'The Battle of Genryu: Origin',
        synonyms: ['Genryuu Butouten - Origin'],
        japanese: '源流武闘伝 -ORIGIN-',
        kind: :manga,
        chapters: 15,
        volumes: 3,
        status: :released,
        aired_on: Date.parse('2006-01-01'),
        released_on: Date.parse('2007-01-01'),
        publishers: [{ id: 276, name: 'FlexComix Blood' }],
        genres: [{
          id: 27,
          name: 'Shounen'
        }, {
          id: 1,
          name: 'Action'
        }, {
          id: 30,
          name: 'Sports'
        }, {
          id: 17,
          name: 'Martial Arts'
        }, {
          id: 23,
          name: 'School'
        }],
        score: 0.0,
        ranked: 16346,
        popularity: 31594,
        members: 114,
        favorites: 0,
        related: {},
        external_links: [{
          kind: 'official_site',
          url: 'http://flex-comix.jp/titles/gennrixy/'
        }],
        synopsis: <<-TEXT.strip
          Jin's a happy, irresponsible high school kid with extraordinary powers. The problem is, they only show up once a month. He's got a great group of friends, including the attractive Fusano, who takes her own fighting skills way more seriously than Jin does. But that all changes when some tough guys challenge him on one of the days when he isn't powered up. Turns out they were hired by his estranged brother Soichiro, who is after something that Jin possesses. And when Soichiro later attacks Fusano, the war between brothers is on.<br><br>(Source: CMX)
        TEXT
      )
    end

    context 'year without date' do
      let(:id) { 304 }
      it do
        expect(subject[:aired_on]).to eq Date.parse('1978-01-01')
        expect(subject[:released_on]).to eq Date.parse('1987-01-01')
      end
    end

    context 'record not found' do
      let(:id) { 999_999_999 }
      it { expect { subject }.to raise_error MalParser::RecordNotFound }
    end

    context 'broken ongoing date' do
      let(:id) { 116_897 }
      it do
        expect(subject[:aired_on]).to eq Date.parse('Oct, 2013')
        expect(subject[:released_on]).to eq nil
      end
    end
  end
end
