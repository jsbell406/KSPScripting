// Activating robot...
wait 0.1.
clearscreen.


PARAMETER tarOrb.

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

wait until ORBIT:PERIAPSIS <= tarOrb.
wait 20.

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
until (tarMan:ORBIT:ECCENTRICITY <= 0.001) {
	set tarMan:PROGRADE to tarMan:PROGRADE-0.0001.
	clearscreen.
print "dV use: " + round(tarMan:PROGRADE,2).
}

