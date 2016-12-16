require 'open-uri'

module MalParser
  class Configuration
    attr_accessor :http_get

    HTTP_GET = lambda do |url|
      begin
        open(url).read
      rescue OpenURI::HTTPError => e
        raise unless e.message =~ /404 Not Found/
      end
    end

    def initialize
      @http_get = HTTP_GET
    end
  end
end
