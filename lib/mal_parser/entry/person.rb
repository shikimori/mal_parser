module MalParser
  class Entry::Person < Entry::Base
    FIELDS = Entry::Base::FIELDS + %i(
      japanese website birthday
    )

  private

    def japanese
      family_name = parse_line('Family name')
      given_name = parse_line('Given name')

      "#{family_name} #{given_name}" if family_name && !family_name.empty?
    end

    def website
      link = dark_texts
        .find { |v| v.text.start_with? 'Website' }
        &.next&.next&.attr(:href)

      link if link && link != ''
    end

    def birthday
      parse_date parse_line('Birthday')
    end

    def type
      :people
    end
  end
end
