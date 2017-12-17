//When running script, enter 'run josh.ks(#)' where # is desired orbit.

parameter orbitalHeight.

//Easier file copying


//Set to path of file needing to be copied
set files to list("Launch/JamesLaunch.ks","Launch/userfunctions.ks","Launch/positionfunctions.ks","Launch/enginefunctions.ks","Launch/mathfunctions.ks","Launch/shipfunctions.ks","Launch/launchfunctions.ks").


For file in files
{
copypath ("0:/"+file,"1:").
print file + "...".
print "Loaded.".
wait 1.
}.
switch to 1.
run JamesLaunch.ks(orbitalHeight).
