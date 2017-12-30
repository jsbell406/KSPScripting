// TESTING POTENTIAL STAGING METHODS



// TO-DO: Decoupler and fuel tanks not updating after decouple
clearscreen.
parameter orbitalHeight.

// --- IMPORTS ---

RUN ONCE lib.ks(orbitalHeight).
RUN ONCE EngineFunctions.ks(orbitalHeight).


// --- AUTO STAGE FUNCTIONS ---
list parts in allparts.
set scienceParts to list().
for part in allparts
{
	set partModules to part:modules.
	set isScienceModule to partModules:contains("ModuleScienceExperiment").
	
	if isScienceModule = TRUE
	{
		scienceParts:add(part).
	}	
}
print allparts.


for indivSciencePart in scienceParts
{
	set scienceModules to indivSciencePart:getmodule("ModuleScienceExperiment").
	set scienceActions to scienceModules:allactionnames.
	// print indivSciencePart:name + " - Actions:".
	// print scienceActions.
	// print "--".
	// set scienceEvents to scienceModules:alleventnames.
	// print indivSciencePart:name + " - Events:".
	// print scienceEvents.
	// print "++".


	//This stuff works for normal experiments
	// for indivExperiment in scienceActions
	// 	{
	// 		if scienceModules:hasdata = false
	// 		{
	// 			scienceModules:deploy().
	// 		}
	// 	}
	// set connectionToCom to homeconnection.
	// if connectionToCom:isconnected and scienceModules:rerunnable
	// {
	// 	print "We're Connected! " + "Transmitting science from " + indivSciencePart:name.
	// 	scienceModules:transmit().
	// }
	// if scienceModules:rerunnable =  false
	// {
	// 	print indivSciencePart:name + " cannot be reset. No data has been transmitted.".
	// }
}