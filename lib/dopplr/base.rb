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
    
    def place(place_id)
      Place.new(client, place_id)
    end
    
    def city_search(params={})
      CitySearch.new(client, params)
    end
    
    def place_search(params={})
      PlaceSearch.new(client, params)
    end
  end
end