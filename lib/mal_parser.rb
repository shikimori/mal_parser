require 'mal_parser/version'
require 'open-uri'
require 'attr_extras'
require 'nokogiri'
require 'English'

module MalParser
  autoload :Configuration, 'mal_parser/configuration'
  autoload :ParseHelper, 'mal_parser/parse_helper'

  module Catalog
    autoload :Page, 'mal_parser/catalog/page'
  end

  module Entry
    autoload :Base, 'mal_parser/entry/base'
    autoload :Anime, 'mal_parser/entry/anime'
    autoload :Manga, 'mal_parser/entry/manga'
    autoload :Character, 'mal_parser/entry/character'
    autoload :Person, 'mal_parser/entry/person'
  end

  class UnexpectedValue < StandardError
    def initialize klass:, param:, value:, id: nil
      id_text = " id=#{id}" if id
      super "Unexpected #{param} `#{value}` for #{klass.name}#{id_text}"
    end
  end

  URL_BASE = 'https://myanimelist.net'

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield configuration
  end
end
