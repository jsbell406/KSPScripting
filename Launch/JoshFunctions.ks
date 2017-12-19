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
		
		until targetMan:ORBIT:PERIAPSIS > (orbitAltitude - (orbitAltitude / 50)) 
		{
			set targetMan:PROGRADE to targetMan:PROGRADE + 1.
			clearscreen.
			print "dV use: " + round(targetMan:PROGRADE, 2).
		}
		until targetMan:ORBIT:PERIAPSIS > (orbitAltitude - (orbitAltitude / 100)) 
		{
			set targetMan:PROGRADE to targetMan:PROGRADE + 0.001.
			clearscreen.
			print "dV use: " + round(targetMan:PROGRADE,2).
		}
		until targetMan:ORBIT:PERIAPSIS >= orbitAltitude 
		{
			set targetMan:PROGRADE to targetMan:PROGRADE + 0.0001.
			clearscreen.
			print "dV use: " + round(targetMan:PROGRADE,2).
		}
	}
	
	function execManeuver
	{
		parameter orbitAltitude.
		
		set targetMan to nextnode.
		wait 1.
		lock steering to targetMan:deltav.
		wait 20.
		
		set t to getManueverTime(targetMan:deltav:mag).
		print "Burn time: " + round (t,2) + " seconds".
		
		wait until targetMan:ETA <= (t/2).
		unlock steering.
		sas on.
		
		lock throttle to min(getManueverTime(targetMan: deltav:mag), 1).
		wait t.
		sas off.
		
		lock steering to prograde.
		lock throttle to 0.
		
		until periapsis <= orbitAltitude
		{
			lock throttle to 0.1.
		}
		lock throttle to 0.
		
		remove nextnode.
	}