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
	set firstStageFuel to firstStage:copy.

	// --- BEGIN ---
	
	set firstStageCopy to firstStage:copy.

	set valid to false.
	until valid
	{
		set firstStageCopy to firstStage:copy.
		for part in firstStageCopy
		{
			if firstStage:contains(part:parent) = false
			{
				firstStage:add(part:parent).
			}
			set partModules to part:parent:modules.
			set mod to partModules:contains("ModuleDecouple").

			if mod = true
			{
				set valid to true.
			}
		}	
	} 
}

function getActiveStage
{
	return firstStage.
}

function updateStageResources
{

}
function autoStage
{


}

createActiveStage.
print getActiveStage.




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
