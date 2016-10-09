require 'open-uri'
require 'nokogiri'

require "marmiton_crawler/version"


module MarmitonCrawler

  class Recipe

    attr_reader :title, :preptime, :cooktime , :ingredients

    MARMITON_HOST = 'http://www.marmiton.org/'

    def initialize(url)
      if url.include? MARMITON_HOST
        @page =  Nokogiri::HTML(open(url))
        @title = @page.css('h1.m_title span.item span.fn').text
        @preptime = @page.css('p.m_content_recette_info span.preptime').text.to_i
        @cooktime = @page.css('p.m_content_recette_info span.cooktime').text.to_i
      else
        raise ArgumentError, "Instantiation cancelled (ulr not from #{MARMITON_HOST})." 
      end
    end
  
  end

end
