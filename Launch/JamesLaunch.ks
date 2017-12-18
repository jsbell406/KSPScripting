CLEARSCREEN. 
parameter orbitalHeight.
// --- IMPORTS ---
	RUN ONCE PositionFunctions.ks(orbitalHeight).
	RUN ONCE LaunchFunctions.ks(orbitalHeight).
	RUN ONCE ShipFunctions.ks(orbitalHeight).
	RUN ONCE MathFunctions.ks(orbitalHeight).
	RUN ONCE EngineFunctions.ks(orbitalHeight).
	RUN ONCE JamesLaunch.ks(orbitalHeight).
	RUN ONCE JamesFunctions.ks(orbitalHeight).
	
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

	
UNTIL SHIP:STATUS = "ORBIT"
{ 
	technicalReadout().
	//positionReadout().
	steerShipJames().

}