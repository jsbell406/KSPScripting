// --- PARAMETERS ---
parameter orbitAlt.

// --- IMPORTS ---

	



// --- GLOBALS ---

// --- LISTS --- 

	LIST ENGINES IN myEngines.
	set activeEnginesList to list().
	set firstStageEngines to list().

// --- FUNCTIONS ---


	// creates list of first stage engines
	function createFirstStage
	{
		
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
				//if engine:flameout = false
				//{
				//	activeEnginesList:ADD(engine).
				//}
				activeEnginesList:ADD(engine).
			}
		}
	}
	
	function getFirstStageEngines
	{
		return firstStageEngines.
	}
	
	function getActiveEngines
	{
		return activeEnginesList.
	}
	
	
	//parameter targetTWR - Desired TWR
	//parameter actThrottle - current throttle value
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

	//DEPRECATED
	function calculateThrottle
	{
		set VESSEL to SHIP.

		set throttleCurrent to (VESSEL:AVAILABLETHRUST / VESSEL:MAXTHRUST).
		return throttleCurrent.
	}
