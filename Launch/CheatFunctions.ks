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

function setLunarManu {
	set targetMan to node(time:seconds + 100, 0, 0, -5).
	add targetMan.
	
	until targetMan:orbit:apoapsis > 12000000 {
		set targetMan:prograde to targetMan:prograde + 1.
	}
	until targetMan:orbit:hasnextpatch {
		set targetMan:eta to targetMan:eta + 1.
	}
	until targetMan:orbit:nextpatch:periapsis < 20000 {
		set targetMan:eta to targetMan:eta + 0.1.
	}
}