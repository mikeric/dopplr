module Dopplr
  class Traveller
    attr_reader :username, :name, :status, :travel_today, :home_city, :current_city
    attr_reader :icon_id, :email_sha1, :url
    
    def initialize(client, username)
      @client = client
      @username = username
      populate
    end
    
    def populate
      info = @client.get('traveller_info', :traveller => @username)['traveller']
      @name         = info['name']
      @status       = info['status']
      @icon_id      = info['icon_id']
      @email_sha1   = info['sha1email']
      @url          = info['url']
      @travel_today = info['travel_today']
      @home_city    = City.new(@client, info['home_city']['geoname_id'])
      @current_city = City.new(@client, info['current_city']['geoname_id'])
    end
  end
end