module Dopplr
  class City
    attr_accessor :id
    
    def initialize(client, city_id)
      @client = client
      @id = city_id
      @token = client.token
    end
    
    def info
      @client.fetch "/api/city_info?geoname_id=#{@id}"
    end
    
    def tips
      @client.fetch "/api/tips?geoname_id=#{@id}"
    end
  end
end