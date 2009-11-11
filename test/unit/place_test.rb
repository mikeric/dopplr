require File.dirname(__FILE__) + '/../helpers'

class PlaceTest < Test::Unit::TestCase
  context "place" do
    setup do
      stub_post '/place_info', 'place_info.json'
      oauth = Dopplr::OAuth.new('token', 'secret')
      oauth.authorize_from_access('token', 'secret')
      
      @dopplr = Dopplr::Base.new(oauth)
      @place = @dopplr.place('1a2b')
    end
    
    should "populate attributes upon initialize" do
      assert_equal "Patati Patata",   @place.name
      assert_equal "eat",             @place.kind
      assert_equal "+1 514-844-0216", @place.phone
      assert_equal 5,                 @place.green_blocks
      assert_equal 45.518104,         @place.latitude
    end
    
    should "return a populated city object for the city attribute" do
      assert_instance_of Dopplr::City,  @place.city
      assert_equal "America/Montreal",  @place.city.timezone
      assert_equal "3534",              @place.city.woeid
      assert_equal -18000,              @place.city.utc_offset
    end
  end
end