class MalParser::Entry::Base
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
