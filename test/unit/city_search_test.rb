require File.dirname(__FILE__) + '/../helpers'

class CitySearchTest < Test::Unit::TestCase
  context "city search" do
    setup do
      stub_post '/city_search', 'city_search.json'
      oauth = Dopplr::OAuth.new('token', 'secret')
      oauth.authorize_from_access('token', 'secret')
      
      @dopplr = Dopplr::Base.new(oauth)
      @city_search = @dopplr.city_search(:q => "montreal")
    end
    
    should "return populated city objects for results" do
      city = @city_search.results.first
      
      assert_instance_of Dopplr::City,  city
      assert_equal "Montru00e9al",      city.name
      assert_equal "Canada",            city.country
      assert_equal 45.5088,             city.latitude
    end
  end
end