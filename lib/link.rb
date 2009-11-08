require 'active_record'

class Link < ActiveRecord::Base
  
  validates_uniqueness_of :url
  validates_presence_of :text
  
  def self.next(domain)
    Link.find(:first, :conditions => ["url like ? AND scraped IS NULL", "%#{domain}%"])
  end
  
end