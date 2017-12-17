// --- PARAMETERS ---

// --- GLOBALS ---

// --- LISTS ---

// --- FUNCTIONS ---

	function getAnchorPosition
	{
		print "Anchor Latitude: " + round(anchor:lat,2).
		print "Anchor Longitude: " + round(anchor:lng,2).
		
	}
	
	function setStartingDistanceFromOrbitalAnchor
	{
		parameter distance.
		
		set startingDistance to distance.
		
		
	}
	
	function getStartingDistanceFromOrbitalAnchor
	{
		return startingDistance.
	}
	
	function getDistanceFromOrbitalAnchor
	{
		return anchor:distance.
	}

	function positionReadout
	{
		wait .01.
		//clearscreen.
	
		print "Current Latitude:        " + round(latitude,2).
		print "Current Longitude:       " + round(longitude,2).
			
	}
	
	function createStartingPosition
	{
		set startingPosition to ship:geoposition.
	}
	
	function getStartingPosition
	{
		return startingPosition.
	}
	
	function getDownRangeDistanceAct
	{
			parameter orbitAltitude.
			
			set rangeDistance to sqrt(startingDistance ^ 2 - (altitude ^ 2)).	
			set rangeDistance to orbitAltitude - rangeDistance.
			return rangeDistance.
	}
	