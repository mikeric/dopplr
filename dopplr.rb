require 'rubygems'
require 'mechanize'

class Dopplr
  attr_reader :email, :password
  
  def initialize(email, password)
    @email = email
    @password = password
    @url = "https://www.dopplr.com/api/AuthSubRequest?scope=http%3A%2F%2Fwww.dopplr.com%2F&next=http%3A%2F%2Fwww.dopplr.com%2F&session=1"
  end
  
  def authenticate
    agent = WWW::Mechanize.new
    page = agent.get(@url)
    form = page.forms[1]
    form.email = @email
    form.password = @password
    page = agent.submit(form, form.buttons.first)
  end
end