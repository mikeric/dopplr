require 'rubygems'
require 'cgi'

module Dopplr
  class Base
    def call(path)
      http = Net::HTTP.new("www.dopplr.com", 443)
      http.use_ssl = true
      http.start do |http|
        request = Net::HTTP::Get.new(path, { 'Authorization' => 'AuthSub token="' + @token + '"' })
        response = http.request(request)
        return response.body
      end
    end
  end
end