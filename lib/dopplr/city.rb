module Dopplr
  class City
    attr_reader :name, :country, :timezone, :localtime, :latitude, :longitude
    attr_reader :geoname_id, :country_code, :woeid, :rgb, :utc_offset, :url
    
    def initialize(client, id)
      @client = client
      @geoname_id = id
      populate
    end
    
    def populate
      info = @client.get('city_info', :geoname_id => @geoname_id)['city']
      @name         = info['name']
      @country      = info['country']
      @timezone     = info['timezone']
      @latitude     = info['latitude']
      @longitude    = info['longitude']
      @country_code = info['country_code']
      @woeid        = info['woeid']
      @rgb          = info['rgb']
      @utc_offset   = info['utcoffset']
      @url          = info['url']
      @localtime    = Time.parse(info['localtime'].slice(0..-7))
    end
  end
end