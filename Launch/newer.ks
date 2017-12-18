CLEARSCREEN. 
parameter orbitalHeight.
RUN ONCE UserFunctions.ks(orbitalHeight).
RUN ONCE PositionFunctions.ks(orbitalHeight).
RUN ONCE EngineFunctions.ks.
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

updateActiveEngines().
shutdownActiveEngines().










// set ch to terminal:input:getchar().

// if ch = terminal:input:DOWNCURSORONE {
  // print "You typed the down-arrow key.".
// }
// if ch = terminal:input:UPCURSORONE {
  // print "You typed the up-arrow key.".
// }

// SET anArrow TO VECDRAW(
      // V(0,0,0),
	  // V(100,0,0),
      // RGB(1,0,0),
      // "See the arrow?",
      // 1.0,
      // TRUE,
      // 0.2
    // ).