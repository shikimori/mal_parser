module MalParser
  class Entry::Manga < Entry::Anime
    FIELDS = Entry::Base::FIELDS + %i(
      english japanese synonyms kind volumes chapters status
      aired_on released_on publishers genres
      score ranked popularity members favorites synopsis related
    )
    AIRED_FIELD = 'Published'

    KIND = {
      'Doujin' => :doujin,
      'Doujinshi' => :doujin,
      'Manga' => :manga,
      'Manhua' => :manhua,
      'Manhwa' => :manhwa,
      'Novel' => :novel,
      'One Shot' => :one_shot,
      'One-Shot' => :one_shot
    }
    STATUS = {
      'Not yet aired' => :anons,
      'Not yet published' => :anons,
      'Publishing' => :ongoing,
      'Finished' => :released
    }

  private

    def volumes
      value = parse_line('Volumes').to_i
      value if value.positive?
    end

    def chapters
      value = parse_line('Chapters').to_i
      value if value.positive?
    end

    def publishers
      parse_links('Serialization')
    end
  end
end
