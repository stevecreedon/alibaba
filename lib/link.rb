require 'active_record'

class Link < ActiveRecord::Base
  belongs_to :page

  validates_presence_of :text, :url
  before_save Proc.new{|link| Page.create(:url => link.url, :scraped => false)} #if the url isn't unique the page wont be created
  
  
end