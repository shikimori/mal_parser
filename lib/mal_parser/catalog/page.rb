module MalParser
  class Catalog::Page
    include ParseHelper

    method_object [:type!, :page, :sorting]

    ENTRIES_PER_PAGE = 50
    DEFAULT_SORTING = 'name'
    SORTINGS = {
      name: 0,
      updated_at: 9
    }

    def call
      css('table a.hoverinfo_trigger.fw-b').map { |node| extract_link node }
    end

  private

    def url
      "#{URL_BASE}/#{@type}.php?show=#{show_param}&o=#{o_param}"
    end

    def o_param
      SORTINGS[(@sorting || DEFAULT_SORTING).to_sym]
    end

    def show_param
      (@page || 0) * ENTRIES_PER_PAGE
    end
  end
end
