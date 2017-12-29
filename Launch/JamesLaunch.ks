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
	RUN ONCE JamesTest.ks(orbitAltitude).
	
//SWITCH TO 1.
//COPYPATH("0:/UserFunctions.KS","").
//COPYPATH("0:/new.KS","").
lib(orbitAltitude).
//createStartingPosition().
thrustCalculations().
//getLaunchClamps().
createFirstStage().
updateActiveEngines().


set activeThrottle to 1.
//set actHeading to 90.
wait 1.
lock throttle to activeThrottle.
wait 1.
startActiveEngines().
wait 0.05.
//releaseLaunchClamps().

	
UNTIL SHIP:STATUS <> "PRELAUNCH"
{ 
	//thrustCalculations().
	//technicalReadout().
	//positionReadout().
	steerShipJames().
	set activeThrottle to adjustThrottle(1.5,activeThrottle).
	lock throttle to activeThrottle.
	//print "TWR/TWR(surface):" + round(actTWR, 2) + "/" + round(maxTWR , 2).
	//print "Actual Throttle:	" + activeThrottle.
	
	set sta to autoStage().
	if sta = true
	{
		updateActiveEngines().
		wait 0.5.
		startActiveEngines().
	}
	updateActiveEngines().

}
//wait 0.5.

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