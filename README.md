# Dopplr

This library provides objects for talking to some of the data available in Dopplr, The Social Atlas. It is essentially a multi-user wrapping of the Dopplr API, with each object being bound to a client.

## Usage

### First things first

Require the Dopplr library and create a `Dopplr::Client` instance. Return a login URL for the user to obtain a token, store the token for that user.

    require 'dopplr'
    
    client = Dopplr::Client.new             #=> #<Dopplr::Client:0x578208 ...>
    client.login_url "http://www.you.com/"  #=> "https://www.dopplr.com/api/..."

Now that you have a single-use token, assign it to the `Dopplr::Client` object and generate a session token.

    client.token = '1a2b3c4d5e6f'     #=> '1a2b3c4d5e6f'
    client.create_session             #=> '3c4d5e6f1a2b'

### Instantiating and returning data from objects

All Dopplr objects are created using the client as a base.

    mike      = client.traveller      #=> Dopplr::Traveller for the token holder
    chicago   = client.city 4887398   #=> Dopplr::City for ID 4887398
    montreal  = mike.home_city        #=> Dopplr::City for mike's home city
    trip      = mike.trips.first      #=> Dopplr::Trip for mike's first trip

Return some basic information about each object.

    montreal.country      #=> "Canada"
    montreal.timezone     #=> "America/Montreal"
    montreal.localtime    #=> Wed Jul 22 09:30:15 2009
    
    chicago.url           #=> "http://www.dopplr.com/place/us/il/chicago"
    chicago.latitude      #=> 41.85
    chicago.longitude     #=> -87.6501
    
    mike.name             #=> "Mike Richards"
    mike.status           #=> "is at home in Montreal"
    mike.travel_today     #=> false
    
    trip.city.name        #=> "Calgary"
    trip.start            #=> Sat Feb 16 00:00:00 2008
    trip.return_transport #=> "plane"

Get trips and fellows for a particular traveller.

    mike.trips            #=> [#<Dopplr::Trip:0x56f4a0 ...>, ...]
    
    mike.fellows          #=> {:can_see_trips_of => [#<Dopplr::Traveller:0x570954 ...>, ...],
                               :shows_trips_to => [#<Dopplr::Traveller:0x59e8b1 ...> ...]}

Return a new `Dopplr::City` object without knowing the geoname_id (I'm feeling lucky).

    portland = client.find_city "Portland"
    
    portland.country      #=> "United States"
    portland.geoname_id   #=> 5746545

### Working with and creating new trip data

Plan a new trip to Portland, OR.

    portland.add_trip('2010-01-12', '2010-01-19')
    portland_trip = mike.future_trips.last
    
    portland_trip.start           #=> Tue Jan 12 00:00:00 2010
    portland_trip.city.latitude   #=> 45.5235

Add some tags and a note to your trip.

    portland_trip.add_tags :work, :meetup
    portland_trip.add_note "Staying for a week, then heading back home."

Trip got canceled? Delete it.

    portland_trip.delete