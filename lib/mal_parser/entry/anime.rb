module MalParser
  # rubocop:disable ClassLength
  class Entry::Anime < Entry::Base
    FIELDS = Entry::Base::FIELDS + %i(
      english japanese synonyms kind episodes status aired_on released_on
      broadcast studios origin genres duration rating
      score ranked popularity members favorites
    )
      # description related

  STATUSES = {
    'Not yet aired' => 'anons',
    'Currently Airing' => 'ongoing',
    'Finished Airing' => 'released'
  }
  RATINGS = {
    'None' => 'none',
    'G - All Ages' => 'g',
    'PG - Children' => 'pg',
    'PG-13 - Teens 13 or older' => 'pg_13',
    'R - 17+ (violence & profanity)' => 'r',
    'R+ - Mild Nudity' => 'r_plus',
    'Rx - Hentai' => 'rx'
  }

  private

    def parse_english
      extract_line 'English'
    end

    def parse_japanese
      extract_line 'Japanese'
    end

    def parse_synonyms
      extract_line('Synonyms').split(',').map(&:strip)
    end

    def parse_kind
      value = extract_line('Type')&.downcase
      value if value && !value.empty? && value != 'unknown'
    end

    def parse_episodes
      value = extract_line('Episodes').to_i
      value if value > 0
    end

    def parse_status
      STATUSES[extract_line('Status')]
    end

    def parse_aired_on
      dates[0]
    end

    def parse_released_on
      dates[1]
    end

    def parse_broadcast
      value = extract_line('Broadcast')
      value if value && !value.empty? && value != 'Unknown'
    end

    def parse_studios
      extract_links('Studios')
    end

    def parse_origin
      extract_line('Source')
    end

    def parse_genres
      extract_links('Genres')
    end

    def parse_duration
      value = extract_line('Duration')
      (value.match(/(\d+) hr./) ? $1.to_i * 60 : 0) +
        (value.match(/(\d+) min./) ? $1.to_i : 0)
    end

    def parse_rating
      RATINGS[CGI::unescapeHTML(extract_line('Rating'))]
    end

    def parse_score
      value = extract_line('Score').to_f

      if value >= 9.9
        0
      else
        value
      end
    end

    def parse_ranked
      extract_line('Ranked').tr('#', '').to_i
    end

    def parse_popularity
      extract_line('Popularity').tr('#', '').to_i
    end

    def parse_members
      extract_line('Members').tr(',', '').to_i
    end

    def parse_favorites
      extract_line('Favorites').tr(',', '').to_i
    end

    def parse_description
    end

    def parse_related
    end

    def dates
      @dates ||= extract_line('Aired')
        .split(' to ')
        .map { |date| extract_date date }
    end
  end
  # rubocop:enable ClassLength
end
