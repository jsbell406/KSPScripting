
//When running script, enter 'run josh.ks(#)' where # is desired orbit.

parameter orbitAltitude.

//Easier file copying


//Set to path of file needing to be copied
set files to list(	"Launch/joshlaunch.ks","Launch/positionfunctions.ks","Launch/enginefunctions.ks",
					"Launch/shipfunctions.ks","Launch/launchfunctions.ks","Launch/joshfunctions.ks",
					"Launch/mathfunctions.ks", "Launch/jamesfunctions.ks", "lib.ks").


For file in files
{
copypath ("0:/"+file,"1:").
//print file + "...".
//print "Loaded.".
}.
switch to 1.
run JoshLaunch(orbitAltitude).
