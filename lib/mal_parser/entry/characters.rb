module MalParser
  class Entry::Characters
    include ParseHelper
    method_object :id, :type

    def call
      roles_doc = doc.css('div#content > table tr > td > div > table')

      {
        characters: extract_roles(roles_doc, 'character'),
        staff: extract_author_roles + extract_roles(roles_doc, 'people')
      }
    end

  private

    def extract_roles doc, url_variant
      doc
        .map { |role_doc| parse_role role_doc.css('td')[1], url_variant }
        .compact
    end

    def parse_role node, url_variant
      url = node.at_css('a')&.attr(:href)
      return unless url && url =~ %r{/#{url_variant}/}

      {
        id: extract_id(url),
        role: node.css('small').text
      }
    end

    def extract_author_roles
      links = dark_texts
        .find { |v| v.text.start_with? 'Authors:' }&.parent&.css('a')

      return [] unless links

      links.map do |v|
        {
          id: parse_link(v)[:id],
          role: v.next.text.strip.gsub(/[()]|,$/, '')
        }
      end
    end

    def url
      "#{URL_BASE}/#{type}/#{@id}/zzz/characters"
    end
  end
end
