
if maxthrust = 0 { stage.}

lock steering to srfretrograde.
wait 20.

until airspeed < 50 {
	lock throttle to 1.
}

lock throttle to 0.

wait until alt:radar < 2500.
set mythrot to 0.

until airspeed <= 20{
	if actTWR >= 10 {set mythrot to mythrot - .01. lock throttle to mythrot.}
	else if actTWR <= 9.8 { if throttle = 1 {} else set mythrot to mythrot + .01. lock throttle to mythrot.}
}
set mythrot to 0.
until airspeed <= 5 {
	if actTWR >= 1.5 {set mythrot to mythrot - .001. lock throttle to mythrot.}
	else if actTWR <= 1.49 { if throttle = 1 {} else set mythrot to mythrot + .001. lock throttle to mythrot.}
}

until status = "LANDED"{
	when verticalspeed > -2 then {
		lock steering to heading(90,90).
		set mythrot to 0.
		lock throttle to mythrot.
		wait 10.
	}
	when verticalspeed < -2 then {
		when airspeed <= 3 then{
			if actTWR >= .99{
                set mythrot to mythrot - .001. 
                lock throttle to mythrot.
                }
			else if actTWR <= .97 { 
                if throttle = 1 {} 
                else {
                    set mythrot to mythrot + .001. 
                    lock throttle to mythrot.
                
                }
            }
		}
		when airspeed >= 4 then{
			if actTWR >= 1.1{
                set mythrot to mythrot - .001. 
                lock throttle to mythrot.
                }
			else if actTWR <= 1.08 {
                 if throttle = 1 {}
                  else {
                      set mythrot to mythrot + .001. 
                  lock throttle to mythrot.
                  }
                  }
		}
	}
}
unlock steering.
lock throttle to 0.

SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.

wait 10.