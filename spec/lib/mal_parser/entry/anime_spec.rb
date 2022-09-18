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
        genres: [{ id: 1, name: 'Action' }, { id: 2, name: 'Adventure' }, { id: 10, name: 'Fantasy' }, { id: 22, name: 'Romance' }, { id: 64, name: 'Love Polygon' }, { id: 79, name: 'Video Game' }],
        duration: 23,
        rating: :pg_13,
        score: 7.2,
        ranked: 2987,
        popularity: 5,
        members: 2812680,
        favorites: 64975,
        related: {
          adaptation: [{
            id: 21479,
            name: 'Sword Art Online',
            type: :manga
          }, {
            id: 43921,
            name: 'Sword Art Online: Progressive',
            type: :manga
          }],
          alternative_version: [{
            id: 42916,
            name: 'Sword Art Online: Progressive Movie - Hoshi Naki Yoru no Aria',
            type: :anime
          }],
          other: [{
            id: 16099,
            name: 'Sword Art Online: Sword Art Offline',
            type: :anime
          }],
          sequel: [{
            id: 20021,
            name: 'Sword Art Online: Extra Edition',
            type: :anime
          }]
        },
        external_links: [{
          kind: 'official_site',
          url: 'http://www.swordart-online.net/'
        }, {
          kind: 'anime_db',
          url: 'http://anidb.info/perl-bin/animedb.pl?show=anime&aid=8692'
        }, {
          kind: 'anime_news_network',
          url: 'http://www.animenewsnetwork.com/encyclopedia/anime.php?id=13858'
        }, {
          kind: 'wikipedia',
          url: 'http://en.wikipedia.org/wiki/Sword_Art_Online'
        }],
        synopsis: <<-TEXT.strip
          Ever since the release of the innovative NerveGear, gamers from all around the globe have been given the opportunity to experience a completely immersive virtual reality. Sword Art Online (SAO), one of the most recent games on the console, offers a gateway into the wondrous world of Aincrad, a vivid, medieval landscape where users can do anything within the limits of imagination. With the release of this worldwide sensation, gaming has never felt more lifelike.<br><br>However, the idyllic fantasy rapidly becomes a brutal nightmare when SAO's creator traps thousands of players inside the game. The \"log-out\" function has been removed, with the only method of escape involving beating all of Aincrad's one hundred increasingly difficult levels. Adding to the struggle, any in-game death becomes permanent, ending the player's life in the real world.<br><br>While Kazuto \"Kirito\" Kirigaya was fortunate enough to be a beta-tester for the game, he quickly finds that despite his advantages, he cannot overcome SAO's challenges alone. Teaming up with Asuna Yuuki and other talented players, Kirito makes an effort to face the seemingly insurmountable trials head-on. But with difficult bosses and threatening dark cults impeding his progress, Kirito finds that such tasks are much easier said than done.<br><br>[Written by MAL Rewrite]<br>
        TEXT
      )
    end

    # describe 'external_links' do
    #   let(:id) { 32_281 }
    #
    #   before { MalParser.configuration.http_get = get_with_cookie }
    #   after { MalParser.reset }
    #   let(:get_with_cookie) do
    #     ->(url) do
    #       open(url, 'Cookie' => cookie).read
    #     end
    #   end
    #   let(:cookie) do
    #     %w[
    #       MALHLOGSESSID=9997d5a535600b43364da581824850b8;
    #       MALSESSIONID=3vbue7hmqoqa86f9tplpsb2781;
    #       is_logged_in=1;
    #     ].join(' ')
    #   end
    #
    #   it do
    #     expect(subject[:external_links]).to eq [
    #       {
    #         kind: 'official_site',
    #         url: 'http://www.kiminona.com/'
    #       }, {
    #         kind: 'anime_db',
    #         url: 'http://anidb.info/perl-bin/animedb.pl?show=anime&aid=11829'
    #       }, {
    #         kind: 'anime_news_network',
    #         url: 'http://www.animenewsnetwork.com/encyclopedia/anime.php?id=18171'
    #       }, {
    #         kind: 'wikipedia',
    #         url: 'https://en.wikipedia.org/wiki/Your_Name'
    #       }
    #     ]
    #   end
    # end

    context 'none studios found' do
      let(:id) { 34_746 }
      it { expect(subject[:studios]).to eq [] }
    end

    context 'record not found' do
      let(:id) { 999_999_999 }
      it { expect { subject }.to raise_error MalParser::RecordNotFound }
    end

    context 'missing related' do
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

    context 'duplicate genres' do
      let(:id) { 28_367 }
      it do
        expect(subject[:genres]).to eq [{
          id: 27,
          name: 'Shounen'
        }, {
          id: 4,
          name: 'Comedy'
        }, {
          id: 24,
          name: 'Sci-Fi'
        }, {
          id: 57,
          name: 'Gag Humor'
        }]
      end
    end

    context 'synopsis' do
      let(:id) { 39_893 }
      it do
        expect(subject[:synopsis]).to eq(
          'Set in a city modeled after San Francisco in the 1980s, the protagonist has transformed into the hero Muteking and is fighting against evil aliens for some reason. Such a cheerful hero will return in 2020! Sci-fi hero love comedy <i>Muteking the Dancing Hero</i>, singing and dancing with pop music.<br><br>(Source: Official Website)'
        )
      end
    end
  end
end
