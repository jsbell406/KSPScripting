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
			if anchor:distance < (orbitAltitude + orbitAltitude/10) AND a = true
			{
				set actHeading to actHeading + 0.1.
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
		
		if actTWR <= targetTWR 
		{
			set actThrottle to actThrottle + 0.01.
			wait 0.01.
		}
		
		if actTWR >= targetTWR
		{
			set actThrottle to actThrottle - 0.01.
			wait 0.01.
		}
		return actThrottle.
	}

	function calculateThrottle
	{
		set VESSEL to SHIP.

		set throttleCurrent to (VESSEL:AVAILABLETHRUST / VESSEL:MAXTHRUST).
		return throttleCurrent.
	}
