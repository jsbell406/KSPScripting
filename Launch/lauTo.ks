CLEARSCREEN. 
parameter orbitalHeight.
RUN ONCE UserFunctions.ks(orbitalHeight).
RUN ONCE PositionFunctions.ks(orbitalHeight).
RUN ONCE EngineFunctions.ks.
when altitude > 0 then{
	set gravAcc to (constant:G * ship:body:mass) / (ship:body:radius ^ 2).
	set gravAcc1 to (constant:G * ship:body:mass) / ((ship:body:radius + altitude) ^ 2).
	set TWR to ((ship:availablethrust * gravAcc) / (mass * gravAcc ^ 2)) * throttle.
	set actTWR to ((ship:availablethrust * gravAcc1) / (mass * gravAcc1 ^ 2)) * throttle.
	set maxTWR to (ship:availablethrust * gravAcc1) / (mass * gravAcc1 ^ 2).
	preserve.
	}
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
set mythrot to 1.
lock throttle to mythrot.
lock steering to heading(90,90).
wait 2.
stage.
wait 2.
when altitude > 1 then{
thrustCalculations().
technicalReadout().
preserve.
}
until actTWR < 1.25 {
if actTWR >= 1.24{set mythrot to mythrot - .01. lock throttle to mythrot.}
}
set pmt to maxthrust.

when maxthrust > pmt then {
	set pmt to maxthrust.
	preserve.
}
when maxthrust < pmt then{
	stage.
	set pmt to maxthrust.
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
