module MalParser
  class Entry::Characters
    include ParseHelper
    method_object :id, :type

    NO_CHARACTERS_1 = 'Add staff</a> for this anime'
    NO_CHARACTERS_2 = 'Edit Manga Information'

    def call
      characters_doc = doc.css('div#content > table tr > td > div > table')
      unless html.include?(NO_CHARACTERS_1) || html.include?(NO_CHARACTERS_2)
        staff_doc = characters_doc.pop
      end

      {
        characters: extract_characters(characters_doc),
        staff: staff_doc ? extract_staff(staff_doc) : []
      }
    end

  private

    def extract_characters doc
      doc.map { |role_doc| parse_role role_doc.css('td')[1] }
    end

    def extract_staff doc
      doc.css('tr td:last').map { |node| parse_role node }
    end

    def parse_role node
      link = node.at_css('a')

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
