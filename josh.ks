
//When running script, enter 'run josh.ks(#)' where # is desired orbit.

parameter orbitAltitude.

//Easier file copying

if orbitAltitude = 1
{
	set orbitAltitude to 100000.
}
//Set to path of file needing to be copied
set files to list(	"Launch/joshlaunch.ks","Launch/positionfunctions.ks","Launch/enginefunctions.ks",
					"Launch/shipfunctions.ks","Launch/launchfunctions.ks","Launch/joshfunctions.ks",
					"Launch/mathfunctions.ks", "Launch/jamesfunctions.ks", "Launch/ManeuverFunctions",
					"Launch/CheatFunctions", "lib.ks").


For file in files
{
copypath ("0:/"+file,"1:").
//print file + "...".
//print "Loaded.".
}.
switch to 1.
run JoshLaunch(orbitAltitude).
//Comment