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
      css('meta[property="og:title"]').first&.attr(:content)&.strip
    end

    def image
      url = css('meta[property="og:image"]').first&.attr(:content)
      url if url && url !~ /apple-touch-icon/
    end

    def url
      "#{URL_BASE}/#{type}/#{@id}"
    end

    def type
      self.class.name.sub(/.*::/, '').downcase
    end
  end
end
