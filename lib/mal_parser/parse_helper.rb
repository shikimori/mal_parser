module MalParser
  module ParseHelper
    def doc
      @doc ||= Nokogiri::HTML MalParser.configuration.http_get.call(url)
    end

    def extract_line text
      node = dark_texts.find { |v| v.text.start_with? "#{text}:" }&.next
      return unless node

      text = node.text.strip
      text.empty? ? node.next&.text&.strip : text
    end

    def extract_links text
      dark_texts
        .find { |v| v.text.start_with? "#{text}:" }
        &.parent
        &.css('a')
        &.map { |node| { id: extract_id(node.attr(:href)), name: node.text } }
    end

    def dark_texts
      @dark_texts ||= doc.css('span.dark_text')
    end

    def extract_date date
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
  end
end
