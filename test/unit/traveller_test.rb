require File.dirname(__FILE__) + '/../helpers'

class TravellerTest < Test::Unit::TestCase
  context "traveller" do
    setup do
      stub_post '/traveller_info', 'traveller_info.json'
      oauth = Dopplr::OAuth.new('token', 'secret')
      oauth.authorize_from_access('token', 'secret')
      
      @dopplr = Dopplr::Base.new(oauth)
      @traveller = @dopplr.traveller('johnsmith')
    end
    
    should "populate attributes upon initialize" do
      assert_equal 'John',      @traveller.forename
      assert_equal 'Smith',     @traveller.surname
      assert_equal 'johnsmith', @traveller.nick
      assert_equal '0',         @traveller.share_trips
      assert_equal '1',         @traveller.see_trips
    end
    
    should "return an array of traveller places that they've been to" do
      stub_post '/traveller_places', 'traveller_places.json'
      
      @traveller.places.each do |place|
        assert_instance_of  Dopplr::TravellerPlace, place
        assert_equal        "visited",              place.vote
      end
    end
    
    should "return an array of the user's trips" do
      stub_post '/trip_search', 'trip_search.json'
      
      @traveller.trips.each do |trip|
        assert_instance_of  Dopplr::Trip, trip
        assert_equal        "plane",      trip.return_transport_type
      end
    end
  end
end