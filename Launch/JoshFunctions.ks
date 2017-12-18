parameter orbitAltitude.

	function steerShipIf
	{
		parameter orbitAltitude.
		
		until getDownRangeDistanceAct(orbitAltitude) <= orbitAltitude
		{
			if downRangeDistance(orbitAltitude) > orbitAltitude 
			{
				wait 0.5.
				set ifAscentPitch to ifAscentPitch - 0.1.
			}
		}
	}
		
	function adjustThrottle
	{
		parameter targetTWR.
		parameter actThrottle.
		
		thrustCalculations().
		
		set newThrottle to calculateThrottle().
		
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
