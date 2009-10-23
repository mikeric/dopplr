require File.dirname(__FILE__) + '/../helpers'

class BaseTest < Test::Unit::TestCase
  context "base" do
    setup do
      oauth = Dopplr::OAuth.new('token', 'secret')
      oauth.authorize_from_access('token', 'secret')
      @dopplr = Dopplr::Base.new(oauth)
    end
    
    should "require a client" do
      assert_respond_to @dopplr.client, :get
      assert_respond_to @dopplr.client, :post
    end
  end
end