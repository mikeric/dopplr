require File.dirname(__FILE__) + '/../helpers'

class PlaceSearchTest < Test::Unit::TestCase
  context "place search" do
    setup do
      stub_post '/place_search', 'place_search.json'
      oauth = Dopplr::OAuth.new('token', 'secret')
      oauth.authorize_from_access('token', 'secret')
      
      @dopplr = Dopplr::Base.new(oauth)
      @place_search = @dopplr.place_search(:bbox => [30, -80, 50, -70])
    end
    
    should "return populated place objects for results" do
      place = @place_search.results.first
      
      assert_instance_of Dopplr::Place, place
      assert_equal "Central Park",      place.name
      assert_equal 5,                   place.green_blocks
      assert_equal 3,                   place.tags.count
    end
  end
end