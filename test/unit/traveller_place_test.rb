require File.dirname(__FILE__) + '/../helpers'

class TravellerPlaceTest < Test::Unit::TestCase
  context "place" do
    setup do
      stub_post '/traveller_place', 'traveller_place.json'
      oauth = Dopplr::OAuth.new('token', 'secret')
      oauth.authorize_from_access('token', 'secret')
      
      @dopplr = Dopplr::Base.new(oauth)
      @traveller_place = Dopplr::TravellerPlace.new(@dopplr.client, 'mk73')
    end
    
    should "populate attributes upon initialize" do
      assert_equal "mk73",    @traveller_place.traveller_place_id
      assert_equal "visited", @traveller_place.vote
    end
    
    should "return a time object for datetime and updated" do
      assert_instance_of  Time, @traveller_place.datetime
      assert_instance_of  Time, @traveller_place.updated
      assert_equal        0,    @traveller_place.datetime.hour
      assert_equal        0,    @traveller_place.updated.hour
    end
    
    should "return a populated place object for place" do
      assert_instance_of Dopplr::Place, @traveller_place.place
      assert_equal "Union Square Park", @traveller_place.place.name
      assert_equal "explore",           @traveller_place.place.kind
      assert_equal 5,                   @traveller_place.place.green_blocks
    end
  end
end