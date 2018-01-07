
if maxthrust = 0 { stage.}

lock steering to srfretrograde.
wait 20.

until airspeed < 50 {
	lock throttle to 1.
}

lock throttle to 0.

set activeThrottle to 0.

wait until alt:radar < 3000.

until airspeed < 10 
{
	thrustCalculations().
	set activeThrottle to adjustThrottle(7.5,activeThrottle).
	lock throttle to activeThrottle.
}

until (SHIP:STATUS = "Landed")
{
	when airspeed < 5 then lock steering to heading(90,90).
	if airspeed > 4 
	{
		thrustCalculations().
		set activeThrottle to adjustThrottle(1.1,activeThrottle).
		
	}
	if airspeed < 4
	{
		thrustCalculations().
		set activeThrottle to adjustThrottle(.9,activeThrottle).
	}
}
lock throttle to 0.
unlock steering.



