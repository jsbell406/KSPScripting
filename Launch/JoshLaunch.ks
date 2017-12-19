CLEARSCREEN. 
parameter orbitalHeight.
// --- IMPORTS ---
	RUN ONCE PositionFunctions.ks(orbitalHeight).
	RUN ONCE LaunchFunctions.ks(orbitalHeight).
	RUN ONCE ShipFunctions.ks(orbitalHeight).
	RUN ONCE MathFunctions.ks(orbitalHeight).
	RUN ONCE EngineFunctions.ks(orbitalHeight).
	RUN ONCE JoshFunctions.ks(orbitalHeight).
	RUN ONCE JamesFunctions.ks(orbitalHeight).
	
//SWITCH TO 1.
//COPYPATH("0:/UserFunctions.KS","").
//COPYPATH("0:/new.KS","").
createStartingPosition().
deployOrbitalAnchor(orbitalHeight).
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

	
// UNTIL ship:apoapsis >= orbitalHeight
// { 
	// technicalReadout().
	// thrustCalculations().
	// //positionReadout().
	
	// //Blatantly stolen for "testing"
	// steerShipJames().
	
	// //Previous method --
	// //lock steering to heading(90, actHeading).
	// //set actHeading to steerShipIf(orbitalHeight, actHeading).
	
	
	// set actThrottle to adjustThrottle(1.75,actThrottle).
	// lock throttle to actThrottle.
	
	// print "Actual Throttle:	" + actThrottle.
// }

until ship:apoapsis >= orbitalHeight
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

planCircManeuver(orbitalHeight).
execManeuver(orbitalHeight).

clearscreen.
print "Orbit complete at " + orbitalHeight + "m.".


