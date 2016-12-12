module MalParser
  class Entry::Base
    method_object :id

    def call
      doc = Nokogiri::HTML html
      {
        id: @id,
        name: parse_name(doc),
        image: parse_image(doc)
      }
    end

  private

    def parse_name doc
      doc.css('meta[property="og:title"]').first&.attr(:content)
    end

    def parse_image doc
      doc.css('meta[property="og:image"]').first&.attr(:content)
    end

    def html
      MalParser.configuration.http_get.call(url)
    end

    def url
      "#{URL_BASE}/#{type}/#{@id}"
    end

    def type
      self.class.name.sub(/.*::/, '')
    end
  end
end
