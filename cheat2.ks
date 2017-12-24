parameter orbitAltitude.
// --- IMPORTS ---
	// RUN ONCE PositionFunctions.ks(orbitAltitude).
	// RUN ONCE LaunchFunctions.ks(orbitAltitude).
	// RUN ONCE ShipFunctions.ks(orbitAltitude).
	// RUN ONCE MathFunctions.ks(orbitAltitude).
	// RUN ONCE EngineFunctions.ks(orbitAltitude).
	// RUN ONCE JoshFunctions.ks(orbitAltitude).
	// RUN ONCE JamesFunctions.ks(orbitAltitude).
	RUN ONCE lib.ks(orbitAltitude).
	
	lib(orbitAltitude).
createStartingPosition().
deployOrbitalAnchor(orbitAltitude).
thrustCalculations().
getLaunchClamps().
createFirstStage().
setLunarManu().