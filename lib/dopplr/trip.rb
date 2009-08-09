module Dopplr
  class Trip
    attr_reader :start, :finish, :city, :outgoing_transport, :return_transport, :tags, :notes
    attr_reader :trip_id, :url
    
    def initialize(client, id)
      @client = client
      @trip_id = id
      populate
    end
    
    def populate
      info = @client.get('trip_info', :trip_id => @trip_id)['trip']
      @outgoing_transport = info['outgoing_transport_type']
      @return_transport   = info['return_transport_type']
      @tags               = info['tag']
      @notes              = info['note']
      @url                = info['url']
      @start              = Time.parse info['start']
      @finish             = Time.parse info['finish']
    end
    
    def city(options = {})
      unless @city && !options[:force]
        info = @client.get('trip_info', :trip_id => @trip_id)['trip']
        @city = City.new @client, info['city']['geoname_id']
      end
      @city
    end
    
    def add_tags(*tags)
      info = @client.post 'add_trip_tags', :trip_id => @trip_id, :tags => tags.join('+')
      @tags = info['trip']['tag']
    end
  end
end