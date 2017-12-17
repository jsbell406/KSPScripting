set mythrot to 1.
lock throttle to mythrot.
lock steering to heading(90,90).
wait 2.
stage.
wait 2.

until actTWR < 1.25 {
if actTWR >= 1.24{set mythrot to mythrot - .01. lock throttle to mythrot.}
}

when maxthrust = 0 then{
	stage.
	preserve.
}

when altitude > 1500 then{
	when airspeed > 100 then lock steering to heading(90,85).

	when altitude > 3000 then{
		when airspeed > 150 then{
		lock steering to srfprograde.


		}
	}
}

//until we reach our desired apoapsis keep TWR within .05 of 1.5
wait until actTWR > 1.6.
until apoapsis >= 100000{
	if actTWR >= 1.55{set mythrot to mythrot - .01. lock throttle to mythrot.}
	else if actTWR <= 1.45 { if throttle = 1 {} else set mythrot to mythrot + .01. lock throttle to mythrot.}
}

lock throttle to 0.