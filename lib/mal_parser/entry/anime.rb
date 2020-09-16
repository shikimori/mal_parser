module MalParser
  class Entry::Anime < Entry::Base # rubocop:disable Metrics/ClassLength
    FIELDS = Entry::Base::FIELDS + %i[
      english japanese synonyms kind episodes status aired_on released_on
      broadcast studios origin genres duration rating
      score ranked popularity members favorites synopsis related
      external_links season
    ]
    AIRED_FIELD = 'Aired'

    KIND = {
      'Movie' => :movie,
      'Music' => :music,
      'TV' => :tv,
      'Special' => :special,
      'OVA' => :ova,
      'ONA' => :ona
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
      'Adaptation' => :adaptation,
      'Alternative setting' => :alternative_setting,
      'Alternative version' => :alternative_version,
      'Character' => :character,
      'Full story' => :full_story,
      'Other' => :other,
      'Parent story' => :parent_story,
      'Prequel' => :prequel,
      'Sequel' => :sequel,
      'Side story' => :side_story,
      'Spin-off' => :spin_off,
      'Summary' => :summary
    }

  private

    def english
      parse_line 'English'
    end

    def japanese
      parse_line 'Japanese'
    end

    def synonyms
      parse_line('Synonyms')&.split(',')&.map(&:strip) || []
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

    def studios
      parse_links('Studios')
    end

    def origin
      (parse_line('Source') || 'unknown').downcase.tr(' ', '_').to_sym
    end

    def genres
      parse_links('Genres')
    end

    def duration
      value = parse_line('Duration')

      hours = $LAST_MATCH_INFO[:hours] if value =~ /(?<hours>\d+) hr./
      minutes = $LAST_MATCH_INFO[:minutes] if value =~ /(?<minutes>\d+) min./

      hours.to_i * 60 + minutes.to_i
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
      parse_related.each_with_object({}) do |tr, memo|
        tds = tr.css('td')
        value = tds.first.text.sub(/:$/, '')
        relation = RELATED[value] || explode!(:related, value)

        memo[relation] = tds.last
          .css('a')
          .reject { |link| link.text == '' }
          .map { |link| parse_link link, with_type: true }
          .compact
      end
    end

    def external_links
      at_css('table td h2:contains("External Links")')
        &.next_element
        &.css('a')
        &.map do |v|
          {
            kind: v.text.delete(' ').gsub(/(?<!^)([A-Z]+)/, '_\1').downcase,
            url: v.attr(:href)
          }
        end
    end

    def dates
      @dates ||= parse_line(self.class::AIRED_FIELD)
        .split(' to ')
        .map { |date| parse_date date }
    end

    def parse_synopsis
      at_css(
        'p[itemprop="description"],span[itemprop="description"]'
      )&.inner_html
    end

    def parse_related
      css('table.anime_detail_related_anime tr')
    end
  end
end
