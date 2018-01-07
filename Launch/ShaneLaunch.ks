// "When an accelerometer won't fit into it's keyed slot... pound it with a sledge hammer until it does"... said the Russian engineer in 2006 right before Proton crashed on launch
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
//Testing of Cheat staging script
stage.

	
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

set thrustLimiter to 1.5.
//set thrustLim to thrustLimiter(orbitAltitude).

until ship:apoapsis >= (orbitAltitude)
{
	
	
	// set activeThrottle to adjustThrottle(thrustLim,activeThrottle).
	lock throttle to activeThrottle.
		
	UNTIL SHIP:STATUS <> "FLYING"
	{ 
		//technicalReadout().
		thrustCalculations().
		steerShipJames().
		aspStageReady().
		//tempTechReadout(orbitAltitude, activeThrottle).
		
		set activeThrottle to adjustThrottle(1.5,activeThrottle).
		lock throttle to activeThrottle.
	
	}
	wait 0.01.

	UNTIL (SHIP:STATUS <> "SUB_ORBITAL") OR (ship:apoapsis >= orbitAltitude)
	{
		//technicalReadout().
		thrustCalculations().
		steerShipJames().
		aspStageReady().
		//tempTechReadout(orbitAltitude, activeThrottle).
		
		//set thrustLim to thrustLimiter(orbitAltitude).
		set activeThrottle to adjustThrottle(1.2 , activeThrottle).
		lock throttle to activeThrottle.
	}
}

lock throttle to 0.
lock steering to prograde.

planCircManeuver(orbitAltitude).
execManeuver(orbitAltitude).

set ship:control:mainthrottle to 0.
lock steering to prograde.

clearscreen.
print "Orbit complete at " + orbitAltitude + "m.".