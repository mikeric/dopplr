module Dopplr
  class CitySearch
    def initialize(client, params={})
      @client = client
      @params = params
    end
    
    def results
      response = @client.get('/city_search', @params)
      raise response['error']['message'] if response['error']
      
      response['city_search']['results'].map do |city|
        City.new(@client, city['geoname_id'], city)
      end
    end
  end
end