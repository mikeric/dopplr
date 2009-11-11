module Dopplr
  class PlaceSearch
    def initialize(client, params={})
      @client = client
      @params = params
    end
    
    def results
      response = @client.get('/place_search', @params)
      raise response['error']['message'] if response['error']
      
      response['place_search']['results'].map do |place|
        Place.new(@client, place['place_id'], place)
      end
    end
  end
end