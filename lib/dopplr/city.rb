module Dopplr
  class City
    attr_reader :name, :region, :country, :timezone, :localtime, :latitude, :longitude,
      :geoname_id, :country_code, :woeid, :rgb, :utc_offset, :dopplr_url, :mobile_url
    
    def initialize(client, geoname_id, source = nil)
      @client = client
      @geoname_id = geoname_id
      populate(source)
    end
    
    def populate(source)
      info = source || @client.post('/city_info', :geoname_id => @geoname_id)['city_info']
      @name         = info['name']
      @region       = info['region']
      @country      = info['country']
      @timezone     = info['timezone']
      @latitude     = info['lat']
      @longitude    = info['lng']
      @country_code = info['country_code']
      @woeid        = info['woeid']
      @rgb          = info['rgb']
      @utc_offset   = info['utcoffset']
      @dopplr_url   = info['dopplr_url']
      @mobile_url   = info['mobile_url']
      @localtime    = Time.parse(info['localtime'].slice(0..9))
    end
  end
end