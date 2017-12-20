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

set x to 0.
set y to 0.
set length to firstStage:length.
print firstStage.