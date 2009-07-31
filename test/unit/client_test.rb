require File.dirname(__FILE__) + '/../helpers'

class ClientTest < Test::Unit::TestCase
  context "A client" do
    setup do
      @client = Dopplr::Client.new
    end
    
    should "provide a proper login url" do
      assert_equal @client.login_url("http://www.you.com/"), "https://www.dopplr.com/api/AuthSubRequest?scope=http%3A%2F%2Fwww.dopplr.com%2F&next=http%3A%2F%2Fwww.you.com%2F&session=1"
    end
    
    context "with a valid session token" do
      setup do
        @client.token = 'TOKEN'
      end
      
      should "be able to perform search queries" do
        city_search = @client.search "Montreal", :city
        assert city_search['city']
        traveller_search = @client.search "Mike", :traveller
        assert traveller_search['traveller']
      end
      
      should "be able to create new objects" do
        assert @client.city 6173331
        assert @client.trip 525522
        assert @client.traveller 'mikeric'
      end
      
      should "be able to find a city" do
        city = @client.find_city "Portland"
        assert_equal city.geoname_id, 5746545
      end
    end
  end
end