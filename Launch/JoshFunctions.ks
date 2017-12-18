parameter orbitAltitude.

	function steerShipIf
	{
		parameter orbitAltitude.
		
		set currentHeading to ship:heading.
		
		if getDistanceFromOrbitalAnchor() >= orbitAltitude
		{
			until downRangeDistance(orbitAltitude) > orbitAltitude 
			{
				wait 0.5.
				set currentHeading to currentHeading - 0.1.
			}
		}
		else
		{
		return currentHeading.
		}
	}
		
	function adjustThrottle
	{
		parameter targetTWR.
		parameter actThrottle.
		
		thrustCalculations().
		
		set newThrottle to actThrottle.
		
		until actTWR <= targetTWR 
		{
			set newThrottle to newThrottle - 0.05.
			wait 0.01.
		}
		return newThrottle.
	}

	function calculateThrottle
	{
		set VESSEL to SHIP.

		set throttleCurrent to (VESSEL:AVAILABLETHRUST / VESSEL:MAXTHRUST).
		return throttleCurrent.
	}
