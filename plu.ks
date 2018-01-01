list parts in allparts.
print allparts.
print "-".
print allparts[3]:modules.
print "-".
print allparts[3]:getmodulebyindex(3):allfields.
print "-".
print allparts[3]:getmodulebyindex(3):getfield("comms").
print "-".
print " ".

// set allAntennas to list().
// list parts in allparts.

// for part in allparts 
// {
//     set partModules to part:modules.
//     set isRTAntenna to partModules:contains("ModuleRTAntenna").

//     if isRTAntenna = true
//     {
//         allAntennas:add(part).
//     }
// }
// print allAntennas.
// print "-".
// for indivAntenna in allAntennas
// 	{
// 		set antStatus to indivAntenna:getmodule("ModuleRTAntenna").
// 		print antStatus:getfield("status").
// 	}