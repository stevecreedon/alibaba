class Mechanized
  
  @@agents = {}
  
  def self.agent(key, klass=WWW::Mechanize)
    
    unless @@agents.has_key?(key)
      
      agent = klass.new
      
      if agent.respond_to?(:login)
        agent.login
      end
      
      @@agents[key] = agent
    end
    
    return @@agents[key]    
    
  end
  
end