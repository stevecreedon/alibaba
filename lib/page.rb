require 'mechanize'
require "lib/link"

class Page
  
  def initialize(url)
    @url = url #needed because bad data has got into system
    p "#>>#{@url}"
  end
  
  def scrape
    
    agent = WWW::Mechanize.new  
    page = agent.get(@url)
    
    page.links.each do |link|
      begin
        href = clean_href(link.href)
        uri = (href && URI.parse(href))
        Link.create(:text => link.text, :page => page.uri.to_s, :url => build_url(page, link)) 
      rescue => e
        p "error: #{e.class} #{e.message}"
      end
    end
    
  end
  
  private 
  
  def build_url(page, link)
     href = clean_href(link.href)
     return page.uri.host + href if href[0] == '/'
     return href if href[0, 4] == 'http'
     return page.uri.to_s.gsub(/[^\/]*$/, "") + href
  end
  
  def clean_href(href)
    href.strip!
    href.gsub!(" ", "%20")
    return href
  end
  
end