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

    def parse_line text, can_be_plural: false # rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
      node = dark_texts
        .find do |text_node|
          text_node.text.start_with?("#{text}:") || (
            can_be_plural && text_node.text.start_with?("#{text}s:")
          )
        end
        &.next
      return unless node

      text = node.text.strip
      text.empty? && node.next&.name != 'div' ? node.next&.text&.strip : text
    end

    def parse_links text, can_be_plural: false # rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
      node = dark_texts
        .find do |text_node|
          text_node.text.start_with?("#{text}:") || (
            can_be_plural && text_node.text.start_with?("#{text}s:")
          )
        end
        &.parent

      if !node || node.text =~ /None found/
        []
      else
        node&.css('a')&.map { |v| parse_link v }&.uniq
      end
    end

    def parse_link node, with_type: false
      url = node.attr 'href'
      name = node.text.strip

      if with_type
        { id: extract_id(url), name: name, type: extract_type(url) }
      else
        { id: extract_id(url), name: name }
      end
    end

    def dark_texts
      @dark_texts ||= css('span.dark_text')
    end

    def parse_date date # rubocop:disable Metrics/MethodLength
      fixed_date = date.gsub(/^, /, '').gsub(/ ,/, '')

      case date
        when '?' then nil
        when /^\d+$/ then { year: fixed_date.to_i }
        else
          parsed_date = Date.parse fixed_date
          case fixed_date
            when /^\w+ +\d{4}$/
              { year: parsed_date.year, month: parsed_date.month }
            when /^\w+ +\d{1,2}$/
              { month: parsed_date.month, day: parsed_date.day }
            else
              { year: parsed_date.year, month: parsed_date.month, day: parsed_date.day }
          end
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
