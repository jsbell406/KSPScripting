// TESTING POTENTIAL STAGING METHODS



// TO-DO: Decoupler and fuel tanks not updating after decouple
clearscreen.
parameter orbitalHeight.

// --- IMPORTS ---

RUN ONCE lib.ks(orbitalHeight).
RUN ONCE EngineFunctions.ks(orbitalHeight).

// Creates Active stage, From bottom engines to First decoupler
function autoStage
{
	clearscreen.
	set actE to getActiveEngines().
	

	for e in actE 
	{
		set o to e:flameout.
		if o = true
		{
			set huh to mapStage(e).
			set pee to canIDecouple(huh).
			if pee = true
			{
				huh:getModule("ModuleDecouple"):doevent("Decouple").
				return true.
			}
		}
		return false.
	}
}

function canIDecouple
{
	parameter d.
	set pm to d:modules.
	if pm:length > 0 
	{
		return pm:contains("ModuleDecouple").
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

