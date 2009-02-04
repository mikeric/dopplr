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
    
    self.token = page.uri.to_s.match(/token=(.{32})/)[1]
  end
end