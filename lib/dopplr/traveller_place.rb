module Dopplr
  class TravellerPlace
    attr_reader :traveller_place_id, :place_id, :vote, :datetime, :updated, :place
    
    def initialize(client, traveller_place_id, source = nil)
      @client = client
      @traveller_place_id = traveller_place_id
      populate(source)
    end
    
    def populate(source)
      info = source || @client.post('/traveller_place', :traveller_place_id => @traveller_place_id)['traveller_place']
      @place_id     = info['place_id']
      @vote         = info['vote']
      @datetime     = Time.parse(info['datetime'].slice(0..-7))
      @updated      = Time.parse(info['updated'].slice(0..-7))
      @place        = Place.new(@client, info['place']['place_id'], info['place']) if info['place']
    end
  end
end