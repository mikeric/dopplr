module Dopplr
  class Trip
    def initialize(client, trip_id)
      @client = client
      @id = trip_id
      @token = client.token
    end
    
    def info
      @client.fetch('trip_info', :trip_id => @id)
    end
  end
end