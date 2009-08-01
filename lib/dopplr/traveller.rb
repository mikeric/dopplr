module Dopplr
  class Traveller
    attr_reader :nick, :name, :status, :trips, :travel_today, :home_city, :current_city
    attr_reader :icon_id, :email_sha1, :url
    
    def initialize(client, username)
      @client = client
      @params = {:traveller => username}
      populate
    end
    
    def populate
      info = @client.get('traveller_info', @params)['traveller']
      trips = @client.get('trips_info', @params)['trip']
      @nick         = info['nick']
      @name         = info['name']
      @status       = info['status']
      @icon_id      = info['icon_id']
      @email_sha1   = info['sha1email']
      @url          = info['url']
      @travel_today = info['travel_today']
      @home_city    = City.new(@client, info['home_city']['geoname_id'])
      @current_city = City.new(@client, info['current_city']['geoname_id'])
      @trips        = trips.map{|trip| Trip.new(@client, trip['id'])} unless trips.empty?
    end
  end
end