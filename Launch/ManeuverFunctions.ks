
//Maneuver functions

parameter orbitAltitude.

	function changeManApo
	{
		
	}
	
	function circManeuverBurn
	{
		parameter orbitAltitude.
			
		until (orbit:semimajoraxis - body:altitude) >= orbitAltitude
		{
			lock throttle to 0.05.
		}
	}