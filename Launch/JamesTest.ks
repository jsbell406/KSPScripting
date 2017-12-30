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


// --- AUTO STAGE FUNCTIONS ---

// call autoStage to track when an engine runs out of fuel
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
			// this part is store in endStagePart
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
				else if mo:contains("ModuleAnchoredDecoupler")
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

