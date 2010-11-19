module Dopplr
  class Base
    attr_accessor :client
    
    def initialize(client)
      @client = client
    end
    
    def city(geoname_id)
      City.new(client, geoname_id)
    end
    
    def traveller(username = nil)
      Traveller.new(client, username)
    end
    
    def place(place_id)
      Place.new(client, place_id)
    end
    
    def add_place(place_id, params = {})
      client.post '/traveller_add_place', params.merge(:place_id => place_id)
    end
    
    def city_search(params = {})
      CitySearch.new(client, params)
    end
    
    def place_search(params = {})
      PlaceSearch.new(client, params)
    end
  end
end