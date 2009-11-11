module Dopplr
  class OAuth
    attr_reader :consumer, :access_token
    
    def initialize(ctoken, csecret)
      @consumer = ::OAuth::Consumer.new(ctoken, csecret, :site => 'https://www.dopplr.com')
    end
    
    def set_callback_url(url)
      @request_token = nil
      request_token(:oauth_callback => url)
    end
    
    def request_token(options={})
      @request_token ||= consumer.get_request_token(options)
    end
    
    def authorize_from_request(rtoken, rsecret, verifier)
      request_token = ::OAuth::RequestToken.new(consumer, rtoken, rsecret)
      access = request_token.get_access_token(:oauth_verifier => verifier)
      @access_token = ::OAuth::AccessToken.new(consumer, access.token, access.secret)
    end
    
    def authorize_from_access(atoken, asecret)
      @access_token = ::OAuth::AccessToken.new(consumer, atoken, asecret)
    end
    
    def get(resource, params={})
      params_string = params.collect{|k, v| "#{k}=#{v.is_a?(Array) ? v.join(', ') : v}"}.join('&')
      request = access_token.get("/oauthapi#{resource}?#{URI.escape(params_string)}")
      JSON.parse(request.body)
    end
    
    def post(resource, params={})
      params.each {|k, v| params[k] = v.join(', ') if v.is_a?(Array)}
      request = access_token.post("/oauthapi#{resource}", params)
      JSON.parse(request.body)
    end
  end
end