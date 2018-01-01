// TESTING POTENTIAL STAGING METHODS

// TO-DO: update variable names to match proper naming conventions
// TO-DO: document functions for readability and integration into general functions
// TO-DO: 

// NOTES: mapping stage after engine flameout is slow and most likely wont work in 
//operation.
//        Need to pre-map stages and maintain a relation between each engine and their associated
//        decoupler
clearscreen.
parameter orbitalHeight.

// --- IMPORTS ---

RUN ONCE lib.ks(orbitalHeight).
RUN ONCE EngineFunctions.ks(orbitalHeight).

updateActiveEngines().

list engines in craftEngines.
set activeEngines to getActiveEngines().
set enginesLength to craftEngines:length.

set decouplers to list().
set stageFuel to list().
set stagePower to list().
set validResources to list("ElectricCharge","LiquidFuel","Oxydizer").
set validLiquidFuel to list("LiquidFuel","Oxydizer").
list parts in craftParts.
list resources in craftResources.
set stageParts to list().

//print craftParts.
set f to craftParts[37].
set n to isFuelTank(f).
print f.
print n.

from {local x to 0.} until x >= enginesLength step {set x to x + 1.}
DO 
{

	set engine to craftEngines[x].
	print x.
	mapStageTest(engine,x).
	
	

	
	
	
}
print stageParts.

function mapStageTest
{
	parameter engine.
	parameter x.
	print x.
	stageParts:add(list()).
	stageParts[x]:add(engine).
	set stagePartsCopy to stageParts:copy.
	set isDone to false.

	until isDone
	{
		set switch to false.
		for part in stagePartsCopy
		{
			stageParts[x]:add(part).

			if canIDecouple(part)
			{
				decouplers:insert(x,part).
				set switch to true.
			}
			else if part:hasparent = false
			{
				set switch to true.
				decouplers:insert(x,"Stage Doesn't Have a decoupler").
			}
			
			if switch = false
			{
				if stageParts[x]:contains(part:parent) = false
				{
					stageParts[x]:add(part:parent). 
					
					set stagePartsCopy to stageParts:copy.
				}
			}

		 	if switch = true
			{
				set isDone to true.
			}
		}	
	} 
}

function isFuelTank 
{
	parameter part.
	set isFT to false.

	if part:resources:length > 0
	{
		set partResources to part:resources.
		for resource in partResources
		{
			set resourceName to resource:name.
			if validLiquidFuel:contains(resourceName)
			{
				set isFT to true.
			}
		}
	}
	return isFT.
}

// --- AUTO STAGE FUNCTIONS ---


// call autoStage to track when an active engine runs out of fuel
// autoStage will decouple the section the out of fuel engine is attached to
// autoState returns true if a decouple event has occured
function autoStage
{
	// activeEngines is set to any engine that is activated and has fuel
	// is a list of engines
	set activeEngines to getActiveEngines().
	
	// for each engine in activeEngines list......  
	for engine in activeEngines 
	{
		// is this engine out of fuel? boolean value
		set isOutOfFuel to engine:flameout.

		if isOutOfFuel = true
		{
			// passes the out of fuel engine to mapStage function
			// mapStage function returns either a decoupler, or root part of the craft
			// this part is stored in endStagePart
			set endStagePart to mapStage(engine).

			// checks to see if endStagePart is a decoupler. boolean value
			set isDecoupler to canIDecouple(endStagePart).

			if isDecoupler = true
			{
				// at this point endStagePart is a decoupler, and shouldn't be the root part

				// get the modules of the decoupler in-line with the out of fuel engine
				set decouplerModules to endStagePart:modules.

				// decoupler uses a stack decouple system "ModuleDecouple"
				if decouplerModules:contains("ModuleDecouple")
				{
					// gets the decouple module and activates it
					endStagePart:getModule("ModuleDecouple"):doevent("Decouple").

					// decouple
					return true.
				}
				// decoupler uses a radial decouple system "ModuleAnchoredDecoupler"
				else if decouplerModules:contains("ModuleAnchoredDecoupler")
				{	
					// gets the decouple module and activates it
					endStagePart:getModule("ModuleAnchoredDecoupler"):doevent("Decouple").

					// decouple
					return true.
				}
			}
		}
		// no decouple
		return false.
	}
}

function canIDecouple
{
	parameter d.
	set pm to d:modules.
	
	if pm:length > 0 
	{
		if pm:contains("ModuleDecouple") or pm:contains("ModuleAnchoredDecoupler")
		{
		
			return true.
		}
		return false.
	}
	else
	{
		return false.
	}
}

function mapStage
{
	parameter aWhatsIt.

	set s to list().
	s:add(aWhatsIt).
	set sc to s:copy.

	set isFatLadySinging to false.

	until isFatLadySinging
	{

		for p in sc
		{
			set pe to canIDecouple(p).
			if pe = true
			{
				return p.
			}

			if p:hasparent = true
			{
				if s:contains(p:parent) = false
				{
					s:add(p:parent). 
					set isFatLadySinging to false.
					set sc to s:copy.
				}
			}
			else
			{
				return p.
			}
		}	
	} 
}

