module MalParser
  module ParseHelper
    NOKOGIRI_SAVE_OPTIONS = Nokogiri::XML::Node::SaveOptions::AS_HTML |
      Nokogiri::XML::Node::SaveOptions::NO_DECLARATION

    NO_SYNOPSIS_TEXT = [
      'No synopsis has been added for this',
      'No biography written.',
      'No summary yet.'
    ]
    TYPE = {
      'anime' => :anime,
      'manga' => :manga,
      'people' => :person,
      'character' => :character
    }

    def css *args
      @doc ||= Nokogiri::HTML html
      @doc.css(*args)
    end

    def html
      @html ||= MalParser.configuration.http_get.call url
    end

    def parse_line text
      node = dark_texts.find { |v| v.text.start_with? "#{text}:" }&.next
      return unless node

      text = node.text.strip
      text.empty? ? node.next&.text&.strip : text
    end

    def parse_links text
      dark_texts
        .find { |v| v.text.start_with? "#{text}:" }
        &.parent
        &.css('a')
        &.map { |node| parse_link node }
    end

    def parse_link node, with_type: false
      url = node.attr 'href'

      if with_type
        { id: extract_id(url), name: node.text, type: extract_type(url) }
      else
        { id: extract_id(url), name: node.text }
      end
    end

    def dark_texts
      @dark_texts ||= css('span.dark_text')
    end

    def parse_date date
      # if date.match /^\w+\s+\d+,$/
        # nil
      # elsif date.match(/^\d+$/)
      if date =~ /^\d+$/
        Date.new date.to_i
      else
        Date.parse(date)
      end

    rescue StandardError
      nil
    end

    def extract_id url
      url.match(%r{/(?<id>\d+)(/|$)})[:id].to_i
    end

    def extract_type url
      value = url.match(%r{^/(?<type>anime|manga|people)/})[:type]
      TYPE[value] || explode!(:type, value)
    end

    def fix_synopsis html
      fixed_text = Nokogiri::HTML::DocumentFragment
        .parse(html)
        .to_html(save_with: ParseHelper::NOKOGIRI_SAVE_OPTIONS)

      CGI.unescapeHTML(fixed_text) unless fixed_text&.empty?
    end

    def no_synopsis?
      NO_SYNOPSIS_TEXT.any? { |phrase| html.include? phrase }
    end
  end
end
