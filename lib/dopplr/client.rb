module Dopplr
  class Client
    attr_accessor :token
    
    def initialize(token=nil)
      @token = token
    end
    
    # GET request with @token.
    def get(path, params={})
      params['format'] = 'js'
      url = "/api/#{path}/?#{URI.escape(params.collect{|key,value| "#{key}=#{value}"}.join('&'))}"
      http = Net::HTTP.new("www.dopplr.com", 443)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      responce, data = http.get(url, 'Authorization' => "AuthSub token=\"#{@token}\"")
      JSON.parse(data)
    end
    
    # POST request with @token.
    def post(path, params={})
      params['format'] = 'js'
      data_string = URI.escape(params.collect{|key,value| "#{key}=#{value}"}.join('&'))
      url = "/api/#{path}"
      http = Net::HTTP.new("www.dopplr.com", 443)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      response, data = http.post(url, data_string, 'Authorization' => "AuthSub token=\"#{@token}\"")
      JSON.parse(data)
    end
    
    # Returns a URL for getting a token.
    def login_url(url)
      return "https://www.dopplr.com/api/AuthSubRequest?scope=#{CGI.escape("http://www.dopplr.com/")}&next=#{CGI.escape(url)}&session=1"
    end
    
    # Changes @token into a session token.
    def create_session
      @token = get('AuthSubSessionToken')['token']
    end
    
    # Performs a search query.
    def search(term, type=:all)
      if type == :all
        get 'search', :q => term
      elsif type == :city
        get 'city_search', :q => term
      elsif type == :traveller
        get 'traveller_search', :q => term
      end
    end
    
    # Returns a new City object.
    def city(city_id)
      City.new(self, city_id)
    end
    
    # I'm feeling lucky city search.
    def find_city(name)
      city get('city_search', :q => name)['city'][0]['geoname_id']
    end
    
    # Returns a new Trip object.
    def trip(trip_id)
      Trip.new(self, trip_id)
    end
    
    # Returns a new Traveller object.
    def traveller(username = nil)
      if username
        Traveller.new(self, username)
      else
        Traveller.new(self)
      end
    end
  end
end