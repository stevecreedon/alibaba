require 'rubygems'
require 'nokogiri'
require "lib/page"
require "lib/heading"
require "lib/link"
require "lib/title"

class Root
  
  def self.process
    
    domain = "alibaba.com"
    site = "http://www.alibaba.com/" 
    Link.delete_all
    Page.delete_all
    Heading.delete_all
    Title.delete_all

    Page.create(:url => site, :scraped => false)
    
    while(!(page = Page.next(domain)).nil?)
      
      begin
        page.scrape
        page.scraped = true
        page.save!
        p "visited #{page.url}"
      rescue => e
        page.destroy
        p "error #{e.message} link #{page.url} deleted"
      end
      
    end
    
  end
  
  
  
end