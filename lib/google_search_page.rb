require 'mechanize'

class GoogleSearchPage
  
  def initialize(page)
    @page = page
  end
  
  def uri
    return @page.uri
  end
  
  def right_bar_ads
     return @page.parser.css("td#rhsline ol > li").size
  end
  
  def top_ads
    div = @page.parser.css("div#tads ol > li").size
  end
  
  def next_url
    page = current + 10
    @page.uri.to_s.gsub("start=#{current}", "start=#{page}")
  end
  
  def previous_url
    return page.uri if current == 0
    page = current - 10
    @page.uri.to_s.gsub("start=#{current}", "start=#{page}")
  end
  
  private
  
  def current
    @page.uri.to_s =~ /start=(\d*)/
    page = $1.to_i
    page
  end
  
end