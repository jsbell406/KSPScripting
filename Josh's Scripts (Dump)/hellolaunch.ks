//helloLaunch

//Clearing terminal
clearscreen.

//Countdown loop
print "Counting down:".
from {local countdown is 10.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
	PRINT "..." + countdown.
	WAIT 1.
}

WHEN MAXTHRUST = 0 THEN {
	PRINT "Staging...".
	LOCK THROTTLE to 1.0.
	STAGE.
	PRESERVE.
}

SET MYSTEER TO HEADING(90,90).
LOCK STEERING TO MYSTEER.
UNTIL SHIP:APOAPSIS > 75000 {
	IF SHIP:VELOCITY:SURFACE:MAG < 20 {
		Set MYSTEER TO HEADING(90,90).
	} ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 20 {
		SET MYSTEER TO HEADING(90,80).
		PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).
	} ELSE IF SHIP:ALTITUDE > 25000 AND SHIP:VELOCITY:SURFACE:MAG >= 20 {
		SET MYSTEER TO HEADING(90,70).
		PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).
	} ELSE IF SHIP:ALTITUDE > 45000 AND SHIP:VELOCITY:SURFACE:MAG >= 20 {
		SET MYSTEER TO HEADING(90,60).
		PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).
	}	
}.

LOCK THROTTLE to 0.

WAIT UNTIL SHIP:ALTITUDE > 70000.

SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.