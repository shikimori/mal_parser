module MalParser
  # rubocop:disable ClassLength
  class Entry::Anime < Entry::Base
    FIELDS = Entry::Base::FIELDS + %i(
      english japanese synonyms kind episodes status aired_on released_on
      broadcast
    )
      # description related 
      # genres studios duration
      # rating score ranked popularity members favorites
    # )
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

    def parse_description
    end

    def parse_related
    end

    def parse_genres
    end

    def parse_studios
    end

    def parse_duration
    end

    def parse_rating
    end

    def parse_score
    end

    def parse_ranked
    end

    def parse_popularity
    end

    def parse_members
    end

    def parse_favorites
    end

    def dates
      @dates ||= extract_line('Aired')
        .split(' to ')
        .map { |date| convert_date date }
    end
  end
  # rubocop:enable ClassLength
end
