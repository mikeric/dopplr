module Dopplr
  class User < Traveller
    def initialize(client)
      @client = client
      @params = {}
      populate
    end
  end
end