require 'open-uri'

module MalParser
  class Configuration
    attr_accessor :http_get

    HTTP_GET = ->(url) { open(url).read }

    def initialize
      @http_get = HTTP_GET
    end
  end
end
