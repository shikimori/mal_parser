describe MalParser::Entry::Anime do
  let(:parser) { MalParser::Entry::Anime.new id }
  let(:id) { 11_757 }

  describe '#call', :vcr, :focus do
    subject! { parser.call }

    it do
      is_expected.to eq(
        id: id,
        name: 'Sword Art Online',
        image: 'https://myanimelist.cdn-dena.com/images/anime/11/39717.jpg',
        english: 'Sword Art Online',
        synonyms: ['S.A.O', 'SAO'],
        japanese: 'ソードアート・オンライン',
        kind: 'tv',
        episodes: 25,
        status: 'released',
        aired_on: Date.parse('2012-07-08'),
        released_on: Date.parse('2012-12-23'),
        broadcast: 'Sundays at 00:00 (JST)',
        studios: [{ id: 56, name: 'A-1 Pictures' }],
        origin: 'Light novel',
        genres: [
          {
            id: 1,
            name: 'Action'
          }, {
            id: 2,
            name: 'Adventure'
          }, {
            id: 10,
            name: 'Fantasy'
          }, {
            id: 11,
            name: 'Game'
          }, {
            id: 22,
            name: 'Romance'
          }
        ],
        duration: 23,
        rating: 'pg_13',
        score: 7.83,
        ranked: 807,
        popularity: 3,
        members: 892811,
        favorites: 40900
      )
    end
  end
end
