module Dopplr
  class Trip
    attr_reader :trip_id, :nick, :start, :finish, :public_note, :private_note, :geoname_id, :outgoing_transport_type, :return_transport_type, :dopplr_url, :mobile_url
    
    def initialize(client, trip_id, source = nil)
      @client = client
      @trip_id = trip_id
      populate(source)
    end
    
    def populate(source)
      info = source || @client.post('/trip_info', :trip_id => @trip_id)['trip_info']
      @trip_id                    = info['trip_id']
      @nick                       = info['nick']
      @start                      = Time.parse(info['start'].slice(0..9))
      @finish                     = Time.parse(info['finish'].slice(0..9))
      @public_note                = info['public_note']
      @private_note               = info['private_note']
      @geoname_id                 = info['geoname_id']
      @outgoing_transport_type    = info['outgoing_transport_type']
      @return_transport_type      = info['return_transport_type']
      @dopplr_url                 = info['dopplr_url']
      @mobile_url                 = info['mobile_url']
    end
  end
end