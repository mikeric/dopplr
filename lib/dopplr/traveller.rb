module Dopplr
  class Traveller < Base
    def info(username=nil)
      if username
        call "/api/traveller_info?traveller=#{username}"
      else
        call "/api/traveller_info"
      end
    end
    
    def fellows(username=nil)
      if username
        call "/api/fellows?traveller=#{username}"
      else
        call "/api/fellows"
      end
    end
    
    def trips(username=nil)
      if username
        call "/api/trips_info?traveller=#{username}"
      else
        call "/api/trips_info"
      end
    end
    
    def future_trips(username=nil)
      if username
        call "/api/future_trips_info?traveller=#{username}"
      else
        call "/api/future_trips_info"
      end
    end
    
    def fellows_travelling_today(username=nil)
      if username
        call "/api/fellows_travellingtoday?traveller=#{username}"
      else
        call "/api/fellows_travellingtoday"
      end
    end
    
    def tag(tag, username=nil)
      if username
        call "/api/tag?traveller=#{username}&tag=#{tag}"
      else
        call "/api/tag?tag=#{tag}"
      end
    end
    
    def location_on_date(date, username=nil)
      if username
        call "/api/location_on_date?traveller=#{username}&date=#{date}"
      else
        call "/api/location_on_date?date=#{date}"
      end
    end
  end
end