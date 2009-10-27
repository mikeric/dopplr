require File.dirname(__FILE__) + '/../helpers'

class CityTest < Test::Unit::TestCase
  context "city" do
    setup do
      stub_request(:get, '/city_info?geoname_id=5746545', 'city_info.json')
      oauth = Dopplr::OAuth.new('token', 'secret')
      oauth.authorize_from_access('token', 'secret')
      
      @dopplr = Dopplr::Base.new(oauth)
      @city = @dopplr.city(5746545)
    end
    
    should "populate attributes upon initialize" do
      assert_equal 'Portland',      @city.name
      assert_equal 'OR',            @city.region
      assert_equal 'United States', @city.country
      assert_equal 45.5235,         @city.latitude
      assert_equal -122.676,        @city.longitude
    end
  end
end