// TESTING POTENTIAL STAGING METHODS
clearscreen.

// --- IMPORTS ---

RUN ONCE lib.ks(100000).

RUN ONCE EngineFunctions.ks(100000).
createFirstStage().
// --- LISTS ---

list parts in allParts.
list engines in myEngines.
set firstStage to list().
set firstStageEngines to getFirstStageEngines().

print myEngines.
print allParts.


// --- BEGIN ---



print firstStageEngines.





for part in firstStageEngines
{
	firstStage:add(part:parent).
}

print firstStage.

set nextPart to firstStage[firstStage:length -1].
firstStage:add(nextPart:parent).

print firstStage[0]:resources.
print firstStage[1]:modules.
print firstStage[1]:resources.

print firstStage.