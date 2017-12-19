CLEARSCREEN. 
parameter orbitalHeight.


// --- IMPORTS ---

	RUN ONCE lib.ks(orbitalHeight).

createStartingPosition().
deployOrbitalAnchor(orbitalHeight).

getLaunchClamps().
createFirstStage().


set activeThrottle to 1.
wait 1.
lock throttle to activeThrottle.
wait 1.
firstStageIgnition().
wait 0.05.
releaseLaunchClamps().
wait 1.

	
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