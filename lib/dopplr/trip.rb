module Dopplr
  class Trip
    attr_reader :start, :finish, :city, :outgoing_transport_type, :return_transport_type, :tags, :notes
    attr_reader :trip_id, :url
    
    def initialize(client, id)
      @client = client
      @trip_id = id
      populate
    end
    
    def populate
      info = @client.get('trip_info', :trip_id => @trip_id)['trip']
      @start                    = info['start']
      @finish                   = info['finish']
      @outgoing_transport_type  = info['outgoing_transport_type']
      @return_transport_type    = info['return_transport_type']
      @tags                     = info['tag']
      @notes                    = info['note']
      @url                      = info['url']
      @city                     = City.new(@client, info['city']['geoname_id'])
    end
  end
end