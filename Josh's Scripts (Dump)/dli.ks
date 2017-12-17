//Here there be functions
FUNCTION MANTIME {
	parameter dv.
	
	list ENGINES in eng.
	
	local engT is eng[0]:MAXTHRUST * 1000.
	local vesMass is SHIP:MASS * 1000.
	local e is CONSTANT():E.
	local engISP is eng[0]:ISP.
	local g is 9.80665.

	return g * vesMass * engISP * (1 -  e^(-dv/(g*engISP))) / engT.
}


// Duna Lander Insertion Script
//Robot activating...
wait 0.1.
clearscreen.

//Set this to the desired circular orbit
set tarOrb to 20000.


//Creates a manuever node and places it on the craft's apoapsis
set tarMan to node(time:seconds+ETA:APOAPSIS, 0, 0, -5).
add tarMan.
print "Selected insertion orbit is " + tarOrb + "m.".

//Manuever tuning to bring periapsis to desired orbit, three loops for accuracy
until tarMan:ORBIT:PERIAPSIS < (tarOrb + 4000) {
	set tarMan:PROGRADE to tarMan:PROGRADE-1.
	clearscreen.
	print "dV use: " + round(tarMan:PROGRADE,2).
}
until tarMan:ORBIT:PERIAPSIS < (tarOrb + 25) {
	set tarMan:PROGRADE to tarMan:PROGRADE-0.001.
	clearscreen.
	print "dV use: " + round(tarMan:PROGRADE,2).
}
until tarMan:ORBIT:PERIAPSIS <= tarOrb {
	set tarMan:PROGRADE to tarMan:PROGRADE-0.0001.
	clearscreen.
	print "dV use: " + round(tarMan:PROGRADE,2).
}

if maxthrust = 0 { stage.}

//Aim craft to manuever node
if SAS {
	SAS off.
}
wait 1.
lock STEERING to tarMan:DELTAV.
wait 30.

//Set variable 't' to total time required for manuever.
set t to MANTIME(tarMan:DELTAV:MAG).
print "Burn time: " + round (t,1) + " seconds".
wait 5.

//Warp to 30 seconds before manuever
warpto(TIME:SECONDS + (tarMan:ETA - 30 - t)).

//Manuever burn. Utilizes 't' for burn timing and switches to SAS to reduce drift
wait until tarMan:ETA <= (t/2).
unlock STEERING.
SAS ON.

//Throttle is maxed until remaining manuevertime is less than 1 second
lock THROTTLE to MIN(MANTIME(tarMan:DELTAV:MAG), 1).
wait t.
SAS OFF.
lock STEERING to RETROGRADE.
lock THROTTLE to 0.

//Fine-tuning of periapsis

until PERIAPSIS <= tarOrb {
	lock THROTTLE to 0.1.
}
lock THROTTLE to 0.

remove NEXTNODE.

//Repeat of previous manuever creation except to change apoapsis.
set tarMan to node(time:seconds+ETA:PERIAPSIS, 0, 0, -5).
add tarMan.
print "Selected insertion orbit is " + tarOrb + "m.".
until tarMan:ORBIT:APOAPSIS < (tarOrb + 4000) {
	set tarMan:PROGRADE to tarMan:PROGRADE-1.
	clearscreen.
	print "dV use: " + round(tarMan:PROGRADE,2).
}

until tarMan:ORBIT:APOAPSIS < (tarOrb + 50) {
	set tarMan:PROGRADE to tarMan:PROGRADE-0.001.
	clearscreen.
	print "dV use: " + round(tarMan:PROGRADE,2).
}
until (tarMan:ORBIT:ECCENTRICITY <= 0.001) OR (tarMan:ORBIT:SEMIMAJORAXIS < (tarOrb + BODY:RADIUS)) {
	set tarMan:PROGRADE to tarMan:PROGRADE-0.0001.
	clearscreen.
print "dV use: " + round(tarMan:PROGRADE,2).
}


//Lock to manuever node and recreate 't' variable for new manuever
wait 1.
lock STEERING to tarMan:DELTAV.
wait 20.
set t to MANTIME(tarMan:DELTAV:MAG).
print "Burn time: " + round (t,1) + " seconds".
wait 5.

//Warp to 30 seconds from manuever
warpto(TIME:SECONDS + (tarMan:ETA - 30 - t)).


//Variable 't' used for burn start timing in this manuever
wait until tarMan:ETA <= (t/2).

//Burn using manuever time
unlock STEERING.
SAS ON.
lock THROTTLE to MIN(MANTIME(tarMan:DELTAV:MAG), 1).
wait t.
lock THROTTLE to 0.

// Fine-tune based on manuever time but using eccentricity to fine-tune
set curOrb to ORBIT:PERIAPSIS.
until (ORBIT:ECCENTRICITY <= 0.002) OR (ORBIT:SEMIMAJORAXIS < (tarOrb + BODY:RADIUS)) {
	lock THROTTLE to 0.1.
}
lock THROTTLE to 0.

SAS OFF.

remove NEXTNODE.

//<<TEST ONLY>> Call next script. Currently only for testing.
//run dli51k.ks.

