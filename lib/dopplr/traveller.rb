module Dopplr
  class Traveller
    def initialize(client, username)
      @client = client
      @username = username
      @token = client.token
    end
    
    def info
      @client.fetch('traveller_info', :traveller => @username)
    end
    
    def fellows
      @client.fetch('fellows', :traveller => @username)
    end
    
    def trips
      @client.fetch('trips_info', :traveller => @username)
    end
    
    def future_trips
      @client.fetch('future_trips_info', :traveller => @username)
    end
    
    def fellows_travelling_today
      @client.fetch('fellows_travellingtoday', :traveller => @username)
    end
    
    def tag(tag)
      @client.fetch('tag', {:traveller => @username, :tag => tag})
    end
    
    def location_on_date(date)
      @client.fetch('location_on_date', {:traveller => @username, :date => date})
    end
  end
end