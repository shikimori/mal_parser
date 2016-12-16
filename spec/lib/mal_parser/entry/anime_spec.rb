describe MalParser::Entry::Anime do
  let(:parser) { MalParser::Entry::Anime.new id }
  let(:id) { 11_757 }

  describe '#call', :vcr do
    subject { parser.call }

    it do
      is_expected.to eq(
        id: id,
        name: 'Sword Art Online',
        image: 'https://myanimelist.cdn-dena.com/images/anime/11/39717.jpg',
        english: 'Sword Art Online',
        synonyms: ['S.A.O', 'SAO'],
        japanese: 'ソードアート・オンライン',
        kind: :tv,
        episodes: 25,
        status: :released,
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
        rating: :pg_13,
        score: 7.83,
        ranked: 807,
        popularity: 3,
        members: 892_811,
        favorites: 40_900,
        related: {
          adaptation: [{
            id: 21_479,
            type: :manga,
            name: 'Sword Art Online'
          }, {
            id: 43_921,
            type: :manga,
            name: 'Sword Art Online: Progressive'
          }],
          other: [{
            id: 16_099,
            type: :anime,
            name: 'Sword Art Online: Sword Art Offline'
          }],
          sequel: [{
            id: 20_021,
            type: :anime,
            name: 'Sword Art Online: Extra Edition'
          }]
        },
        external_links: nil,
        synopsis: <<-TEXT.strip
          In the year 2022, virtual reality has progressed by leaps and bounds, and a massive online role-playing game called Sword Art Online (SAO) is launched. With the aid of "NerveGear" technology, players can control their avatars within the game using nothing but their own thoughts.\r\n\r\nKazuto Kirigaya, nicknamed "Kirito," is among the lucky few enthusiasts who get their hands on the first shipment of the game. He logs in to find himself, with ten-thousand others, in the scenic and elaborate world of Aincrad, one full of fantastic medieval weapons and gruesome monsters. However, in a cruel turn of events, the players soon realize they cannot log out; the game's creator has trapped them in his new world until they complete all one hundred levels of the game.\r\n\r\nIn order to escape Aincrad, Kirito will now have to interact and cooperate with his fellow players. Some are allies, while others are foes, like Asuna Yuuki, who commands the leading group attempting to escape from the ruthless game. To make matters worse, Sword Art Online is not all fun and games: if they die in Aincrad, they die in real life. Kirito must adapt to his new reality, fight for his survival, and hopefully break free from his virtual hell.\r\n\r\n[Written by MAL Rewrite]
        TEXT
      )
    end

    describe 'external_links', :focus do
      let(:id) { 32_281 }

      before { MalParser.configuration.http_get = get_with_cookie }
      after { MalParser.reset }
      let(:get_with_cookie) do
        lambda do |url|
          open(url, 'Cookie' => cookie).read
        end
      end
      let(:cookie) do
        %w(
          MALHLOGSESSID=978fea4e54380b5c421580ee33e7b521;
          MALSESSIONID=7dl75aolp079jqcaphp0175r37;
          is_logged_in=1;
        ).join(' ')
      end

      it do
        expect(subject[:external_links]).to eq [
          {
            source: 'official_site',
            url: 'http://www.kiminona.com/'
          }, {
            source: 'anime_db',
            url: 'http://anidb.info/perl-bin/animedb.pl?show=anime&aid=11829'
          }, {
            source: 'anime_news_network',
            url: 'http://www.animenewsnetwork.com/encyclopedia/anime.php?id=18171'
          }, {
            source: 'wikipedia',
            url: 'http://ja.wikipedia.org/wiki/%E5%90%9B%E3%81%AE%E5%90%8D%E3%81%AF%E3%80%82'
          }
        ]
      end
    end
  end
end
