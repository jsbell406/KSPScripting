// TESTING POTENTIAL STAGING METHODS



// TO DO 
// Decoupler and fuel tanks not updating after decouple
clearscreen.
parameter orbitalHeight.

// --- IMPORTS ---

RUN ONCE lib.ks(orbitalHeight).
RUN ONCE EngineFunctions.ks(orbitalHeight).

	set firstStage to list().
	set firstStageCopy to list().
	set firstStageFuel to list().
	set firstStageDecouple to list().
	set partModules to list().
	
// Creates Active stage, From bottom engines to First decoupler
function createActiveStage
{
	// Starting point is bottom engines of the craft createFirstStage lives in engine functions.
	updateActiveEngines().
	set mod to false.

	// --- LISTS ---
	partModules:clear().
	firstStage:clear().
	firstStageCopy:clear().
	firstStageDecouple:clear().
	firstStageFuel:clear().

	set firstStage to getActiveEngines().
	set firstStageCopy to firstStage:copy.

	// --- BEGIN ---
	

	set valid to false.
	until valid
	{
		set firstStageCopy to firstStage:copy.
		for part in firstStageCopy
		{
			//set parpar to part:parent.
			//set partModules to parpar:modules.
	

			//if partModules:length > 0
			//{
				//set partModules to part:parent:modules.
				//set mod to partModules:contains("ModuleDecouple").
			//}
			
			set partModules to part:modules.
			if partModules:length > 0 
			{
				set mod to partModules:contains("ModuleDecouple").
				//print mod.
			}

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
				firstStageDecouple:add(part).
				set valid to true.
				//break.
			}

			if part:hasparent = true
			{
				if firstStage:contains(part:parent) = false
				{
					firstStage:add(part:parent).
				}
			}
		}	
	} 
	print "------decouple------".
	print firstStageDecouple.
	print "------decouple------".
	wait 5.
}

function updateStageResources
{
	set activeOxy to 0.
	set activeFuel to 0.
	set oxyCap to 0.
	set fuelCap to 0.
	
	print "firststagefuel " + firstStageFuel.
	for f in firstStageFuel
	{
		set fres to f:resources.
		for m in fres
		{
			if m:name = "LiquidFuel"
			{
				set activeFuel to Round(activeFuel + m:amount,1).
				set fuelCap to Round(fuelCap + m:capacity,1).
			}
			else if m:name = "Oxidizer"
			{
				set activeOxy to Round(activeOxy + m:amount,1).
				set oxyCap to Round(oxyCap + m:capacity,1).
			}
		}	
	}
}

function autoStage
{
	updateStageResources().
	print "activeoxy" + activeOxy.
	print "decoupler" + getActiveDecoupler().
	//print getActiveEngines().
	if activeOxy = 0 
	{
		set d to getActiveDecoupler().
		print "active engines" + getActiveEngines().
		print "decoupler" + getActiveDecoupler().

		for de in d 
		{
			set partModules to de:modules.
			de:getModule("ModuleDecouple"):doevent("Decouple").
			//createActiveStage().
			print "Decouple".
		}

		updateStageResources().
		print "after Decouple".
		wait 1.
		print "after wait".
		updateActiveEngines().
		print "active engines" + getActiveEngines().
		wait 1.
		updateStageResources().
		//createActiveStage().
		updateStageResources().
		wait 1.
		print "decoupler" + getActiveDecoupler().
		wait 1.
		print "activeoxy" + activeOxy.
		wait 1.
		print "active engines" + getActiveEngines().
		wait 1.

		updateStageResources().
		startActiveEngines().
	}
}

function getActiveStage
{
	//createActiveStage().
	return firstStage.
}

function getActiveFuel
{
	//createActiveStage().
	return firstStageFuel.
}

function getActiveDecoupler
{
	//createActiveStage().
	return firstStageDecouple.
}
