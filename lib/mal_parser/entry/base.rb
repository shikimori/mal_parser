module MalParser
  class Entry::Base
    include ParseHelper

    method_object :id
    FIELDS = %i(id name image)

    def call
      self.class::FIELDS.each_with_object({}) do |field, memo|
        memo[field] = send field
      end
    end

  private

    def name
      doc.css('meta[property="og:title"]').first&.attr(:content)
    end

    def image
      doc.css('meta[property="og:image"]').first&.attr(:content)
    end

    def url
      "#{URL_BASE}/#{type}/#{@id}"
    end

    def type
      self.class.name.sub(/.*::/, '').downcase
    end

    def explode! param, value
      raise UnexpectedValue,
        parser_klass: self.class,
        id: @id,
        param: param,
        value: value
    end
  end
end
