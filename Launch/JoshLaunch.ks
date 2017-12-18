CLEARSCREEN. 
parameter orbitalHeight.
// --- IMPORTS ---
	RUN ONCE PositionFunctions.ks(orbitalHeight).
	RUN ONCE LaunchFunctions.ks.
	RUN ONCE ShipFunctions.ks.
	RUN ONCE MathFunctions.ks.
	RUN ONCE EngineFunctions.ks.
	RUN ONCE JoshFunctions.ks.
	
//SWITCH TO 1.
//COPYPATH("0:/UserFunctions.KS","").
//COPYPATH("0:/new.KS","").
createStartingPosition().
deployOrbitalAnchor(orbitalHeight).
thrustCalculations().
getLaunchClamps().
createFirstStage().
wait 1.
lock throttle to 1.
wait 1.
firstStageIgnition().
wait 0.05.
releaseLaunchClamps().

	
UNTIL apoapsis >= (orbitalHeight * 1.1)
{ 
	technicalReadout().
	//positionReadout().
	steerShipIf(orbitalHeight).
	lock throttle to adjustThrottle(1.25).
}

lock throttle to 0.


