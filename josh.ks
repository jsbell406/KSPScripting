
//When running script, enter 'run josh.ks(#)' where # is desired orbit.

parameter orbitalHeight.

//Easier file copying


//Set to path of file needing to be copied
set files to list("Launch/newer.ks","Launch/userfunctions.ks").


For file in files
{
copypath ("0:/"+file,"1:").
print file + "...".
print "Loaded.".
wait 1.
}.
switch to 1.
run newer.ks(orbitalHeight).
