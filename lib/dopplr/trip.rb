module Dopplr
  class Trip < Base
    def info(id)
      call "/api/trip_info?trip_id=#{id}"
    end
  end
end