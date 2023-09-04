module MalParser
  class Entry::MoreInfo
    include ParseHelper

    method_object :id, :type

    def call
      (
        (css('h2').find { |node| node.text == 'More Info' }&.next&.text || '') +
          ' [MAL]'
      ).strip
    end

    def url
      "#{URL_BASE}/#{type}/#{@id}/zzz/moreinfo"
    end
  end
end
