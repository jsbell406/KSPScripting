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

function getMunInsertAngle {
	set r2 to body:radius/1000.
	set r4 to ship:altitude/1000.
	set r6 to 12000.
	
	set angle to 180-((sqrt(((((r4+r2)+(r6+r2))/2)/(r6+r2))^3))*180).
	print angle.
}