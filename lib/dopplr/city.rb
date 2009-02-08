module Dopplr
  class City
    attr_accessor :id
    
    def initialize(client, id)
      @client = client
      @id = id
      @token = client.token
    end
    
    def info
      @client.call "/api/city_info?geoname_id=#{@id}"
    end
    
    def tips
      @client.call "/api/tips?geoname_id=#{@id}"
    end
  end
end