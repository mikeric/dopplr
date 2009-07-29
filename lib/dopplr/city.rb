module Dopplr
  class City
    def initialize(client, city_id)
      @client = client
      @id = city_id
    end
    
    def info
      @client.get 'city_info', :geoname_id => @id
    end
    
    def tips
      @client.get 'tips', :geoname_id => @id
    end
  end
end