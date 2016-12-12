module MalParser
  class CatalogPage
    method_object [:type!, :page, :sorting]

    ENTRIES_PER_PAGE = 50
    DEFAULT_SORTING = 'name'
    SORTINGS = {
      name: 0,
      updated_at: 9
    }

    def call
      doc = Nokogiri::HTML(html)
      doc.css('table a.hoverinfo_trigger.fw-b').map do |node|
        url = node.attr('href')

        {
          id: url.match(%r{/(?<id>\d+)(/|$)})[:id].to_i,
          name: node.text,
          url: url
        }
      end
    end

  private

    def html
      MalParser.configuration.http_get.call(url)
    end

    def url
      "https://myanimelist.net/#{@type}.php?show=#{show_param}&o=#{o_param}"
    end

    def o_param
      SORTINGS[(@sorting || DEFAULT_SORTING).to_sym]
    end

    def show_param
      (@page || 0) * ENTRIES_PER_PAGE
    end
  end
end
