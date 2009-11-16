require 'rubygems'
require 'mechanize'

class Insight

  def self.process(query)
    
    geo = "GB" #UK Search only
    
    q = ARGV.collect do |arg|
      arg.gsub(" ", "%20")
    end
  
    agent = WWW::Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    
    page = agent.get("http://www.google.com/insights/search/overviewReport?q=#{q.join("%2C")}&cmpt=q&content=1&geo=#{geo}&date=today%2012-m")
    totals = page.parser.css("div.totalsBody div")
    
    p "seems you've reached the damn Google quota, try again later" and return if page.parser.to_html.include?("quota")
    
    totals.each_with_index do |div, index|
      p "#{q[index].gsub("%20"," ")}: #{div.attributes['style'].text.gsub(/.*width:/, "").gsub(/px;;/,"")}"
    end
    
  end

end
