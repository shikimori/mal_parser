module MalParser
  class Entry::Characters
    include ParseHelper
    method_object :id, :type

    NO_CHARACTERS = [
      'Add staff</a> for this anime',
      'No staff for this anime',
      'Edit Manga Information',
      'No staff for this manga'
    ]

    def call
      characters_doc = doc.css('div#content > table tr > td > div > table')
      unless NO_CHARACTERS.any? { |phrase| html.include? phrase }
        staff_doc = characters_doc.pop
      end

      {
        characters: extract_characters(characters_doc),
        staff: staff_doc ? extract_staff(staff_doc) : []
      }
    end

  private

    def extract_characters doc
      doc
        .map { |role_doc| parse_role role_doc.css('td')[1] }
        .compact
    end

    def extract_staff doc
      doc.css('tr td:last')
        .map { |node| parse_role node }
        .compact
    end

    def parse_role node
      link = node.at_css('a')
      return unless link

      {
        id: extract_id(link.attr(:href)),
        role: node.css('small').text
      }
    end

    def url
      "#{URL_BASE}/#{type}/#{@id}/zzz/characters"
    end
  end
end
