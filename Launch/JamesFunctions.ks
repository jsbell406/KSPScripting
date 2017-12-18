parameter orbitalHeight.




    function getAscentPitchJames
	{
			set alt to Round(ship:altitude,1).
			set orb to Round(orbitalHeight,0).
			
			set alt to alt:TOSCALER.
			
			set difference to (orb - alt).
			print difference.
		
			
			
			
			
			
				
		return orb.
	}
	
	function steerShipJames
	{

		set accentAngle to getAscentPitchJames().
		print accentAngle.
		
		
		// A heading expressed as HEADING(compass, pitch).
		
		LOCK STEERING TO HEADING(90, 90).

	}