parameter orbitAltitude.
function aspStageReady {
	set pmt to maxthrust.

	when maxthrust > pmt then {
		set pmt to maxthrust.
	}
	when maxthrust < pmt then{
		stage.
		set pmt to maxthrust.
	}
}
function planCircularizationManeuver
	{
		parameter orbitAltitude.
		
		if orbit:periapsis < orbitAltitude {
			set upOrDown to "up".
			set targetMan to node(time:seconds+eta:apoapsis, 0, 0, 0).
		}
		else if orbit:hasnextpatch {
			set upOrDown to "down".
			set targetMan to node(time:seconds+eta:periapsis, 0, 0, 0).
		}
		
		add targetMan.
		
		clearscreen.
		wait 0.5.
		print "Selected orbit is " + orbitAltitude + "m.".
		if upOrDown = "up" {
			until targetMan:ORBIT:PERIAPSIS > (orbitAltitude - (orbitAltitude / 100)) 
			{
				set targetMan:PROGRADE to targetMan:PROGRADE + 1.
				clearscreen.
				print "dV use: " + round(targetMan:PROGRADE, 2).
			}
			until targetMan:ORBIT:PERIAPSIS > (orbitAltitude - (orbitAltitude / 200)) 
			{
				set targetMan:PROGRADE to targetMan:PROGRADE + 0.01.
				clearscreen.
				print "dV use: " + round(targetMan:PROGRADE,2).
			}
		
			until targetMan:ORBIT:ECCENTRICITY <= 0.001
			{
				set targetMan:PROGRADE to targetMan:PROGRADE + 0.001.
				clearscreen.
				print "dV use: " + round(targetMan:PROGRADE,2).
			}
		}
		
		// until targetMan:ORBIT:PERIAPSIS >= orbitAltitude 
		// {
			// set targetMan:PROGRADE to targetMan:PROGRADE + 0.0001.
			// clearscreen.
			// print "dV use: " + round(targetMan:PROGRADE,2).
		// }
	}

function setLunarManu {
	parameter orbitAltitude.
	set targetMan to node(time:seconds + 100, 0, 0, -5).
	add targetMan.
	
	until targetMan:orbit:apoapsis > 12000000 {
		set targetMan:prograde to targetMan:prograde + 1.
	}
	until targetMan:orbit:hasnextpatch {
		set targetMan:eta to targetMan:eta + 1.
	}
	until targetMan:orbit:nextpatch:periapsis < orbitAltitude  {
		set targetMan:eta to targetMan:eta + 0.1.
	}
}

function timWarp {
	parameter lot.
	kuniverse:timewarp:warpto(time:seconds + lot).
}
function cheatExecManeuver
	{
		//parameter orbitAltitude.
		
		set targetMan to nextnode.
		wait 1.
		set targetSteer to targetMan:deltav.
		lock steering to targetSteer.
		
		set burnTime to getManueverTime(targetMan:deltav:mag, 1).
		////Testing short maneuver timer
		// if burnTime < 1
		// {
			// set adjBurnTime to burnTime.
			// set adjBurnTime to getManueverTime(targetMan:deltav:mag, burnTime).
		// }
		// else{
			// set adjBurnTime to burnTime.
		// }
		// print "Burn time: " + round (adjBurnTime,2) + " seconds".
		//wait until targetMan:ETA <= (adjBurnTime/2).
		wait until targetMan:ETA <= (BurnTime/2).
		
		set done to false.
		
		set manThrottle to 0.
		lock throttle to manThrottle.
		
		set done to false.
		set deltav0 to targetMan:deltav.
		
		until done
		{
			set maxAcc to shipMaxAccel().
			set manThrottle to min(targetMan:deltav:mag/maxAcc, 1).
			aspStageReady().
			
			if vdot(deltav0, targetMan:deltav) < 0
			{
				lock throttle to 0.
				break.
			}
			
			if targetMan:deltav:mag < 0.1
			{
				wait until vdot(deltav0, targetMan:deltav) < 0.5.
				
				lock throttle to 0.
				set done to true.
			}
		}
		
		lock steering to prograde.
		unlock throttle.
		
		remove nextnode.
	}
function setCircOrbNode {
	parameter orbitAltitude.
	set targetMan to node(time:seconds + eta:periapsis, 0, 0, -5).
	add targetMan.

	until targetMan:ORBIT:PERIAPSIS < orbitAltitude 
		{
			set targetMan:PROGRADE to targetMan:PROGRADE - 1.
			clearscreen.
			print "dV use: " + round(targetMan:PROGRADE, 2).
		}
		
}
function setCorrectionNode {
	parameter orbitAltitude.
	set man to node(time:seconds + 30,0,0,0).
	add man.
	if man:orbit:periapsis < orbitAltitude 
	{
		until man:orbit:periapsis > orbitAltitude 
		{
			set man:radialout to man:radialout + 1.
		}
	}
	else if man:orbit:periapsis > orbitAltitude 
	{
		until man:orbit:periapsis < orbitAltitude 
		{
			set man:radialout to man:radialout - 1.
		}
	}
}