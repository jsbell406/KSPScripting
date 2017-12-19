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

until ship:apoapsis >= (orbitAltitude - ship:altitude)
{
	UNTIL SHIP:STATUS <> "FLYING"
	{ 
		thrustCalculations().
		technicalReadout().
		//positionReadout().
		steerShipJames().
		set activeThrottle to adjustThrottle(1.5,activeThrottle).
		lock throttle to activeThrottle.
		print "TWR/TWR(surface):" + round(actTWR, 2) + "/" + round(maxTWR , 2).
		print "Actual Throttle:	" + activeThrottle.

	
	}
	wait 0.5.

	UNTIL SHIP:STATUS <> "SUB_ORBITAL"
	{
		thrustCalculations().
		technicalReadout().
		//positionReadout().
		steerShipJames().
		set activeThrottle to adjustThrottle(0.75,activeThrottle).
		lock throttle to activeThrottle.
		print "TWR/TWR(surface):" + round(actTWR, 2) + "/" + round(maxTWR , 2).
		print "Actual Throttle:	" + activeThrottle.

	}
}

lock throttle to 0.
lock steering to prograde.

planCircManeuver(orbitAltitude).
execManeuver(orbitAltitude).

clearscreen.
print "Orbit complete at " + orbitAltitude + "m.".


