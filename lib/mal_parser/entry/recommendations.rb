module MalParser
  class Entry::Recommendations
    include ParseHelper
    method_object :id, :type

    def call
      css('div.borderClass > table .picSurround a').map do |node|
        recommendation = parse_link node, with_type: true
        recommendation.delete :name
        recommendation
      end
    end

    def url
      "#{URL_BASE}/#{type}/#{@id}/zzz/userrecs"
    end
  end
end
