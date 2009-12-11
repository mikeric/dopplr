# Dopplr

An abstraction library providing objects to interact with the Dopplr API. Essentially a multi-user wrapping of the API, with each object being bound to a client.

## Usage

### First things first

Create a `Dopplr::OAuth` instance with your consumer token and secret. Provided that you've obtained an access token already, authorize the client using your access token. Create a `Dopplr::Base` instance using the authorized OAuth client.

    client = Dopplr::OAuth.new('ctoken', 'csecret')
    client.authorize_from_access('atoken', 'asecret')
    
    dopplr = Dopplr::Base.new(client)

### Instantiating objects

For convenience, all Dopplr objects should be initialized through a `Dopplr::Base` instance. However, you could also instantiate them directly by passing a client as an arguement.

    dopplr.traveller('johnsmith')               #=> Dopplr::Traveller for 'johnsmith'
    dopplr.city(4887398)                        #=> Dopplr::City for ID 4887398
    
    Dopplr::Traveller.new(client, 'johnsmith')  #=> Dopplr::Traveller for 'johnsmith'
    Dopplr::City.new(client, 4887398)           #=> Dopplr::City for ID 4887398

Return some data for each object.

    city.country        #=> "United States"
    city.timezone       #=> "America/Chicago"
    city.localtime      #=> Wed Jul 22 09:30:15 2009
    city.url            #=> "http://www.dopplr.com/place/us/il/chicago"
    city.latitude       #=> 41.85
    city.longitude      #=> -87.6501
                        
    john.surname        #=> "Smith"
    john.muted          #=> false
    john.places         #=> [#<Dopplr::TravellerPlace:0x56f4a0 ...>, ...]