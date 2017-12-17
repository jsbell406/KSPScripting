set tarOrb to 51000.
set tarMan to node(time:seconds+ETA:PERIAPSIS, 0, 0, -5).
add tarMan.
print "Selected insertion orbit is " + tarOrb + "m.".
until tarMan:ORBIT:SEMIMINORAXIS < (tarOrb + SHIP:BODY:RADIUS + 4000) {
	set tarMan:PROGRADE to tarMan:PROGRADE-1.
	clearscreen.
	print "dV use: " + round(tarMan:PROGRADE,2).
}
until tarMan:ORBIT:SEMIMINORAXIS < (tarOrb + SHIP:BODY:RADIUS + 100) {
	set tarMan:PROGRADE to tarMan:PROGRADE-0.001.
	clearscreen.
	print "dV use: " + round(tarMan:PROGRADE,2).
}
until tarMan:ORBIT:SEMIMINORAXIS <= (tarOrb + SHIP:BODY:RADIUS) {
	set tarMan:PROGRADE to tarMan:PROGRADE-0.0001.
	clearscreen.
	print "dV use: " + round(tarMan:PROGRADE,2).
}