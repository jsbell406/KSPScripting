// TESTING POTENTIAL STAGING METHODS
clearscreen.

// --- IMPORTS ---

RUN ONCE lib.ks(100000).

RUN ONCE EngineFunctions.ks(100000).

// Creates Active stage, From bottom engines to First decoupler
function createActiveStage
{
	// Starting point is bottom engines of the craft createFirstStage lives in engine functions.
	createFirstStage().

	// --- LISTS ---

	set firstStage to getFirstStageEngines().
	set firstStageCopy to firstStage:copy.
	set firstStageFuel to list().
	set firstStageDecouple to list().

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
	return firstStage.
}

function getActiveFuel
{
	return firstStageFuel.
}

funtion getActiveDecoupler
{
	return firstStageDecouple.
}

function updateStageResources
{
	set activeOxy to 0.
	set activeFuel to 0.
	
	for f in firstStageFuel
	{
		set fmods to f:modules.
		for m in fmods
		{
			if m:name = "LiquidFuel"
			{
				set activeFuel to activeFuel + m:amount.
			}
			else if m:name = "Oxidizer"
			{
				set activeOxy to activeOxy + m:amount.
			}
		}	
	}
	print activeOxy.
	print activeFuel.
}

function autoStage
{


}

createActiveStage.
print "------ active stage -------".
print getActiveStage.
print "-------- fuel -------------".
print firstStageFuel.
print "-------- decoupler --------".
print firstStageDecouple.




// testing decoupler
//print allParts.
//set partModules to allParts[4]:modules.
//print partModules.


// for part in firstStageCopy
// {



// 	if firstStage:contains(part:parent) = false
// 	{
// 		firstStage:add(part:parent).
// 	}
// }

// set firstStageCopy to firstStage:copy.


// for part in firstStageCopy
// {



// 	set moduleName to "".


// 	if firstStage:contains(part:parent) = false
// 	{
// 		firstStage:add(part:parent).
// 	}
// }

// set firstStageCopy to firstStage:copy.


// for part in firstStageCopy
// {
// 	if firstStage:contains(part:parent) = false
// 	{
// 		firstStage:add(part:parent).
// 	}
// 	set partModules to part:parent:modules.
// 	set mod to partModules:contains("ModuleDecouple").
// 	print mod.
	


// 	set moduleName to "".


	
// }
// print partModules.
