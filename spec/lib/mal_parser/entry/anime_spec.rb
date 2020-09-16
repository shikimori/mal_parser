describe MalParser::Entry::Anime do
  let(:parser) { MalParser::Entry::Anime.new id }
  let(:id) { 11757 }

  describe '#call', :vcr do
    subject { parser.call }

    it do
      is_expected.to eq(
        id: id,
        name: 'Sword Art Online',
        image: 'https://cdn.myanimelist.net/images/anime/11/39717.jpg',
        english: 'Sword Art Online',
        synonyms: ['S.A.O', 'SAO'],
        japanese: 'ソードアート・オンライン',
        kind: :tv,
        episodes: 25,
        status: :released,
        season: 'summer_2012',
        aired_on: Date.parse('2012-07-08'),
        released_on: Date.parse('2012-12-23'),
        broadcast: 'Sundays at 00:00 (JST)',
        studios: [{ id: 56, name: 'A-1 Pictures' }],
        origin: :light_novel,
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
        score: 7.31,
        ranked: 2276,
        popularity: 3,
        members: 1959453,
        favorites: 62096,
        related: {
          adaptation: [{
            id: 21_479,
            name: 'Sword Art Online',
            type: :manga
          }, {
            id: 43_921,
            name: 'Sword Art Online: Progressive',
            type: :manga
          }],
          other: [{
            id: 16_099,
            name: 'Sword Art Online: Sword Art Offline',
            type: :anime
          }],
          sequel: [{
            id: 20_021,
            name: 'Sword Art Online: Extra Edition',
            type: :anime
          }]
        },
        external_links: nil,
        synopsis: <<-TEXT.strip
          In the year 2022, virtual reality has progressed by leaps and bounds, and a massive online role-playing game called Sword Art Online (SAO) is launched. With the aid of "NerveGear" technology, players can control their avatars within the game using nothing but their own thoughts.<br><br>Kazuto Kirigaya, nicknamed "Kirito," is among the lucky few enthusiasts who get their hands on the first shipment of the game. He logs in to find himself, with ten-thousand others, in the scenic and elaborate world of Aincrad, one full of fantastic medieval weapons and gruesome monsters. However, in a cruel turn of events, the players soon realize they cannot log out; the game's creator has trapped them in his new world until they complete all one hundred levels of the game.<br><br>In order to escape Aincrad, Kirito will now have to interact and cooperate with his fellow players. Some are allies, while others are foes, like Asuna Yuuki, who commands the leading group attempting to escape from the ruthless game. To make matters worse, Sword Art Online is not all fun and games: if they die in Aincrad, they die in real life. Kirito must adapt to his new reality, fight for his survival, and hopefully break free from his virtual hell.<br><br>[Written by MAL Rewrite]
        TEXT
      )
    end

    describe 'external_links' do
      let(:id) { 32_281 }

      before { MalParser.configuration.http_get = get_with_cookie }
      after { MalParser.reset }
      let(:get_with_cookie) do
        ->(url) do
          open(url, 'Cookie' => cookie).read
        end
      end
      let(:cookie) do
        %w[
          MALHLOGSESSID=9997d5a535600b43364da581824850b8;
          MALSESSIONID=3vbue7hmqoqa86f9tplpsb2781;
          is_logged_in=1;
        ].join(' ')
      end

      it do
        expect(subject[:external_links]).to eq [
          {
            kind: 'official_site',
            url: 'http://www.kiminona.com/'
          }, {
            kind: 'anime_db',
            url: 'http://anidb.info/perl-bin/animedb.pl?show=anime&aid=11829'
          }, {
            kind: 'anime_news_network',
            url: 'http://www.animenewsnetwork.com/encyclopedia/anime.php?id=18171'
          }, {
            kind: 'wikipedia',
            url: 'https://en.wikipedia.org/wiki/Your_Name'
          }
        ]
      end
    end

    describe 'none studios found' do
      let(:id) { 34_746 }
      it { expect(subject[:studios]).to eq [] }
    end

    describe 'record not found' do
      let(:id) { 999_999_999 }
      it { expect { subject }.to raise_error MalParser::RecordNotFound }
    end

    describe 'missing related' do
      let(:id) { 157 }
      it do
        expect(subject[:related]).to eq(
          adaptation: [{
            id: 15,
            name: 'Mahou Sensei Negima!',
            type: :manga
          }],
          alternative_version: [{
            id: 1_546,
            name: 'Negima!?',
            type: :anime
          }],
          alternative_setting: [{
            id: 3_948,
            name: 'Mahou Sensei Negima!: Introduction Film',
            type: :anime
          }, {
            id: 4_188,
            name: 'Mahou Sensei Negima!: Shiroki Tsubasa Ala Alba',
            type: :anime
          }],
          other: [{
            id: 34_450,
            name: 'Mahou Sensei Negima! Tokubetsu Eizou',
            type: :anime
          }],
          sequel: [{
            id: 33_478,
            name: 'UQ Holder!: Mahou Sensei Negima! 2',
            type: :anime
          }]
        )
      end
    end

    describe 'duplicate genres' do
      let(:id) { 28_367 }
      it do
        expect(subject[:genres]).to eq [
          {
            id: 24,
            name: 'Sci-Fi'
          }, {
            id: 4,
            name: 'Comedy'
          }, {
            id: 27,
            name: 'Shounen'
          }
        ]
      end
    end
  end
end
