
//When running script, enter 'run shane.ks(#)' where # is desired orbit.

parameter orbitAltitude.

//Easier file copying

set testScript to false.//Testing

if orbitAltitude = 1
{
	set orbitAltitude to 100000.
}
//Set to path of file needing to be copied
set files to list(	"Launch/shanelaunch.ks","Launch/positionfunctions.ks","Launch/enginefunctions.ks",
					"Launch/shipfunctions.ks","Launch/launchfunctions.ks","Launch/joshfunctions.ks",
					"Launch/mathfunctions.ks", "Launch/jamesfunctions.ks", "Launch/ManeuverFunctions.ks",
					"Launch/CheatFunctions.ks", "lib.ks", "Launch/joshtest.ks", "shane.ks", "Launch/ShaneFunctions.ks").


For file in files
{
copypath ("0:/"+file,"1:").
//print file + "...".
//print "Loaded.".
}.
switch to 1.
if testScript = false
{

	run ShaneLaunch.ks(orbitAltitude).
}
//else
//{
//	run JoshTest.ks(orbitAltitude).
//}
//Comment