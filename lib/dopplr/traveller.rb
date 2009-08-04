module Dopplr
  class Traveller
    attr_reader :nick, :name, :status, :travel_today, :icon_id, :email_sha1, :url
    
    def initialize(client, user = nil)
      @client = client
      @params = {}
      @params[:traveller] = user if user
      populate
    end
    
    def populate
      info = @client.get('traveller_info', @params)['traveller']
      @nick         = info['nick']
      @name         = info['name']
      @status       = info['status']
      @travel_today = info['travel_today']
      @icon_id      = info['icon_id']
      @email_sha1   = info['sha1email']
      @url          = info['url']
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
        if !trips.empty?
          @trips = trips.map do |trip|
            Trip.new @client, trip['id']
          end
        end
      end
      @trips ||= []
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
        @fellows = fellows
      end
      @fellows
    end
  end
end