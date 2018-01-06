
if maxthrust = 0 { stage.}

lock steering to srfretrograde.
wait 20.

until airspeed < 50 {
	lock throttle to 1.
}

lock throttle to 0.



wait until alt:radar < 2500.

until airspeed < 10 
{
	thrustCalculations().
	set activeThrottle to adjustThrottle(5,activeThrottle).
	lock throttle to activeThrottle.
}

until alt:radar < 10 
{
	if airspeed > 3 
	{
		thrustCalculations().
		set activeThrottle to adjustThrottle(1.05,activeThrottle).
		
	}
	if airspeed < 3
	{
		thrustCalculations().
		set activeThrottle to adjustThrottle(.95,activeThrottle).
	}
}
lock throttle to 0.
unlock steering.



