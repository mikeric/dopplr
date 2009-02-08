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
    def call(path)
      http = Net::HTTP.new("www.dopplr.com", 443)
      http.use_ssl = true
      http.start do |http|
        request = Net::HTTP::Get.new(path, { 'Authorization' => 'AuthSub token="' + @token + '"' })
        response = http.request(request)
        return response.body
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
      response = call('/api/AuthSubSessionToken')
      if response.match(/Token=(.*)/)
        @token = $1
        return @token
      end
      return response
    end
    
    # Performs a search query.
    def search(term, type=:all)
      if type == :all
        call "/api/search?q=#{term}"
      elsif type == :city
        call "/api/city_search?q=#{term}"
      elsif type == :traveller
        call "/api/traveller_search?q=#{term}"
      end
    end
    
    # Returns a new City object.
    def city(city_id)
      Dopplr::City.new(self, city_id)
    end
  end
end