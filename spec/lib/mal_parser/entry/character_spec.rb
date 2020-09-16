describe MalParser::Entry::Character do
  let(:parser) { MalParser::Entry::Character.new id }
  let(:id) { 36765 }

  describe '#call', :vcr do
    subject { parser.call }

    it do
      is_expected.to eq(
        id: id,
        name: 'Kazuto Kirigaya',
        image: 'https://cdn.myanimelist.net/images/characters/7/204821.jpg',
        japanese: '桐ヶ谷 和人',
        fullname: 'Kazuto "Kirito, The Black Swordsman, Beater, Kazu" Kirigaya',
        seyu: [{
          id: 732,
          type: :person,
          roles: %w[English]
        }, {
          id: 1_110,
          type: :person,
          roles: %w[Italian]
        }, {
          id: 7_303,
          type: :person,
          roles: %w[French]
        }, {
          id: 11_817,
          type: :person,
          roles: %w[Japanese]
        }, {
          id: 14_753,
          type: :person,
          roles: %w[Korean]
        }, {
          id: 21_035,
          type: :person,
          roles: %w[German]
        }, {
          id: 25_691,
          type: :person,
          roles: %w[French]
        }, {
          id: 31_535,
          type: :person,
          roles: %w[Spanish]
        }, {
          id: 45_412,
          type: :person,
          roles: %w[Spanish]
        }],
        synopsis: <<-HTML.strip
          Birthday: October 7, 2008<br>Age: 14 (Beginning of Aincrad arc), 16 (End of Aincrad arc, Fairy Dance arc), 17 (Phantom Bullet arc) 18 (Mother's Rosario) 18 (Alicilization)<br>Height: 172 cm<br>Weight: 59 kg<br>Weapon(s) of choice: Anneal Blade (1st Level), Queen's Knightblade (9th Level), Elucidator (50th level), Dark Repulser (forged by Lisbeth), and Holy Sword Excalibur (obtained from the "Calibur Quest").<br><br>Kirito is the protagonist of Sword Art Online. He is a "solo" player, a player who hasn't joined a guild and usually works alone. He is also one of the very few people to have had the privilege to play in the beta testing period of Sword Art Online. His game alias, Kirito, is created by taking the syllables of the first and last Kanji of his real last and first names respectively: (Kirigaya Kazuto). In the real world, he lives with his aunt and younger cousin in a family of 3.<br><br>When Kayaba announced the start of the death game, he is surprised, but unlike everyone else, he quickly gets over it and accepts it to an extent. He invited his friend Klein to go with him but Klein had to find his friends in the game. He was invited to join them but he declined as he couldn't take the pressure of protecting them even with his beta testing knowledge of the game.<br><br>Kirito tends to use a single handed straight sword. The blade that he uses most often is the Elucidator. Later on, he acquires a second blade called Dark Repulser that was made by his blacksmith friend, Lisbeth.<br><br>[spoiler_block=Spoiler]<br>He was the first one to be called a Beater, a combination of beta testing and cheater, as he had great knowledge of the game through the beta test period and showing great skills in floor clearing but chose not to help other players. He had it imposed on himself so as to differentiate the beta testers who were just picked in the testing and the serious gamers who use the knowledge efficiently like a cheat.<br><br>He has a unique skill called "Dual Blades" which allows him to dual wield two swords and use Swords Skills. It's the special skill designed for the Hero that defeats the Demon Lord at the last floor. He found it in his skills list after a year in the game. After nearly mastering it, he only uses it in emergencies to avoid attention for being one of the few people to have a unique skill.<br><br>He befriends a girl by the name of Yuuki Asuna who later becomes his lover.<br><br>In the 10th volume of the <i>Accel World</i> novel and the 5th volume of the <i>Accel World</i> manga, Kirito is featured in a special chapter, in which he fights Silver Crow, the burst linker. In the chapter, Kirito is playing as his old SAO avatar, wielding the Elucidator and Dark Repulser.[/spoiler_block]
        HTML
      )
    end

    describe 'no image' do
      let(:id) { 29_001 }
      it { expect(subject[:image]).to eq nil }
    end

    describe 'record not found' do
      let(:id) { 999_999_999 }
      it { expect { subject }.to raise_error MalParser::RecordNotFound }
    end

    describe 'no japanese, no seyu' do
      let(:id) { 28_754 }
      it do
        is_expected.to eq(
          id: id,
          name: 'Ji-hoo Min',
          image: 'https://cdn.myanimelist.net/images/characters/13/74084.jpg',
          japanese: nil,
          fullname: 'Ji-hoo Min',
          seyu: [],
          synopsis: <<-HTML.strip
            His mother runs the boarding house that Jae-yoo was interested in moving in to. He firsts meets Jae-yoo after a fight with Kang Tae-il, although he's hiding out behind a light poll watching her confess to Hyun-woo. They meet again at Dong-joo's and Jae-yoo's blind date, and he is uncertain of where he's seen her before. He immediate insults her and leaves. Later, when the date doesn't end well, to protect his friend, he calls her up to confront her. When he realizes Jae-yoo's the new boarder, he asks his mom to kick her out. Every time they see each other they fight.<br><br>His first love/girlfriend dumped him for Kang Tae-il. They were together since middle school. She watched him get beaten up by Tae-il and then left him. Tae-il ended up finding a new girlfriend, and she came back to Ji-hoo so they could start over. But Ji-hoo didn't take her back. The ex-girlfriend eventually left Korea. Because of this, he finds it hard to find another girlfriend. Also, Tae-il becomes his rival, so Ji-hoo is always fighting with the Inpyoung gang as his way of revenge. He's now known as the "iljin" (top gang leader) at the school.<br><br>The only way he trusts Jae-yoo is if she tells him she likes him (asking her to repeat what she said). He needs the confirmation, because he constantly worries she's cheating on him (the scars of a broken heart).<br><br>(Wikipedia)<br>
          HTML
        )
      end
    end
  end
end
