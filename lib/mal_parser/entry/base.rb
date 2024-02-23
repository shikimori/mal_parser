module MalParser
  class Entry::Base
    include ParseHelper

    method_object :id
    FIELDS = %i[id name image]

    def call
      self.class::FIELDS.each_with_object({}) do |field, memo|
        memo[field] = send field
      end
    end

  private

    def name
      meta_name = css('meta[property="og:title"]').first&.attr(:content)&.strip

      if meta_name.match?(/[><]/)
        h1_name
      else
        meta_name
      end
    end

    def h1_name
      css(
        [
          'h1 .h1-title span[itemprop="name"]',
          'h1 span[itemprop="name"]',
          'h1 strong'
        ].join(',')
      ).children.first.text.gsub(/  +/, ' ')
    end

    def image
      url = css('meta[property="og:image"]').first&.attr(:content)
      return if !url || url.match?(/apple-touch-icon/)

      url
    end

    def url
      "#{URL_BASE}/#{type}/#{@id}"
    end

    def type
      self.class.name.sub(/.*::/, '').downcase
    end
  end
end
