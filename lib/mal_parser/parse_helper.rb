module MalParser
  module ParseHelper # rubocop:disable Metrics/ModuleLength
    NOKOGIRI_SAVE_OPTIONS = Nokogiri::XML::Node::SaveOptions::AS_HTML |
      Nokogiri::XML::Node::SaveOptions::NO_DECLARATION

    NO_SYNOPSIS_TEXT = [
      'No synopsis has been added for this',
      'No synopsis information has been added to this',
      'No biography written.',
      'No summary yet.'
    ]
    TYPE = {
      'anime' => :anime,
      'manga' => :manga,
      'people' => :person,
      'character' => :character
    }
    TYPE_REGEXP = %r{
      (?: ^ | (?:https:)?//myanimelist.net)
      /(?<type>#{TYPE.keys.join '|'})/
    }mix
    INVALID_ID_REGEXP = /<div class="badresult">Invalid ID provided/

    SPOILER_BLOCK_REGEXP = %r{
      <div\ class="spoiler" .*? value="Hide\ spoiler">
        (.*?)
      </span></div>
    }mix

    ID_REGEXP = %r{/(?<id>\d+)(?:/|$)}

    def doc
      @doc ||= Nokogiri::HTML html
    end

    def css selector
      doc.css selector
    end

    def at_css selector
      doc.at_css selector
    end

    def html
      @html ||= MalParser.configuration.http_get.call url

      if @html.nil? || @html =~ INVALID_ID_REGEXP
        raise RecordNotFound
      else
        @html
      end
    end

    def parse_line text # rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
      node = dark_texts.find { |v| v.text.start_with? "#{text}:" }&.next
      return unless node

      text = node.text.strip
      text.empty? && node.next&.name != 'div' ? node.next&.text&.strip : text
    end

    def parse_links text # rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
      node = dark_texts.find { |v| v.text.start_with? "#{text}:" }&.parent

      if !node || node.text =~ /None found/
        []
      else
        node&.css('a')&.map { |v| parse_link v }&.uniq
      end
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
      url.match(ID_REGEXP)[:id].to_i
    end

    def extract_type url
      value = $LAST_MATCH_INFO[:type] if url =~ TYPE_REGEXP

      TYPE[value] || explode!(:type, value)
    end

    def fix_synopsis html
      fixed_text = Nokogiri::HTML::DocumentFragment
        .parse(html)
        .to_html(save_with: ParseHelper::NOKOGIRI_SAVE_OPTIONS)
        .gsub(/\r|\n/, '')
        .gsub(SPOILER_BLOCK_REGEXP, '[spoiler_block=Spoiler]\1[/spoiler_block]')

      CGI.unescapeHTML(fixed_text) unless fixed_text&.empty?
    end

    def no_synopsis?
      NO_SYNOPSIS_TEXT.any? { |phrase| html.include? phrase }
    end

    def explode! param, value
      raise UnexpectedValue,
        klass: self.class,
        id: @id,
        param: param,
        value: value
    end
  end
end
