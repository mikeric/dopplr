# A Ruby wrapper for the Dopplr API

This library provides access to some of the data available in Dopplr. It is designed to work by creating instances for each object (city, trip, traveller, etc.) and calling their methods to return the corresponding data.

## Example Usage

Require the Dopplr library and create a new client and city object.

    require 'dopplr'
    
    client = Dopplr::Client.new('token')
    vancouver = client.city('6173331')

Return some data from each object.

    client.info
    client.trips
    vancouver.info
    vancouver.tips

Perform a search query.

    client.search("Chicago", :city)


## Notes

Use client.create\_session to turn your single-use token into a session token for unlimited use. The get\_token method for Dopplr::Client doesn't work properly at this point. Mechanize is breaking the single-use token at some point, so for now you must get a token by logging into Dopplr.