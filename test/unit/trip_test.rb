require File.dirname(__FILE__) + '/../helpers'

class TripTest < Test::Unit::TestCase
  context "trip" do
    setup do
      stub_post '/trip_info', 'trip_info.json'
      oauth = Dopplr::OAuth.new('token', 'secret')
      oauth.authorize_from_access('token', 'secret')
      
      @dopplr = Dopplr::Base.new(oauth)
      @trip = @dopplr.trip('abcd')
    end
    
    should "populate attributes upon initialize" do
      assert_equal "plane",                                       @trip.return_transport_type
      assert_equal 5368361,                                       @trip.geoname_id
      assert_equal "http://www.dopplr.com/trip/johnsmith/123456", @trip.dopplr_url
      assert_equal "Test Note",                                   @trip.private_note
      assert_equal "johnsmith",                                   @trip.nick
    end
  end
end