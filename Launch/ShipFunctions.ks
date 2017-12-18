parameter orbitAlt.
	


// Technical read out function
	// useful information about craft during operation
	// must call  thrustCalculations funcation for proper TWR readout
	function technicalReadout 
	{
		
		wait .1.
		clearscreen.

		print "Max thrust:      " + round(maxthrust,2).
		print "Available Thrust:" + round(availablethrust,2).
		
		//print "ship mass:       " + round(mass,2).
		//print "vertical speed:  " + round(verticalspeed,2).
		//print "Ground speed:    " + round(groundspeed,2).
		//print "Airspeed:        " + round(airspeed,2).
		//print "Altitude:        " + round(altitude,2).
		//print "Apoapsis:        " + round(apoapsis,2).
		//print "Periapsis:       " + round(periapsis,2).
		//print "status:          " + status.
		//print "throttle:        " + round(throttle,3).
		//print "eta to apoapsis: " + round(eta:apoapsis,1).
		//print "TWR/TWR(surface):" + round(actTWR, 2) + "/" + round(maxTWR , 2).
		print "Downrange Distance: " + getDownRangeDistanceAct(orbitAlt).
		print "Ascent Pitch: " + getAscentPitch(orbitAlt).
		print "Distance from Anchor " + getDistanceFromOrbitalAnchor().
		print "Starting Distance " + getStartingDistanceFromOrbitalAnchor().
		//positionReadout.
		//getAnchorPosition.
	}
	
	
	function getAscentPitch 
	{
		parameter orbitAltitude.

		set orbitAltitude to Round(getDistanceFromOrbitalAnchor(),2).
		set ascentPitch to (orbitAltitude^2 - (altitude + getDownRangeDistanceAct(orbitAlt)))/orbitAltitude^2*90.
			
		return ascentPitch.
	}
	
	function steerShip
	{

		set accentAngle to getAscentPitch(orbitAlt).
		// A heading expressed as HEADING(compass, pitch).
		LOCK STEERING TO HEADING(90, 70).

	}

	
	
	//Returns manuever burn time based on parameter dv
	//dv should be delta-V necessary to execute manuever
	//
	function getManueverTime
	{
	parameter dv.
	
	updateActiveEngines ().
	local engT is activeEnginesList:MAXTHRUST * 1000.
	local vesMass is SHIP:MASS * 1000.
	local e is CONSTANT():E.
	local engISP is activeEnginesList:ISP.
	local g is (constant:G * ship:body:mass) / ((ship:body:radius + altitude) ^ 2).
	
	return g * vesMass * engISP * (1 -  e^(-dv/(g*engISP))) / engT.
	}
	
		
	