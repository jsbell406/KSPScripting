parameter orbitalHeight.





	function thrustLimiter
	{
	
		parameter thrustLimit.
	
		thrustCalculations().
		print "TWR/TWR(surface):" + round(actTWR, 2) + "/" + round(maxTWR , 2).
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
	
	
	}
    function getAscentPitchJames
	{
			set rad to Round(ship:apoapsis,1).
			set orb to Round(orbitalHeight,0).
			
			set difference to orb - rad.
			set accAdj to difference / orb.
			
			set accentAngle to accAdj * 90.
			
			print rad.
			//print orb.
			print "apo " + ship:apoapsis.
			print "Real Accent: " + accentAngle.
			
			
			
				
		return accentAngle.
	}
	
	function steerShipJames
	{

	
		thrustLimiter().
		set accentAngle to getAscentPitchJames().
		//print accentAngle.
		
		
		// A heading expressed as HEADING(compass, pitch).
		
		LOCK STEERING TO HEADING(90, accentAngle).

	}