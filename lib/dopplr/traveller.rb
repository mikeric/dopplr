module Dopplr
  class Traveller
    attr_reader :nick, :forename, :surname, :share_trips, :see_trips,
      :email_sha1, :url, :dopplr_url, :short_url, :mobile_url, :muted
    
    def initialize(client, username, source = nil)
      @client = client
      @username = username
      populate(source)
    end
    
    def populate(source)
      info = source || @client.post('/traveller_info', :traveller => @username)['traveller_info']
      @nick         = info['nick']
      @forename     = info['forename']
      @surname      = info['surname']
      @share_trips  = info['share_trips']
      @see_trips    = info['can_see_trips']
      @muted        = info['muted']
      @email_sha1   = info['sha1email']
      @url          = info['url']
      @dopplr_url   = info['dopplr_url']
      @short_url    = info['short_url']
      @mobile_url   = info['mobile_url']
    end
  end
end