module Dopplr
  class Base
    attr_reader :client
    
    def initialize(client)
      @client = client
    end
    
    def traveller(username)
      Traveller.new(client, username)
    end
    
    def city(geoname_id)
      City.new(client, geoname_id)
    end
  end
end