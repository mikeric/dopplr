$: << File.dirname(__FILE__) + '/..'

require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'fakeweb'

require 'lib/dopplr'

FakeWeb.allow_net_connect = false

class Test::Unit::TestCase
  def stub_request(method, path, filename)
    url = "https://www.dopplr.com/oauthapi#{path}"
    fixture = File.dirname(__FILE__) + '/fixtures/' + filename
    FakeWeb.register_uri(method, url, :body => File.read(fixture))
  end
end