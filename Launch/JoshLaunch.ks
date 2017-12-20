CLEARSCREEN. 
parameter orbitAltitude.
// --- IMPORTS ---
	// RUN ONCE PositionFunctions.ks(orbitAltitude).
	// RUN ONCE LaunchFunctions.ks(orbitAltitude).
	// RUN ONCE ShipFunctions.ks(orbitAltitude).
	// RUN ONCE MathFunctions.ks(orbitAltitude).
	// RUN ONCE EngineFunctions.ks(orbitAltitude).
	// RUN ONCE JoshFunctions.ks(orbitAltitude).
	// RUN ONCE JamesFunctions.ks(orbitAltitude).
	RUN ONCE lib.ks(orbitAltitude).
	
//SWITCH TO 1.
//COPYPATH("0:/UserFunctions.KS","").
//COPYPATH("0:/new.KS","").
lib(orbitAltitude).
createStartingPosition().
deployOrbitalAnchor(orbitAltitude).
thrustCalculations().
getLaunchClamps().
createFirstStage().

set activeThrottle to 1.
//set actHeading to 90.
wait 1.
lock throttle to activeThrottle.
wait 1.
firstStageIgnition().
wait 0.05.
releaseLaunchClamps().

	
// UNTIL ship:apoapsis >= orbitAltitude
// { 
	// technicalReadout().
	// thrustCalculations().
	// //positionReadout().
	
	// //Blatantly stolen for "testing"
	// steerShipJames().
	
	// //Previous method --
	// //lock steering to heading(90, actHeading).
	// //set actHeading to steerShipIf(orbitAltitude, actHeading).
	
	
	// set actThrottle to adjustThrottle(1.75,actThrottle).
	// lock throttle to actThrottle.
	
	// print "Actual Throttle:	" + actThrottle.
// }

until ship:apoapsis >= (orbitAltitude)
{
	thrustCalculations().
	steerShipJames().
	UNTIL SHIP:STATUS <> "FLYING"
	{ 
		//technicalReadout().
		set activeThrottle to adjustThrottle(1.5,activeThrottle).
		lock throttle to activeThrottle.
		tempTechReadout(orbitAltitude).
	
	}
	wait 0.5.

	UNTIL SHIP:STATUS <> "SUB_ORBITAL"
	{
		//technicalReadout().
		set activeThrottle to adjustThrottle(0.75,activeThrottle).
		lock throttle to activeThrottle.
		tempTechReadout(orbitAltitude).
	}
}

lock throttle to 0.
lock steering to prograde.

planCircManeuver(orbitAltitude).
execManeuver(orbitAltitude).

clearscreen.
print "Orbit complete at " + orbitAltitude + "m.".