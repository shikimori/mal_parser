describe MalParser::Entry::Character do
  let(:parser) { MalParser::Entry::Character.new id }
  let(:id) { 36_765 }

  describe '#call', :vcr do
    subject! { parser.call }

    it do
      is_expected.to eq(
        id: id,
        name: 'Kazuto Kirigaya',
        image: 'https://myanimelist.cdn-dena.com/images/characters/7/204821.jpg',
        japanese: '桐ヶ谷 和人',
        fullname: 'Kazuto "Kirito, The Black Swordsman, Beater, Kazu" Kirigaya',
        seyu: [{
          id: 732,
          type: :person,
          role: 'English'
        }, {
          id: 1_110,
          type: :person,
          role: 'Italian'
        }, {
          id: 7_303,
          type: :person,
          role: 'French'
        }, {
          id: 11_817,
          type: :person,
          role: 'Japanese'
        }, {
          id: 14_753,
          type: :person,
          role: 'Korean'
        }, {
          id: 21_035,
          type: :person,
          role: 'German'
        }, {
          id: 25_691,
          type: :person,
          role: 'French'
        }, {
          id: 31_535,
          type: :person,
          role: 'Spanish'
        }],
        synopsis: <<-HTML.strip
          Birthday: October 7, 2008<br>\r\nAge: 14 (Beginning of Aincrad arc), 16 (End of Aincrad arc, Fairy Dance arc), 17 (Phantom Bullet arc)<br>\r\nHeight: 172 cm<br>\r\nWeight: 59 kg<br>\r\nWeapon(s) of choice: Anneal Blade (1st Level), Queen's Knightblade (9th Level), Elucidator (50th level), Dark Repulser (forged by Lisbeth), and Holy Sword Excalibur (obtained from the \"Calibur Quest\").<br>\r\n<br>\r\nKirito is the protagonist of Sword Art Online. He is a \"solo\" player, a player who hasn't joined a guild and usually works alone. He is also one of the very few people to have had the privilege to play in the beta testing period of Sword Art Online. His game alias, Kirito, is created by taking the syllables of the first and last Kanji of his real last and first names respectively: (Kirigaya Kazuto). In the real world, he lives with his aunt and younger cousin in a family of 3.<br>\r\n<br>\r\nWhen Kayaba announced the start of the death game, he is surprised, but unlike everyone else he quickly gets over it and accepts it to an extent. He invited his friend Klein to go with him but Klein had to find his friends in the game. He was invited to join them but he declined as he couldn't take the pressure of protecting them even with his beta testing knowledge of the game.<br>\r\n<br>\r\nKirito tends to use a single handed straight sword. The blade that he uses most often is the Elucidator. Later on he acquires a second blade called Dark Repulser that was made by his blacksmith friend, Lisbeth.<br>\r\n<br>\r\n<div class=\"spoiler\">\n<input type=\"button\" class=\"button show_button\" onclick=\"this.nextSibling.style.display='inline-block';this.style.display='none';\" data-showname=\"Show spoiler\" data-hidename=\"Hide spoiler\" value=\"Show spoiler\"><span class=\"spoiler_content\" style=\"display:none\"><input type=\"button\" class=\"button hide_button\" onclick=\"this.parentNode.style.display='none';this.parentNode.parentNode.childNodes[0].style.display='inline-block';\" value=\"Hide spoiler\"><br>He was the first one to be called a Beater, a combination of beta testing and cheater, as he had great knowledge of the game through the beta test period and showing great skills in floor clearing but chose not to help other players.<br>\r\n<br>\r\nHe had it imposed on himself so as to differentiate the beta testers who were just picked in the testing and the serious gamers who uses the knowledge efficiently like a cheat.<br>\r\n<br>\r\nHe has a unique skill called <b><<Dual Blades>></b> which allows him to dual wield two swords and use Swords Skills. It's the special skill designed for the Hero that defeats the Demon Lord at the last floor. He found it in his skills list after a year in the game. After nearly mastering it, he only uses it in emergencies to avoid attention for being one of the few people to have a unique skill.<br>\r\n<br>\r\nHe befriends a girl by the name of Yuuki Asuna who later becomes his lover.<br>\r\n<br>\r\nIn the 10th volume of the <i>Accel World</i> light novel and the 5th volume of the <i>Accel World</i> manga Kirito is featured in a special chapter, in which he fights Sliver Crow, the burst linker. In the chapter, Kirito is playing as his old SAO avatar, wielding the Elucidator and Dark Repulser.</span>\n</div>
        HTML
      )
    end
  end
end
