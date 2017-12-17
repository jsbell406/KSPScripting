// --- PARAMETERS ---

// --- IMPORTS ---

	
	RUN ONCE PositionFunctions.ks(userDefinedOrbitalHeight).
	RUN ONCE LaunchFunctions.ks.
	RUN ONCE ShipFunctions.ks.
	RUN ONCE MathFunctions.ks.
	RUN ONCE EngineFunctions.ks.


// --- GLOBALS ---

// --- LISTS --- 

	LIST ENGINES IN myEngines.
	set activeEnginesList to list().

// --- FUNCTIONS ---


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
	
	function getFirstStageEngines
	{
		return firstStageEngines.
	}
	
	function getActiveEngines
	{
		return activeEnginesList.
	}
	
	function adjustThrottle
	{
		thrustCalculations().
		
		parameter targetTWR.
		set newThrottle to calculateThrottle.
		
		until actTWR <= targetTWR 
		{
			set newThrottle to newThrottle - 0.05.
			wait 0.01.
		}
		return newThrottle.
	}

function calculateThrottle
{
	set VESSEL to SHIP.

	set thrustCurrent to (VESSEL:AVAILABLETHRUST / VESSEL:MAXTHRUST).
	return thrustCurrent.
}
