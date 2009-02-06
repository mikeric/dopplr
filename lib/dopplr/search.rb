module Dopplr
  class Search < Client
    def all(term)
      call "/api/search?q=#{term}"
    end
    
    def traveller(term)
      call "/api/traveller_search?q=#{term}"
    end
    
    def city(term)
      call "/api/city_search?q=#{term}"
    end
  end
end