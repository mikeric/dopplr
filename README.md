# A Ruby wrapper for the Dopplr API

This library provides object bindings using some of the data available in Dopplr, the social atlas. It is designed to work by creating instances for each object and calling their methods to return the corresponding data.

## Example Usage

Require the Dopplr library and create some new objects.

    require 'dopplr'
    
    dopplr = Dopplr::Client.new('token')
    montreal = dopplr.city('6077243')
    mike = dopplr.traveller('mikeric')

Return some data from each object.

    montreal.country    #=> "Canada"
    montreal.timezone   #=> "America/Montreal"
    montreal.localtime  #=> Wed Jul 29 17:31:15 2009
    montreal.latitude   #=> 45.5168
    montreal.longitude  #=> -73.6492
    
    mike.name           #=> "Mike Richards"
    mike.current_city   #=> #<City:0x59a3d0>
    mike.status         #=> "is at home in Montreal"
    mike.travel_today   #=> false

Find a new city object without knowing it's geoname_id (I'm feeling lucky).

    portland = dopplr.find_city "Portland"
    
    portland.country    #=> "United States"
    portland.geoname_id #=> 5746545