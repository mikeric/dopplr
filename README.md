# dopplr

An abstraction library providing objects to interact with the Dopplr API. It is essentially a multi-user wrapper with each object being bound to a client. The current master is organically changing with the new API specification, and so it may be unstable. Please refer to the **authsub** tag for the old API (dopplr 0.2.0).

## Install

    gem install dopplr

## Usage

Here are some examples of how to use a few of the objects available. For a full reference, you need to read the tests and source code for now, at least until the Dopplr API spec is finalized.

### Dopplr::OAuth

Create a **Dopplr::OAuth** instance with your consumer token and secret. Authorize the client using your access token, provided that you've already obtained one. Create a **Dopplr::Base** instance using the authorized OAuth client.

    client = Dopplr::OAuth.new('1a2b3c4d5e', '2a3b4c5d6e')
    client.authorize_from_access('3a4b5c6d7e', '4a5b6c7d8e')
    
    dopplr = Dopplr::Base.new(client)

### Dopplr::Base

**Dopplr::Base** is used for searching, creating, and chaining objects. However, you could also instantiate and use the objects directly by passing the client as an argument. As such, the following groups of statements are equivalent.

    dopplr.city(4887398)                        #=> Dopplr::City for ID 4887398
    dopplr.traveller('johnsmith')               #=> Dopplr::Traveller for 'johnsmith'
    
    Dopplr::City.new(client, 4887398)           #=> Dopplr::City for ID 4887398
    Dopplr::Traveller.new(client, 'johnsmith')  #=> Dopplr::Traveller for 'johnsmith'

**Dopplr::Base** is also used for adding some of the high level objects such as places that you've been and trips you've taken.

    dopplr.add_place(
      'kj41',
      :note => 'Central Park is notably the most-visited urban park in the US.',
      :vote => 'liked'
    )
    
    dopplr.add_trip(
      5746545,
      :start => '2010-01-15',
      :finish => '2010-02-01',
      :outgoing_transport_type => 'plane'
    )

### Dopplr::City

    chicago = dopplr.city(4887398)

    chicago.country        #=> 'United States'
    chicago.timezone       #=> 'America/Chicago'
    chicago.localtime      #=> Wed Jul 22 09:30:15 2009
    chicago.url            #=> 'http://www.dopplr.com/place/us/il/chicago'
    chicago.latitude       #=> 41.85
    chicago.longitude      #=> -87.6501

### Dopplr::Traveller

    jon = dopplr.traveller('johnsmith')
    
    jon.surname       #=> 'Smith'
    jon.muted         #=> false
    jon.places        #=> [#<Dopplr::TravellerPlace:0x56f4a0 ...>, ...]
	jon.trips		  #=> [#<Dopplr::Trip:0x1053 ...>, ...]
    
    jon.fellow        # Shares the trips of the logged-in user with that traveller
    jon.mute          # Mutes that traveller

### Dopplr::Place

    place = dopplr.place('kj41')
    
    place.kind                  #=> 'explore'
    place.green_blocks          #=> 5
    place.vote                  #=> 'liked'
    place.tags                  #=> ['NYC','park','walk']
    
    place.report('complaint')   # Report a complaint about that place

### Dopplr::Trip

	trip = dopplr.trip('abcd')
	
	trip.start						#=> Mon Dec 06 00:00:00 +0100 2010
	trip.finish						#=> Thu Dec 09 00:00:00 +0100 2010
	trip.geoname_id					#=> 4887398
	trip.public_note				#=> "My trip notes"
	trip.outgoing_transport_type 	#=>	"plane"
	trip.dopplr_url					#=> "http://www.dopplr.com/trip/johnsmith/1234567"			