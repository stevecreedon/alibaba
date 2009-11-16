require 'rubygems'
require 'mechanize'
require 'google_search_page'

class GoogleSearch
  
  def initialize(q)
    @q = q
    @agent = WWW::Mechanize.new
    @agent.user_agent_alias = 'Mac Safari'
  end
  
  def first
    @current_page = get_page("http://www.google.co.uk/search?hl=en&q=#{@q.gsub(" ","+")}&start=0&sa=N")
    p @current_page.top_ads
    p @current_page.right_bar_ads
  end
  
  def next
    @current_page = get_page(@current_page.next_url)
    p @current_page.top_ads
    p @current_page.right_bar_ads
  end
  
  def previous
    @current_page = get_page(@current_page.previous_url)
    p @current_page.top_ads
    p @current_page.right_bar_ads
  end
  
  private 
  
  def get_page(url)
    return GoogleSearchPage.new(@agent.get(url))
  end

end