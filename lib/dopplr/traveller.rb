module Dopplr
  class Traveller
    attr_reader :nick, :forename, :surname, :share_trips, :see_trips,
      :email_sha1, :url, :dopplr_url, :short_url, :mobile_url, :muted
    
    def initialize(client, username, source = nil)
      @client = client
      @username = username
      populate(source)
    end
    
    def populate(source)
      info = source || @client.get('/traveller_info', :traveller => @username)['traveller_info']
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
    
    def current_city(options = {})
      unless @current_city && !options[:force]
        info = @client.get('traveller_info', @params)['traveller']
        @current_city = City.new @client, info['current_city']['geoname_id']
      end
      @current_city
    end
    
    def home_city(options = {})
      unless @home_city && !options[:force]
        info = @client.get('traveller_info', @params)['traveller']
        @home_city = City.new @client, info['home_city']['geoname_id']
      end
      @home_city
    end
    
    def trips(options = {})
      unless @trips && !options[:force]
        trips = @client.get('trips_info', @params)['trip']
        @trips = trips.map do |trip|
          Trip.new @client, trip['id']
        end
      end
      @trips
    end
    
    def future_trips(options = {})
      unless @future_trips && !options[:force]
        trips = @client.get('future_trips_info', @params)['trip']
        @future_trips = trips.map do |trip|
          Trip.new @client, trip['id']
        end
      end
      @future_trips
    end
    
    def fellows(options = {})
      unless @fellows && !options[:force]
        fellows = @client.get('fellows', @params)
        fellows['can_see_trips_of'].map! do |fellow|
          Traveller.new @client, fellow['nick']
        end
        fellows['shows_trips_to'].map! do |fellow|
          hash = fellow.inject({}) do |memo, (key, value)|
            memo[key.to_sym] = value
            memo
          end
          Struct.new(*hash.keys).new(*hash.values_at(*hash.keys))
        end
        @fellows = fellows.inject({}) do |memo, (key, value)|
          memo[key.to_sym] = value
          memo
        end
      end
      @fellows
    end
    
    def location_on_date(date)
      location = @client.get('location_on_date', @params.merge(:date => date))['location']
      location['home'] = City.new(@client, location['home']['geoname_id'])
      if location['trip']
        location['trip'] = Trip.new(@client, location['trip']['id'])
      end
      location = location.inject({}) do |memo, (key, value)|
        memo[key.to_sym] = value
        memo
      end
      location
    end
  end
end