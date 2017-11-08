//Here there be functions
FUNCTION MANTIME {
	parameter dv.
	
	list ENGINES in eng.
	
	local engT is eng[0]:MAXTHRUST * 1000.
	local vesMass is SHIP:MASS * 1000.
	local e is CONSTANT():E.
	local engISP is eng[0]:ISP.
	local g is (constant:G * ship:body:mass) / ((ship:body:radius + altitude) ^ 2).
	
	return g * vesMass * engISP * (1 -  e^(-dv/(g*engISP))) / engT.
}



//Robot activating...
wait 0.1.
clearscreen.

set tarOrb to 51000.
set tarMan to node(time:seconds+ETA:APOAPSIS, 0, 0, -5).
add tarMan.
print "Selected insertion orbit is " + tarOrb + "m.".
until tarMan:ORBIT:PERIAPSIS < (tarORB + 2000) {
	set tarMan:PROGRADE to tarMan:PROGRADE-1.
	clearscreen.
	print "dV use: " + round(tarMan:PROGRADE,2).
}
until tarMan:ORBIT:PERIAPSIS < (tarOrb + 10) {
	set tarMan:PROGRADE to tarMan:PROGRADE-0.001.
	clearscreen.
	print "dV use: " + round(tarMan:PROGRADE,2).
}
until tarMan:ORBIT:PERIAPSIS <= tarOrb {
	set tarMan:PROGRADE to tarMan:PROGRADE-0.0001.
	clearscreen.
	print "dV use: " + round(tarMan:PROGRADE,2).
}

wait 1.
lock STEERING to tarMan:DELTAV.
wait 15.
set t to MANTIME(tarMan:DELTAV:MAG).
print t.



