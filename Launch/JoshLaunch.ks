CLEARSCREEN. 
parameter orbitalHeight.
// --- IMPORTS ---
	RUN ONCE PositionFunctions.ks(orbitalHeight).
	RUN ONCE LaunchFunctions.ks(orbitalHeight).
	RUN ONCE ShipFunctions.ks(orbitalHeight).
	RUN ONCE MathFunctions.ks(orbitalHeight).
	RUN ONCE EngineFunctions.ks(orbitalHeight).
	RUN ONCE JoshFunctions.ks(orbitalHeight).
	
//SWITCH TO 1.
//COPYPATH("0:/UserFunctions.KS","").
//COPYPATH("0:/new.KS","").
createStartingPosition().
deployOrbitalAnchor(orbitalHeight).
thrustCalculations().
getLaunchClamps().
createFirstStage().

set actThrottle to 1.
set actHeading to 90.
wait 1.
lock throttle to actThrottle.
wait 1.
firstStageIgnition().
wait 0.05.
releaseLaunchClamps().

	
UNTIL apoapsis >= (orbitalHeight * 1.1)
{ 
	technicalReadout().
	thrustCalculations().
	//positionReadout().
	lock steering to heading(90, actHeading).
	set actHeading to steerShipIf(orbitalHeight, actHeading).
	set actThrottle to adjustThrottle(1.25,actThrottle).
	//lock throttle to (round(adjustThrottle(1.25)), actThrottle).
	lock throttle to actThrottle.
}

lock throttle to 0.


