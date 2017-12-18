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