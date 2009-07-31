# A Ruby wrapper for the Dopplr API

This library provides objects for talking to some of the data available in Dopplr, The Social Atlas. It is designed to work by creating a client for the master user (that the API token belongs to), which is then used to instantiate objects in relation to that user.

## Example Usage

Require the Dopplr library and create some new objects.

    require 'dopplr'
    
    dopplr = Dopplr::Client.new('token')
    
    mike = dopplr.traveller 'mikeric'
    chicago = dopplr.city '4887398'
    montreal = mike.home_city
    trip = mike.trips.first

Return some data from each object.

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

Find a new city object without knowing it's geoname_id (I'm feeling lucky).

    portland = dopplr.find_city "Portland"
    
    portland.country      #=> "United States"
    portland.geoname_id   #=> 5746545