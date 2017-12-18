parameter orbitAltitude.

	function steerShipIf
	{
		parameter orbitAltitude.
		parameter actHeading.
		set a to false.
		
		if anchor:distance >= orbitAltitude
		{
			set actHeading to actHeading - 0.5.
			set a to true.
		}
		else
		{
			if anchor:distance < orbitAltitude AND a = true
			{
				set actHeading to actHeading + 0.5.
				return actHeading.
			}
			
			return actHeading.
		}
		
		return actHeading.
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
