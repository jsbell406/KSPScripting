// TESTING POTENTIAL STAGING METHODS
clearscreen.
parameter orbitalHeight.

// --- IMPORTS ---

RUN ONCE lib.ks(orbitalHeight).
RUN ONCE EngineFunctions.ks(orbitalHeight).

	set firstStage to getFirstStageEngines().
	set firstStageCopy to firstStage:copy.
	set firstStageFuel to list().
	set firstStageDecouple to list().
// Creates Active stage, From bottom engines to First decoupler
function createActiveStage
{
	// Starting point is bottom engines of the craft createFirstStage lives in engine functions.
	createFirstStage().

	// --- LISTS ---



	// --- BEGIN ---
	
	set firstStageCopy to firstStage:copy.

	set valid to false.
	until valid
	{
		set firstStageCopy to firstStage:copy.
		for part in firstStageCopy
		{
			set partModules to part:parent:modules.
			set mod to partModules:contains("ModuleDecouple").
			set fuel to part:resources.

			if fuel:length > 0
			{
				for fu in fuel
				{
					if fu:name = "LiquidFuel" OR fu:name = "Oxidizer"
					{
						if firstStageFuel:contains(part) = false
						{
							firstStageFuel:add(part).
						}	
					}
				}
			}
			
			if mod = true
			{
				firstStageDecouple:add(part:parent).
				set valid to true.
			}

			if firstStage:contains(part:parent) = false
			{
				firstStage:add(part:parent).
			}
		}	
	} 
}

function getActiveStage
{
	createActiveStage().
	return firstStage.
}

function getActiveFuel
{
	createActiveStage().
	return firstStageFuel.
}

function getActiveDecoupler
{
	createActiveStage().
	return firstStageDecouple.
}

function updateStageResources
{
	set activeOxy to 0.
	set activeFuel to 0.
	set oxyCap to 0.
	set fuelCap to 0.
	
	for f in firstStageFuel
	{
		set fres to f:resources.
		for m in fres
		{
			if m:name = "LiquidFuel"
			{
				set activeFuel to activeFuel + m:amount.
				set fuelCap to fuelCap + m:capacity.
			}
			else if m:name = "Oxidizer"
			{
				set activeOxy to activeOxy + m:amount.
				set oxyCap to oxyCap + m:capacity.
			}
		}	
	}
}

function autoStage
{
	updateStageResources().
	
	if activeOxy = 0 
	{
		set d to getActiveDecoupler().

		for de in d 
		{
			de:getModule("ModuleDecouple"):doevent("Decouple").
		}

		updateActiveEngines().
		wait 1.
		startActiveEngines().
	}
}
