parameter orbitAltitude.
//set orbitAltitude to 100000.
// --- IMPORTS ---
	// RUN ONCE PositionFunctions.ks(orbitAltitude).
	// RUN ONCE LaunchFunctions.ks(orbitAltitude).
	// RUN ONCE ShipFunctions.ks(orbitAltitude).
	// RUN ONCE MathFunctions.ks(orbitAltitude).
	// RUN ONCE EngineFunctions.ks(orbitAltitude).
	// RUN ONCE JoshFunctions.ks(orbitAltitude).
	// RUN ONCE JamesFunctions.ks(orbitAltitude).
	RUN ONCE lib.ks(orbitAltitude).
	
lib(orbitAltitude).
//createStartingPosition().
//deployOrbitalAnchor(orbitAltitude).
thrustCalculations().
//getLaunchClamps().
//createFirstStage().
setLunarManu(orbitAltitude).

until nextnode:eta < 150 {

	if nextnode:eta > 150 {
		timWarp(nextnode:eta - 100).
		wait until kuniverse:timewarp:warp = 0.
		remove nextnode.
		setLunarManu(orbitAltitude).
	}
}
//timWarp(nextnode:eta - 240).
//wait 5.
execManeuver(orbitAltitude).
wait 5. 
timWarp(ship:orbit:nextpatcheta).
wait until orbit:body:name = "mun".	
wait 5.
if orbit:periapsis <  orbitAltitude{
	setCorrectionNode(orbitAltitude).
	wait 5.
	execManeuver(orbitAltitude).
}
//timWarp(eta:periapsis - 60).
wait 5.
timWarp(eta:periapsis - 60).
wait until kuniverse:timewarp:warp = 0.
planCircularizationManeuver(orbitAltitude).
wait 5.
execManeuver(orbitAltitude).



