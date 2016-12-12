require 'mal_parser/version'
require 'open-uri'
require 'attr_extras'
require 'nokogiri'

module MalParser
  autoload :Configuration, 'mal_parser/configuration'

  module Catalog
    autoload :Page, 'mal_parser/catalog/page'
  end

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
