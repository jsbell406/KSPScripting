// UserFunctions
// houses all custom functions
// Authors -  Jimmy
//		   The Cheat - technicalReadOut function
// Created - 7/22/2017


// --- PARAMETERS ---
parameter userDefinedOrbitalHeight.


// --- GLOBALS ---


	// set test launch here
	set testLaunch to false.


// --- LISTS ---

	LIST PARTS IN allParts.
	LIST ENGINES IN myEngines.
	set activeEnginesList to list().

// --- END LISTS ---

// --- FUNCTIONS ---

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
		print "Downrange Distance: " + getDownRangeDistanceAct(userDefinedOrbitalHeight).
		print "Ascent Pitch: " + getAscentPitch(userDefinedOrbitalHeight).
		print "Distance from Anchor " + getDistanceFromOrbitalAnchor.
		print "Starting Distance " + getStartingDistanceFromOrbitalAnchor.
		//positionReadout.
		//getAnchorPosition.
	}
	
	function positionReadout
	{
		wait .01.
		//clearscreen.
	
		print "Current Latitude:        " + round(latitude,2).
		print "Current Longitude:       " + round(longitude,2).
		
		
			
	}
	
	function deployOrbitalAnchor
	{
		parameter orbitAltitude.
		
		set anchor to startingPosition.
		set anchor to LATLNG(anchor:lat,anchor:lng + convertMetersToDegrees(orbitAltitude)).
		set distance to Round(anchor:distance,2).
		
		
		setStartingDistanceFromOrbitalAnchor(distance).
				
		print anchor:terrainheight.
		print distance.
	}
	
	//For testing purposes
	function getAnchorPosition
	{
		print "Anchor Latitude: " + round(anchor:lat,2).
		print "Anchor Longitude: " + round(anchor:lng,2).
		
	}
	
	function setStartingDistanceFromOrbitalAnchor
	{
		parameter distance.
		
		set startingDistance to distance.
		
		
	}
	
	function getStartingDistanceFromOrbitalAnchor
	{
		return startingDistance.
	}
	
	function getDistanceFromOrbitalAnchor
	{
		return anchor:distance.
	}
	
	function bodyCircumference
	{
		return constant:pi * ship:body:radius * 2.
	}
	
	function convertDegreesToMeters
	{
		parameter degrees.
		return degrees * bodyCircumference() / 360.
	}
	
	function convertMetersToDegrees
	{	
		parameter meters.
		return 360 * meters / bodyCircumference().
		
	}


	// Thrust Calculator
	// Calculates maths based on ships position to determine current Thrust to Weight Ratios
	function thrustCalculations 
	{
		set gravAcc to (constant:G * ship:body:mass) / (ship:body:radius ^ 2).
		set gravAcc1 to (constant:G * ship:body:mass) / ((ship:body:radius + altitude) ^ 2).

		declare global TWR to ((ship:availablethrust * gravAcc) / (mass * gravAcc ^ 2)) * throttle.
		declare global actTWR to ((ship:availablethrust * gravAcc1) / (mass * gravAcc1 ^ 2)) * throttle.
		declare global maxTWR to (ship:availablethrust * gravAcc1) / (mass * gravAcc1 ^ 2).
	}


	// List of Launch clamps
	function getLaunchClamps
	{
		set launchClamps to list().
		for clamp in allParts
		{
			if clamp:name = "launchClamp1" 
			{
				launchClamps:ADD(clamp).
			}
		}
		return launchClamps.
	}
	
	// release launch clamps
	function releaseLaunchClamps
	{
		set x to 0.
		set count to 1.
	
		
		if testLaunch = true
		{
			set x to 1.
		}
		
		for clamp in getLaunchClamps() 
		{	
			if count > x 
			{
				clamp:getModule("LaunchClamp"):doevent("release clamp").
			}
			set count to count + 1.	
		}
	}
	
	// creates list of first stage engines
	function createFirstStage
	{
		set firstStageEngines to list().
		for eng in myEngines
		{		
			if eng:children:length = 0
			{
				firstStageEngines:ADD(eng).
			}
		}	
	}
	
	// upside down candlestick
	function firstStageIgnition
	{
		for eng in firstStageEngines
		{
			eng:activate.		
		}	
		updateActiveEngines().
	}
	
	
	function startActiveEngines
	{
		for engine in activeEnginesList
		{
			engine:activate.
		}
	}
	
	function shutdownActiveEngines
	{
		for eng in activeEnginesList
		{
			eng:shutdown.
		}
	}
	
	function updateActiveEngines
	{
		activeEnginesList:clear().
		myEngines:clear().
		list engines in myEngines.
		
		for engine in myEngines
		{
			if engine:children:length = 0
			{
				if engine:flameout = false
				{
					activeEnginesList:ADD(engine).
				}
			}
		}
	}
	
	
	
	function createStartingPosition
	{
		set startingPosition to ship:geoposition.
	}
	
	function getStartingPosition
	{
		return startingPosition.
	}
	
	function getFirstStageEngines
	{
		return firstStageEngines.
	}
	
	function getActiveEngines
	{
		return activeEnginesList.
	}
	
	function getDownRangeDistanceAct
	{
			parameter orbitAltitude.
			
			set rangeDistance to sqrt(startingDistance ^ 2 - (altitude ^ 2)).	
			set rangeDistance to orbitAltitude - rangeDistance.
			return rangeDistance.
	}
	
	function getAscentPitch 
	{
		parameter orbitAltitude.

		set orbitAlt to Round(getDistanceFromOrbitalAnchor(),2).
		set ascentPitch to (orbitAltitude^2 - (altitude + getDownRangeDistanceAct(orbitAlt)))/orbitAltitude^2*90.
			
		return ascentPitch.
	}
	
	function steerShip
	{
 
	
		set accentAngle to getAscentPitch(userDefinedOrbitalHeight).
		// A heading expressed as HEADING(compass, pitch).
		LOCK STEERING TO HEADING(90, 70).

	
	}
	
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
	
	function TWRActual
	{
		updateActiveEngines().
		for each eng in ActiveEnginesList(){
			
		}
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
	
	
// --- END FUNCTIONS ---