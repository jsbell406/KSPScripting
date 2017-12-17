//Here there be functions
FUNCTION MANTIME {
	parameter dv.
	
	list ENGINES in eng.
	
	local engT is eng[0]:MAXTHRUST * 1000.
	local vesMass is SHIP:MASS * 1000.
	local e is CONSTANT():E.
	local g is 9.80665.
	local engISP is eng[0]:ISP * g.
	local fuelF is engT / engISP.
	
	return (vesMass / fuelF) * (1 - e^(-dv/engISP)).
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
wait 20.
set t to MANTIME(tarMan:DELTAV:MAG).
print "Burn time: " + round (t,1) + " seconds".
wait 5.

warpto(TIME:SECONDS + (tarMan:ETA - 30)).
set startMan to tarMan:DELTAV.

wait until tarMan:ETA <= (t/2).
lock THROTTLE to MIN(MANTIME(tarMan:DELTAV:MAG), 1).
wait t.
lock THROTTLE to 0.
wait 1.

set STEERING to PROGRADE.


