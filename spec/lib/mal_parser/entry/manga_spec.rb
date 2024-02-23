describe MalParser::Entry::Manga do
  let(:parser) { described_class.new id }

  describe '#call', :vcr do
    subject { parser.call }
    let(:id) { 11757 }

    it do
      is_expected.to eq(
        id:,
        name: 'Genryuu Butouden: Origin',
        image: 'https://cdn.myanimelist.net/images/manga/2/101429l.jpg',
        english: 'The Battle of Genryu: Origin',
        synonyms: ['Genryuu Butouten - Origin'],
        japanese: '源流武闘伝 -ORIGIN-',
        kind: :manga,
        chapters: 15,
        volumes: 3,
        status: :released,
        aired_on: { year: 2006 },
        released_on: { year: 2007 },
        publishers: [{ id: 276, name: 'FlexComix Blood' }],
        genres: [
          { id: 27, name: 'Shounen', kind: :demographic },
          { id: 1, name: 'Action', kind: :genre },
          { id: 17, name: 'Martial Arts', kind: :theme },
          { id: 23, name: 'School', kind: :theme }
        ],
        score: 0.0,
        ranked: 18676,
        popularity: 35778,
        members: 128,
        favorites: 0,
        related: {},
        external_links: [{
          kind: 'official_site',
          url: 'http://flex-comix.jp/titles/gennrixy/'
        }],
        is_more_info: false,
        synopsis: <<-TEXT.strip
          Jin's a happy, irresponsible high school kid with extraordinary powers. The problem is, they only show up once a month. He's got a great group of friends, including the attractive Fusano, who takes her own fighting skills way more seriously than Jin does. But that all changes when some tough guys challenge him on one of the days when he isn't powered up. Turns out they were hired by his estranged brother Soichiro, who is after something that Jin possesses. And when Soichiro later attacks Fusano, the war between brothers is on.<br><br>(Source: CMX)
        TEXT
      )
    end

    context 'year without date' do
      let(:id) { 304 }
      it do
        expect(subject[:aired_on]).to eq(year: 1978)
        expect(subject[:released_on]).to eq(year: 1987)
      end
    end

    context 'record not found' do
      let(:id) { 999_999_999 }
      it { expect { subject }.to raise_error MalParser::RecordNotFound }
    end

    context 'broken ongoing date' do
      let(:id) { 116_897 }
      it do
        expect(subject[:aired_on]).to eq(year: 2013, month: 10)
        expect(subject[:released_on]).to eq nil
      end
    end

    context 'namu wiki' do
      let(:id) { 138443 }
      it do
        expect(subject[:external_links]).to eq [{
          kind: 'official_site',
          url: 'https://comic.naver.com/webtoon/list.nhn?titleId=725586'
        }, {
          kind: 'wikipedia',
          url: 'https://namu.wiki/w/1%EC%B4%88(%EC%9B%B9%ED%88%B0)'
        }]
      end
    end

    context 'multiple demographic' do
      let(:id) { 1706 }
      it do
        expect(subject[:genres]).to eq [
          { id: 41, kind: :demographic, name: 'Seinen' },
          { id: 27, kind: :demographic, name: 'Shounen' },
          { id: 1, kind: :genre, name: 'Action' },
          { id: 2, kind: :genre, name: 'Adventure' },
          { id: 7, kind: :genre, name: 'Mystery' },
          { id: 37, kind: :genre, name: 'Supernatural' },
          { id: 13, kind: :theme, name: 'Historical' }
        ]
      end
    end
  end
end
