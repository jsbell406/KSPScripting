parameter orbitalHeight.




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

		set accentAngle to getAscentPitchJames().
		//print accentAngle.
		
		
		// A heading expressed as HEADING(compass, pitch).
		
		LOCK STEERING TO HEADING(90, accentAngle).

	}