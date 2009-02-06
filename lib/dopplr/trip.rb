module Dopplr
  class Trip < Client
    def info(id)
      call "/api/trip_info?trip_id=#{id}"
    end
  end
end