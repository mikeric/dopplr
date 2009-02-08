module Dopplr
  class City < Client
    def initialize(client, city_id)
      @token = client.token
      @city_id = city_id
    end
    
    def info
      call "/api/city_info?geoname_id=#{@city_id}"
    end
  end
end