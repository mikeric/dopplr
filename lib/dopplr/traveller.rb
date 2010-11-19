module Dopplr
  class Traveller
    attr_reader :nick, :forename, :surname, :share_trips, :see_trips,
      :email_sha1, :url, :dopplr_url, :short_url, :mobile_url, :muted
    
    def initialize(client, username = nil, source = nil)
      @client = client
      @username = username
      populate(source)
    end
    
    def populate(source)
      unless @username.nil?
        info = source || @client.post('/traveller_info', :traveller => @username)['traveller_info']
      else
        info = source || @client.post('/whoami')['whoami']
      end
      @username     = info['nick'] if @username.nil?
      @nick         = info['nick']
      @forename     = info['forename']
      @surname      = info['surname']
      @share_trips  = info['share_trips']
      @see_trips    = info['can_see_trips']
      @muted        = info['muted']
      @email_sha1   = info['sha1email']
      @url          = info['url']
      @dopplr_url   = info['dopplr_url']
      @short_url    = info['short_url']
      @mobile_url   = info['mobile_url']
    end
    
    def places(params = {})
      @client.post('/traveller_places', params.merge(:traveller => @username, :extra => 'place'))['traveller_places']['results'].map do |place|
        TravellerPlace.new(@client, place['traveller_place_id'], place)
      end
    end
    
    def trips(params = {})
      @client.post('/trip_search', params.merge(:traveller => @username))['trip_search']['results'].map do |trip|
        Trip.new(@client, trip['trip_id'], trip)
      end
    end
  end
end