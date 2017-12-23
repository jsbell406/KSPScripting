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