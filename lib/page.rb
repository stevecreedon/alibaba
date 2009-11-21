require 'mechanize'
require "lib/link"

class Page < ActiveRecord::Base
  
  has_many :links
  has_many :headings
  has_many :titles
  validates_uniqueness_of :url

  def scrape
    
    agent = WWW::Mechanize.new
      
    mech_page = agent.get(url)
  
    mech_page.links.each do |link|
      begin
        href = clean_href(link.href)
        uri = (href && URI.parse(href))
        Link.create(:text => link.text, :page => self, :url => build_url(mech_page, link)) 
      rescue => e
        p "error: #{e.class} #{e.message}"
      end
    end
    
    mech_page.root.css("title").each do |title|
      Title.create!(:text => title.text, :page => self)
    end
    
    (1..6).each do |size|
      mech_page.root.css("h#{size}").each do |title|
        Heading.create!(:text => title.text, :page => self, :size => size)
      end
    end
    
  end
  
  def self.next(domain)
    Page.find(:first, :conditions => ["url like ? AND scraped  = ?", "%#{domain}%", false])
  end
  
  private
  
  def build_url(mech_page, link)
     href = clean_href(link.href)
     return mech_page.uri.host + href if href[0] == '/'
     return href if href[0, 4] == 'http'
     return mech_page.uri.to_s.gsub(/[^\/]*$/, "") + href
  end
  
  def clean_href(href)
    href.strip!
    href.gsub!(" ", "%20")
    return href
  end
  
end