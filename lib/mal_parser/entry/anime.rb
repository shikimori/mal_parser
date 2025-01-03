module MalParser
  class Entry::Anime < Entry::Base # rubocop:disable Metrics/ClassLength
    FIELDS = Entry::Base::FIELDS + %i[
      english japanese synonyms kind episodes status aired_on released_on
      broadcast studios origin origin_manga_id genres duration rating
      score ranked popularity members favorites synopsis related
      external_links season is_more_info
    ]
    AIRED_FIELD = 'Aired'

    KIND = {
      'Movie' => :movie,
      'Music' => :music,
      'TV' => :tv,
      'Special' => :special,
      'TV Special' => :tv_special,
      'OVA' => :ova,
      'ONA' => :ona,
      'PV' => :pv,
      'CM' => :cm
    }
    STATUS = {
      'Not yet aired' => :anons,
      'Currently Airing' => :ongoing,
      'Finished Airing' => :released
    }
    RATING = {
      'None' => :none,
      'G - All Ages' => :g,
      'PG - Children' => :pg,
      'PG-13 - Teens 13 or older' => :pg_13,
      'R - 17+ (violence & profanity)' => :r,
      'R+ - Mild Nudity' => :r_plus,
      'Rx - Hentai' => :rx
    }
    RELATED = {
      'adaptation' => :adaptation,
      'alternative setting' => :alternative_setting,
      'alternative version' => :alternative_version,
      'character' => :character,
      'full story' => :full_story,
      'other' => :other,
      'parent story' => :parent_story,
      'prequel' => :prequel,
      'sequel' => :sequel,
      'side story' => :side_story,
      'spin-off' => :spin_off,
      'summary' => :summary
    }
    EXTERNAL_LINKS_KIND = {
      'a_nn' => 'anime_news_network',
      'ani_db' => 'anime_db',
      'namu.wiki' => 'wikipedia'
    }

  private

    def english
      parse_line 'English'
    end

    def japanese
      parse_line 'Japanese'
    end

    def synonyms
      parse_line('Synonym', can_be_plural: true)&.split(', ')&.map(&:strip) || []
    end

    def kind
      value = parse_line('Type')
      return if !value || value.empty? || value.casecmp('unknown').zero?

      self.class::KIND[value] || explode!(:kind, value)
    end

    def episodes
      value = parse_line('Episodes').to_i
      value if value.positive?
    end

    def status
      value = parse_line('Status')
      return if !value || value.empty?

      self.class::STATUS[value] || explode!(:status, value)
    end

    def season
      parse_line('Premiered')&.downcase&.gsub(' ', '_')
    end

    def is_more_info # rubocop:disable Naming/PredicateName
      css('#horiznav_nav a').last.text.strip == 'More Info'
    end

    def aired_on
      dates[0]
    end

    def released_on
      dates[1]
    end

    def broadcast
      value = parse_line('Broadcast')
      value if value && !value.empty? && value != 'Unknown'
    end

    def image
      parsed_image = super
      return unless parsed_image

      split = parsed_image.split('.')
      split[0..-2].join('.') + 'l.' + split[-1]
    end

    def studios
      parse_links('Studios')
    end

    def origin
      (parse_line('Source') || 'unknown').downcase.tr(' ', '_').to_sym
    end

    def origin_manga_id
      origin_node = doc.css('.spaceit_pad:contains("Source:") a')[0]

      parse_link(origin_node)&.dig(:id) if origin_node
    end

    def genres
      parse_links('Demographic', can_be_plural: true, additionals: { kind: :demographic }) +
        parse_links('Genre', can_be_plural: true, additionals: { kind: :genre }) +
        parse_links('Theme', can_be_plural: true, additionals: { kind: :theme })
    end

    def duration
      value = parse_line('Duration')

      hours = $LAST_MATCH_INFO[:hours] if value =~ /(?<hours>\d+) hr./
      minutes = $LAST_MATCH_INFO[:minutes] if value =~ /(?<minutes>\d+) min./

      (hours.to_i * 60) + minutes.to_i
    end

    def rating
      value = CGI.unescapeHTML(parse_line('Rating'))
      return if !value || value.empty?

      RATING[value] || explode!(:rating, value)
    end

    def score
      value = parse_line('Score').to_f.round(2)

      if value >= 9.9
        0
      else
        value
      end
    end

    def ranked
      parse_line('Ranked').tr('#', '').to_i
    end

    def popularity
      parse_line('Popularity').tr('#', '').to_i
    end

    def members
      parse_line('Members').tr(',', '').to_i
    end

    def favorites
      parse_line('Favorites').tr(',', '').to_i
    end

    def synopsis
      return if no_synopsis?

      fix_synopsis parse_synopsis
    end

    def related
      parse_related_old.each_with_object(parse_related_new) do |(relation, entries), memo|
        memo[relation] ||= []
        memo[relation] += entries
      end
    end

    def external_links
      doc
        .css('.external_links')
        .flat_map do |node|
          node.css('a')&.map do |v|
            url = v.attr(:href)
            kind = extract_external_link_kind(v.text, url)
            next if url == '#' || !kind

            { kind:, url: }
          end
        end
        .compact
    end

    def dates
      @dates ||= parse_line(self.class::AIRED_FIELD)
        .split(' to ')
        .map { |date| parse_date date.strip }
    end

    def parse_synopsis
      at_css(
        'p[itemprop="description"],span[itemprop="description"]'
      )&.inner_html
    end

    def extract_external_link_kind text, url
      fixed_text = text.delete(' ').gsub(/(?<!^)([A-Z]+)/, '_\1').downcase

      return 'twitter' if url.include? 'twitter.com'
      return if fixed_text == 'syoboi'

      EXTERNAL_LINKS_KIND[fixed_text] || fixed_text
    end

    def parse_related_new
      css('.related-entries .entries-tile .entry .content')
        .each_with_object({}) do |doc, memo|
          value = doc.css('.relation').text.strip.split("\n").first&.downcase
          relation = RELATED[value] || explode!(:related, value)

          memo[relation] ||= []
          memo[relation].push(parse_link(doc.css('.title a').first, with_type: true))
        end
    end

    def parse_related_old # rubocop:disable Metrics/AbcSize
      css('.related-entries table.entries-table tr')
        .each_with_object({}) do |tr, memo|
          tds = tr.css('td')
          value = tds.first.text.sub(/:$/, '').strip.downcase
          relation = RELATED[value] || explode!(:related, value)

          memo[relation] = tds.last
            .css('a')
            .reject { |link| link.text == '' }
            .map { |link| parse_link link, with_type: true }
            .compact
        end
    end
  end
end
