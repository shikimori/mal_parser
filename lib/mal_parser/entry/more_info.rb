module MalParser
  class Entry::MoreInfo
    include ParseHelper

    method_object :id, :type

    def call
      more_info_node = css('h2').find { |node| node.text == 'More Info' }
      return unless more_info_node&.next && more_info_node&.next&.text != ''

      (next_texts(more_info_node.next) + ' [MAL]').strip
    end

    def url
      "#{URL_BASE}/#{type}/#{@id}/zzz/moreinfo"
    end

    def next_texts node
      return '' if node.nil? || node.name == 'div'

      (node.name == 'br' ? "\n" : node.text.strip) + next_texts(node.next)
    end
  end
end
