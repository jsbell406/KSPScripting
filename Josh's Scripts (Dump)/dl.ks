//Robot activating...
CLEARSCREEN.

//<<--CHANGE THIS TO MODIFY TARGET LONGITUDE (Math not included)-->>
//SET myLoc to -100.00.

//print "FIRING LANDING THRUSTERS AT LONGITUDE " + myLoc.
//print "STANDBY>>>".

//AG3 arms the probe's chutes and disables SAS.
toggle AG3.
if SAS {
	SAS off.
}


//Engage Surface Retrograde lock and wait for the probe to complete the adjustment
lock steering to srfretrograde.
wait 30.

//Delay until target LONGITUDE
//wait until round (SHIP:GEOPOSITION:LNG,2) = myLoc.

// Print starting location
print "----------".
print "Starting coordinates:".
print "Lat:" + round (LATITUDE,3).
print "Long:" + round (LONGITUDE,3).

log "----------" to alttest.txt.
log "Starting coordinates:" to alttest.txt.
log "Lat:" + round (LATITUDE,3)to alttest.txt.
log "Long:" + round (LONGITUDE,3)to alttest.txt.
log "Starting altitude: " + ALTITUDE to alttest.txt. 
log "Starting radar altitude: " + ALT:RADAR to alttest.txt. 

//Close solar panels before descent and extends landing legs.
if PANELS {
PANELS off.
}

if GEAR = FALSE {
GEAR on.
}

//Initiate descent burn
until periapsis < 0 {
	lock throttle to 1.
}
lock throttle to 0.

//AG1 - High altitude science at 50km
wait until altitude < 49900. 
toggle AG1.

//Secondary descent burn, reduces airspeed enough to deploy chutes safely	
wait until altitude < 21000.
lock throttle to 1. 
wait until airspeed < 550. 
lock throttle to 0.

//AG2 - Low altitude science
wait until alt:radar < 5000. 
toggle AG2.

//Final descent	
wait until alt:radar < 1000.
unlock steering.

wait until alt:radar < 200.
SAS on.	
wait 3.

//Used in testing.
wait until alt:radar < 3.	
print "Ending coordinates:"	.
print "Lat:" + round (LATITUDE,3).
print "Long:" + round (LONGITUDE,3).

log "-" to alttest.txt.
log "Ending coordinates:" to alttest.txt.
log "Lat:" + round (LATITUDE,3)to alttest.txt.
log "Long:" + round (LONGITUDE,3)to alttest.txt.

	

