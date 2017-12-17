FUNCTION MANTIME {
	parameter dv.
	
	list ENGINES in eng.
	
	local engT is eng[0]:MAXTHRUST * 1000.
	local vesMass is SHIP:MASS * 1000.
	local e is CONSTANT():E.
	local engISP is eng[0]:ISP.
	local g is 9.80665.

	return g * vesMass * engISP * (1 -  e^(-dv/(g*engISP))) / engT.
}
