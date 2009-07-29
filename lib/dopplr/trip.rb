module Dopplr
  class Trip
    def initialize(client, trip_id)
      @client = client
      @id = trip_id
    end
    
    def info
      @client.get 'trip_info', :trip_id => @id
    end
  end
end