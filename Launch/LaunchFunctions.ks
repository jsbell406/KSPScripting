// --- PARAMETERS ---

parameter orbitAlt.

// --- IMPORTS ---



// --- GLOBALS ---

// --- LISTS ---

LIST PARTS IN allParts.


// --- FUNCTIONS ---

	// set test launch here
	set testLaunch to false.
	
	
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