module Dopplr
  class City
    def initialize(client, city_id)
      @client = client
      @id = city_id
      @token = client.token
    end
    
    def info
      @client.fetch('city_info', :geoname_id => @id)
    end
    
    def tips
      @client.fetch('tips', :geoname_id => @id)
    end
  end
end