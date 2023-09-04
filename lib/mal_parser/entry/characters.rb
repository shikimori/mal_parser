class MalParser::Entry::Characters
  include ParseHelper
  method_object :id, :type

  CSS_SELECTORS = [
    '.anime-character-container > table',
    '.manga-character-container > table',
    'div#content > table tr > td > div > table'
  ]

  def call
    roles_doc = doc.css(CSS_SELECTORS.join(','))

    {
      characters: extract_roles(roles_doc, 'character'),
      staff: extract_author_roles + extract_roles(roles_doc, 'people')
    }
  end

private

  def extract_roles doc, url_variant
    doc
      .map do |role_doc|
        parse_role role_doc.css('td')[1], url_variant
      end
      .compact
  end

  def parse_role node, url_variant
    url = node.at_css('a')&.attr(:href)
    return unless url && url =~ %r{/#{url_variant}/}

    {
      id: extract_id(url),
      roles: url_variant == 'character' ?
        node.css('.spaceit_pad')[1].text.strip.delete_suffix(' ').split(', ') :
        node.css('small').text.split(', ')
    }
  end

  def extract_author_roles
    links = dark_texts
      .find { |v| v.text.start_with? 'Authors:' }&.parent&.css('a')

    return [] unless links

    links.map do |v|
      {
        id: parse_link(v)[:id],
        roles: v.next.text.strip.gsub(/[()]|,$/, '').split(', ')
      }
    end
  end

  def url
    "#{URL_BASE}/#{type}/#{@id}/zzz/characters"
  end
end
