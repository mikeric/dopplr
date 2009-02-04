require 'rubygems'
require 'mechanize'
require 'cgi'

class Dopplr
  attr_reader :email, :password
  
  def initialize(email, password)
    @email = email
    @password = password
  end
  
  def token=(token)
    @token = token
  end
  
  def authenticate(url)
    agent = WWW::Mechanize.new
    page = agent.get("https://www.dopplr.com/api/AuthSubRequest?scope=http%3A%2F%2Fwww.dopplr.com%2F&next=#{CGI.escape(url)}&session=1")
    form = page.forms[1]
    form.email = @email
    form.password = @password
    page = agent.submit(form, form.buttons.first)
    form = page.forms[1]
    page = agent.submit(form, form.buttons.first)
    
    @token = page.uri.to_s.match(/token=(.{32})/)[1]
  end
  
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