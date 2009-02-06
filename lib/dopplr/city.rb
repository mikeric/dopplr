module Dopplr
  class City < Client
    def info(id)
      call "/api/city_info?geoname_id=#{id}"
    end
  end
end