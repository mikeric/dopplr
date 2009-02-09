require 'rubygems'
require 'mechanize'
require 'cgi'

module Dopplr
  class Client
    attr_accessor :token
    
    def initialize(token=nil)
      @token = token
    end
    
    # Makes an API call with @token.
    def fetch(path, params={})
      params_uri = URI.escape(params.collect{|key,value| "#{key}=#{value}"}.join('&'))
      url = "/api/#{path}/?#{params_uri}"
      http = Net::HTTP.new("www.dopplr.com", 443)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.start do |http|
        request = Net::HTTP::Get.new(url, { 'Authorization' => 'AuthSub token="' + @token + '"' })
        data = http.request(request).body
        return data
      end
    end
    
    # Returns a URL for getting a token.
    def login_url(url)
      return "https://www.dopplr.com/api/AuthSubRequest?scope=#{CGI.escape("http://www.dopplr.com/")}&next=#{CGI.escape(url)}&session=1"
    end
    
    # Generates a token with login credentials.
    def get_token(email, password, url)
      agent = WWW::Mechanize.new
      page = agent.get("https://www.dopplr.com/api/AuthSubRequest?scope=#{CGI.escape("http://www.dopplr.com/")}&next=#{CGI.escape(url)}&session=1")
      form = page.forms[1]
      form.email = email
      form.password = password
      page = agent.submit(form, form.buttons.first)
      form = page.forms[1]
      page = agent.submit(form, form.buttons.first)
      @token = page.uri.to_s.match(/token=(.{32})/)[1]
    end
    
    # Changes @token into a session token.
    def create_session
      response = fetch('AuthSubSessionToken')
      if response.match(/Token=(.*)/)
        @token = $1
        return @token
      end
      return response
    end
    
    # Performs a search query.
    def search(term, type=:all)
      if type == :all
        fetch('search', :q => term)
      elsif type == :city
        fetch('city_search', :q => term)
      elsif type == :traveller
        fetch('traveller_search', :q => term)
      end
    end
    
    # Returns a new City object.
    def city(city_id)
      Dopplr::City.new(self, city_id)
    end
    
    # Returns a new Trip object.
    def trip(trip_id)
      Dopplr::Trip.new(self, trip_id)
    end
    
    # Returns a new Traveller object.
    def traveller(username)
      Dopplr::Traveller.new(self, username)
    end
  end
end