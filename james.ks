//When running script, enter 'run josh.ks(#)' where # is desired orbit.

parameter orbitalHeight.

//Easier file copying


set testScript to false.//Testing



//Set to path of file needing to be copied
set files to list("lib.ks","Launch/jamestest.ks","Launch/JamesLaunch.ks",
				  "Launch/jamesfunctions.ks","Launch/positionfunctions.ks",
				  "Launch/enginefunctions.ks","Launch/mathfunctions.ks",
				  "Launch/shipfunctions.ks","Launch/launchfunctions.ks",
				  "Launch/joshfunctions.ks","Launch/maneuverfunctions.ks",
				  "Launch/cheatfunctions.ks").


For file in files
{
copypath ("0:/"+file,"1:").
print file + "...".
print "Loaded.".
wait 0.01.
}.
switch to 1.

if testScript = false
{

	run JamesLaunch.ks(orbitalHeight).
}
else
{
	run JamesTest.ks(orbitalHeight).
}

