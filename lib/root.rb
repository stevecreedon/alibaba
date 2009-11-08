require 'rubygems'
require 'nokogiri'
require "lib/page"



class Root
  
  def self.process
    
    domain = "alibaba.com"
    site = "http://www.alibaba.com" 
    Link.delete_all
    
    Link.create!(:url => site, :text => "home", :page => site)
    
    while(!(link = Link.next(domain)).nil?)
      p = Page.new(link.url)
      begin
        p.scrape
        link.scraped = true
        link.save!
        p "visited #{link.url}"
      rescue
        link.destroy
        p "link #{link.url} deleted"
      end
      
    end
    
  end
  
  
  
end