module MalParser
  class Entry::Person < Entry::Base
    FIELDS = Entry::Base::FIELDS + %i[
      japanese website birth_on
    ]

  private

    def japanese
      family_name = parse_line('Family name')
      given_name = parse_line('Given name')

      "#{family_name} #{given_name}".strip
    end

    def website
      link = dark_texts
        .find { |v| v.text.start_with? 'Website' }
        &.next&.next&.attr(:href)

      link unless [nil, '', 'http://', 'https://'].include?(link)
    end

    def birth_on
      value = parse_date(parse_line('Birthday'))

      if value&.year == Date.today.year
        Date.parse "1901-#{value.month}-#{value.day}"
      else
        value
      end
    end

    def type
      :people
    end
  end
end
