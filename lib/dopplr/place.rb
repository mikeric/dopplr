module Dopplr
  class Place
    attr_reader :name, :kind, :address, :phone, :geohash, :latitude, :longitude,
      :green_blocks, :vote, :links, :tags, :url, :dopplr_url, :short_url, :city
    
    def initialize(client, place_id, source = nil)
      @client = client
      @place_id = place_id
      populate(source)
    end
    
    def populate(source)
      info = source || @client.get('/place_info', :place_id => @place_id)['place_info']
      @name         = info['name']
      @kind         = info['kind']
      @address      = info['address']
      @phone        = info['phone']
      @geohash      = info['geohash']
      @latitude     = info['lat']
      @longitude    = info['lng']
      @green_blocks = info['green_blocks']
      @vote         = info['vote']
      @links        = info['links']
      @tags         = info['tags']
      @url          = info['url']
      @dopplr_url   = info['dopplr_url']
      @short_url    = info['short_url']
      @city         = City.new(@client, info['city']['geoname_id'], info['city'])
    end
  end
end