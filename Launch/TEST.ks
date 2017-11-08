CLEARSCREEN. 
RUN ONCE UserFunctions.ks.
PRINT "BEGIN COUNTDOWN: ".
SET flightComputer TO UP + R(0,0,90).
SET desiredOrbit TO 80000.
SET engineThrottle TO 1.
FROM { LOCAL countDown IS 10. } UNTIL countDown = 0 STEP { SET countDown TO countDown -1. }
	DO 
	{
		IF countDown = 9 
		{
			PRINT "****** THROTTLE CHECK *******".
			LOCK THROTTLE TO 0.
			WAIT 0.5.
			LOCK THROTTLE TO 1.	
		}
		IF countDown = 3
		{
			PRINT " ******** SENSORS AND CALCULATIONS CHECK ********* ".
			thrustCalculations().
		}
		IF countDown = 2
		{
			PRINT " ******** CALIBRATING AVIONICS ********".
			LOCK STEERING TO flightComputer.
			LOCK THROTTLE TO engineThrottle.
		}
		IF countDown = 1
		{
			PRINT "******* ENGINE IGNITION ********".
			STAGE.
		}
		PRINT " "  + countDown.
		WAIT 1.
	}	

STAGE.
PRINT " ********* LIFT OFF **********".
WAIT 1.
PRINT " TOWER CLEARED ".
WAIT 1.
PRINT " STAGE ONE FLIGHT ".
WAIT 1.
SET desiredHeading TO UP + R(0,0,180).


UNTIL SHIP:STATUS = "ORBIT"
{ 
	thrustCalculations().
	technicalReadOut().
	IF altitude < 3000 AND altitude > 2000 
	{
		SET desiredHeading TO HEADING(90,85) + R(0,0,180).
		LOCK STEERING TO desiredHeading.
	}.
	
	IF actTWR > 1.55
	{
		UNTIL actTWR < 1.45
		{
			thrustCalculations().
			technicalReadOut().
			SET engineThrottle TO engineThrottle - 0.01.
			LOCK THROTTLE TO engineThrottle.			
		}
				
	}
	WAIT 1.
	
	WHEN MAXTHRUST = 0 THEN 
	{
		STAGE.
		PRESERVE.
	}.

	WAIT 1.
	
	WAIT 1.
	PRINT " ROLL PROGRAM INITALIZED ".
	
	WAIT 1.
	PRINT " ROLL PROGRAM UNDERWAY ".
	IF altitude > 5000 AND altitude < 15000
	{
		SET desiredHeading TO srfprograde + R(0,0,180).
		LOCK STEERING TO desiredHeading.
	}.
	WAIT UNTIL airspeed > 100.
	
IF altitude > 15500
	{
		SET desiredHeading TO prograde + R(0,0,180).
		LOCK STEERING TO desiredHeading.
	}.
	
	
}.	

	


