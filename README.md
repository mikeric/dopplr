# A Ruby wrapper for the Dopplr API

This simple API wrapper provides access to some of the data available in Dopplr. It is designed to work by creating instances for each object (City, Trip, Traveller, etc.) and calling their methods to return the corresponding data.

## Example Usage

    require 'dopplr'

    client = Dopplr::Client.new('token') # Creates a new client with specified token.
    client.info # Returns common information about you.
    client.trips # Returns a listing of your trips.

    vancouver = client.city('6173331') # Creates a new City object with specified city_id.
    vancouver.info # Returns common info about Vancouver.
    vancouver.tips # Returns a listing of the latest tips for Vancouver.

    client.search("Chicago", :city) # Returns results of a city search for "Chicago".