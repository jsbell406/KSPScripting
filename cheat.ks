
//When running script, enter 'run josh.ks(#)' where # is desired orbit.

parameter orbitAltitude.

//Easier file copying


//Set to path of file needing to be copied
set files to list(	"Launch/cheatlaunch.ks","Launch/positionfunctions.ks","Launch/enginefunctions.ks",
					"Launch/shipfunctions.ks","Launch/launchfunctions.ks","Launch/joshfunctions.ks",
					"Launch/mathfunctions.ks", "Launch/jamesfunctions.ks", "Launch/ManeuverFunctions",
					"Launch/cheatfunctions.ks","lib.ks").


For file in files
{
copypath ("0:/"+file,"1:").
//print file + "...".
//print "Loaded.".
}.
switch to 1.
run CheatLaunch(orbitAltitude).
//Comment t