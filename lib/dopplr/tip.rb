module Dopplr
  class Tip < Client
    def all(id)
      call "/api/tips?geoname_id=#{id}"
    end
  end
end