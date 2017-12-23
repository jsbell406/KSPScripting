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

	function planCircManeuver
	{
		parameter orbitAltitude.
		
		set targetMan to node(time:seconds+eta:apoapsis, 0, 0, -5).
		add targetMan.
		
		clearscreen.
		wait 0.5.
		print "Selected orbit is " + orbitAltitude + "m.".
		
		until targetMan:ORBIT:PERIAPSIS > (orbitAltitude - (orbitAltitude / 100)) 
		{
			set targetMan:PROGRADE to targetMan:PROGRADE + 1.
			clearscreen.
			print "dV use: " + round(targetMan:PROGRADE, 2).
		}
		until targetMan:ORBIT:PERIAPSIS > (orbitAltitude - (orbitAltitude / 200)) 
		{
			set targetMan:PROGRADE to targetMan:PROGRADE + 0.01.
			clearscreen.
			print "dV use: " + round(targetMan:PROGRADE,2).
		}
		
		until targetMan:ORBIT:ECCENTRICITY <= 0.001
		{
			set targetMan:PROGRADE to targetMan:PROGRADE + 0.001.
			clearscreen.
			print "dV use: " + round(targetMan:PROGRADE,2).
		}
		
		// until targetMan:ORBIT:PERIAPSIS >= orbitAltitude 
		// {
			// set targetMan:PROGRADE to targetMan:PROGRADE + 0.0001.
			// clearscreen.
			// print "dV use: " + round(targetMan:PROGRADE,2).
		// }
	}
	
	function execManeuver
	{
		parameter orbitAltitude.
		
		set targetMan to nextnode.
		wait 1.
		set targetSteer to targetMan:deltav.
		lock steering to targetSteer.
		
		set burnTime to getManueverTime(targetMan:deltav:mag, 1).
		////Testing short maneuver timer
		// if burnTime < 1
		// {
			// set adjBurnTime to burnTime.
			// set adjBurnTime to getManueverTime(targetMan:deltav:mag, burnTime).
		// }
		// else{
			// set adjBurnTime to burnTime.
		// }
		// print "Burn time: " + round (adjBurnTime,2) + " seconds".
		
		//wait until targetMan:ETA <= (adjBurnTime/2).
		wait until targetMan:ETA <= (BurnTime/2).
		//unlock steering.
		//sas on.
		
		// lock throttle to min(getManueverTime(targetMan:deltav:mag, burnTime), burnTime).
		// wait adjBurnTime.
		

		//lock throttle to 0.
		
		//circManeuverBurn(orbitAltitude).
		
		//sas off.
		
		set done to false.
		
		set manThrottle to 0.
		lock throttle to manThrottle.
		
		set done to false.
		set deltav0 to targetMan:deltav.
		
		until done
		{
			set maxAcc to shipMaxAccel().
			set manThrottle to min(targetMan:deltav:mag/maxAcc, 1).
			aspStageReady().
			
			if vdot(deltav0, targetMan:deltav) < 0
			{
				lock throttle to 0.
				break.
			}
			
			if targetMan:deltav:mag < 0.1
			{
				wait until vdot(deltav0, targetMan:deltav) < 0.5.
				
				lock throttle to 0.
				set done to true.
			}
		}
		
		
		
		
		
		lock steering to prograde.
		unlock throttle.
		
		remove nextnode.
	}

	function shipMaxAccel
	{
		set maxAccel to ship:maxthrust/ship:mass.
		return maxAccel.
	}
	
	function tempTechReadout
	{
		parameter orbitAltitude.
		parameter thrustLim.
				
		clearscreen.
		print "Apoapsis:		" + round(ship:apoapsis, 1) + "m.".
		print "Target Orbit:	" + orbitAltitude + "m.".
		print "---".
		print "Expected TWR:	" + thrustLim  + " TWR".
	}