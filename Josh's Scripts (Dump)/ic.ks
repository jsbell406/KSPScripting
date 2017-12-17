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

//Robot activating...
wait 0.1.
set c to false.
clearscreen.

set tarInc to 85.

if orbit:inclination > tarInc {
	set tarMan to node(time:seconds+ETA:APOAPSIS, 0, -5, 0).
	add tarMan.
	until tarMan:orbit:inclination < (tarInc + 5) {
		set tarMan:normal to tarMan:normal-0.75.
		set tarMan:prograde to tarMan:prograde-0.25.
	}
	until tarMan:orbit:inclination < (tarInc + 0.5){
		set tarMan:normal to tarMan:normal-0.25.
		set tarMan:prograde to tarMan:prograde-0.025.
	}
	until tarMan:orbit:inclination < tarInc {
		set tarMan:normal to tarMan:normal-0.001.
		set tarMan:prograde to tarMan:prograde-0.001.
	}
	set c to true.
}

if (orbit:inclination < tarInc) AND (c = false) {
	set tarMan to node(time:seconds+ETA:APOAPSIS, 0, -5, 0).
	add tarMan.
	until tarMan:orbit:inclination > (tarInc - 5) {
		set tarMan:normal to tarMan:normal+0.75.
		set tarMan:prograde to tarMan:prograde-0.25.
		clearscreen.
		print tarMan:orbit:inclination.
	}
	until tarMan:orbit:inclination > (tarInc - 0.5){
		set tarMan:normal to tarMan:normal+0.25.
		set tarMan:prograde to tarMan:prograde-0.025.
		clearscreen.
		print tarMan:orbit:inclination.
	}
	until tarMan:orbit:inclination >= tarInc {
		set tarMan:normal to tarMan:normal+0.001.
		set tarMan:prograde to tarMan:prograde-0.001.
		clearscreen.
		print tarMan:orbit:inclination.
	}
}