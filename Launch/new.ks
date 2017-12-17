CLEARSCREEN. 

RUN ONCE UserFunctions.ks.
SWITCH TO 1.
//COPYPATH("0:/UserFunctions.KS","").
//COPYPATH("0:/new.KS","").
createStartingPosition().
deployOrbitalAnchor(100000).
print getDownRangeDistanceAct(100000).






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
	steerShip().

}











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