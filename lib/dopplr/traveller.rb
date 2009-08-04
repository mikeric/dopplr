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
      unless @current_city || options[:force]
        info = @client.get('traveller_info', @params)['traveller']
        @current_city = City.new @client, info['current_city']['geoname_id']
      end
      @current_city
    end
    
    def home_city(options = {})
      unless @home_city || options[:force]
        info = @client.get('traveller_info', @params)['traveller']
        @home_city = City.new @client, info['home_city']['geoname_id']
      end
      @home_city
    end
    
    def trips(options = {})
      unless @trips || options[:force]
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
      unless @fellows && @sharing || options[:force]
        fellows = @client.get('fellows', @params)
        if !fellows['can_see_trips_of'].empty?
          @fellows = fellows['can_see_trips_of'].map do |fellow|
            Traveller.new @client, fellow['nick']
          end
        end
        if !fellows['shows_trips_to'].empty?
          @sharing = fellows['shows_trips_to'].map do |fellow|
            hash = fellow.inject({}) do |memo,(k,v)|
              memo[k.to_sym] = v
              memo
            end
            Struct.new(*hash.keys).new(*hash.values_at(*hash.keys))
          end
        end
      end
      if options[:sharing]
        @sharing ||= []
      else
        @fellows ||= []
      end
    end
  end
end