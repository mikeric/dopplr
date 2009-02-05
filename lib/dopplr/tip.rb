module Dopplr
  class Tip < Base
    def all(id)
      call "/api/tips?geoname_id=#{id}"
    end
  end
end