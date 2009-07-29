module Dopplr
  class Traveller
    def initialize(client, username)
      @client = client
      @username = username
    end
    
    def info
      @client.get 'traveller_info', :traveller => @username
    end
    
    def fellows
      @client.get 'fellows', :traveller => @username
    end
    
    def trips
      @client.get 'trips_info', :traveller => @username
    end
    
    def future_trips
      @client.get 'future_trips_info', :traveller => @username
    end
    
    def fellows_travelling_today
      @client.get 'fellows_travellingtoday', :traveller => @username
    end
    
    def tag(tag)
      @client.get 'tag', :traveller => @username, :tag => tag
    end
    
    def location_on_date(date)
      @client.get 'location_on_date', :traveller => @username, :date => date
    end
  end
end