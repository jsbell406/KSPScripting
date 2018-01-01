// TESTING POTENTIAL STAGING METHODS



// TO-DO: Determine why the DMagic parts won't trigger the initial check but still have data.
// TO-DO: The seismic sensor initial check is reporting "Data Collected" while in orbit.
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
	set isScienceModule to (partModules:contains("dmmodulescienceanimate")) or (partModules:contains("ModuleScienceExperiment")).
	
	if isScienceModule = TRUE
	{
		scienceParts:add(part).
	}	
}
//print scienceParts.
// set indivSciencePartTest to scienceParts[7].
// print " ".
// print "##-- " + indivSciencePartTest:name + " modules: ".
// print indivSciencePartTest:modules.


set scienceModules to list().

for indivSciencePart in scienceParts
{
	//break.
	if indivSciencePart:modules:contains("ModuleScienceExperiment")
	{
		scienceModules:add(indivSciencePart:getmodule("ModuleScienceExperiment")).
	}
	if indivSciencePart:modules:contains("dmmodulescienceanimate")
	{ 
		scienceModules:add(indivSciencePart:getmodule("dmmodulescienceanimate")).
	}
}
	

	//set scienceActions to scienceModules:allactionnames.
	// print indivSciencePart:name + " - Actions:".
	// print scienceActions.
	// print "--".
	// set scienceEvents to scienceModules:alleventnames.
	// print indivSciencePart:name + " - Events:".
	// print scienceEvents.
	// print "++".

set data to false.
for indivModule in scienceModules
	{
		set scienceActions to indivModule:allactionnames.
		for indivExperiment in scienceActions
		{
			
			if indivModule:name = ("ModuleScienceExperiment") and data = false
			{
				if indivModule:hasdata = true
				{
					print indivModule:part:title + " - No new data collected.".
					print " ".
					set data to true.
					wait 1.					
				}

				else
				{
					indivModule:deploy().
					wait 2.
					if indivModule:hasdata
					{
						print indivModule:part:title + " - Data collected".
						print " ".
					}
					else
					{
						print indivModule:part:title + " - Unknown error".
						print " ".
					} 
					wait 1.
					set data to true.
				}
			}
			
			if indivModule:name = ("dmmodulescienceanimate") and data = false
			{
				set data to false.
				if indivModule:hasdata
				{
					print indivModule:part:title + " - No new data collected".
					print " ".
					set data to true.
					wait 1.
				}

				else	
				{
					indivModule:deploy().
					wait 2.
					if indivModule:hasdata
					{
					print indivModule:part:title + " - Data collected".
					print " ".
					set data to true.
					}
						
					else
					{
						print indivModule:part:title + " - Unknown error".
						print " ".
						set data to true.
					}
					wait 1.
				}
			}
		}		
			set data to false.
	}
print ">< Preparing to transmit data ><".
print ".".
wait .5.
print ".".
wait .5.
print ".".
wait .5.

set connectionToCom to homeconnection.
print ">< Testing connection ><".
wait 1.5.
print ". ".
wait 1.5.
print ". ".
wait 2.
print ".".
if connectionToCom:isconnected
{
	print ">< Connection confirmed ><".
	print ".".
	wait 0.5.
	print ">< Preparing to transmit ><".
	wait 1.
	print ".".
	wait 1.
	print ".".
	for indivModule in scienceModules
	{
		set transmit to false.
		if indivModule:rerunnable and indivModule:hasdata
		{
			print "Transmitting science from " + indivModule:part:title + ".".
			indivModule:transmit().
			until isTransmitting = false
			{
				wait 0.5.
			}
			wait 0.5.
			print "...Transmission complete.".
			print " ".
			wait 0.5.
			set transmit to true.
		}
		if indivModule:rerunnable =  false and indivModule:hasdata and transmit = false
		{
			print "++ERROR++".
			print "  " + indivModule:part:title + " cannot be reset. No data has been transmitted.".
			print " ".
			wait 0.5.
		}
		if indivModule:hasdata =  false and transmit = false
		{
			print "++ERROR++". 
			print "  " + indivModule:part:title + " has no data to transmit.".
			print " ".
			wait 0.5.
		}
	}
}

//Ideally returns a boolean.
function isTransmitting
{
	set allAntennas to list().
	list parts in allparts.

	for part in allparts 
	{
		set partModules to part:modules.
		set isRTAntenna to partModules:contains("ModuleRTDataTransmitter").

		if isRTAntenna = true
		{
			allAntennas:add(part).
		}
	}

	set antStatusList to list().
	for indivAntenna in allAntennas
	{
		set antModule to indivAntenna:getmodule("ModuleRTDataTransmitter").
		antStatusList:add(antModule:getfield("comms")).
	}

	if antStatusList:contains("Uploading Data...")
	{
		return true.
	}
	else
	{
		return false.
	}
}
