module Dopplr
  class Traveller
    attr_reader :nick, :name, :status, :trips, :travel_today, :home_city, :current_city
    attr_reader :icon_id, :email_sha1, :url
    
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
      @icon_id      = info['icon_id']
      @email_sha1   = info['sha1email']
      @url          = info['url']
      @travel_today = info['travel_today']
    end
    
    def trips(options = {})
      unless @trips || options[:force]
        trips = @client.get('trips_info', @params)['trip']
        @trips = trips.map do |trip|
          Trip.new @client, trip['id'] unless trips.empty?
        end
      end
      @trips
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
  end
end