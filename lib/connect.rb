require "yaml"
require "active_record" 

module Connector
  def self.connect
    ActiveRecord::Base.establish_connection(YAML.load_file("config/database.yml"))
  end
end