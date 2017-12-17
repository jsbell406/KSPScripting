

if apoapsis > periapsis {set maneu to node(time:seconds + eta:apoapsis, 0, 0, 10).}
else if periapsis > apoapsis { set maneu to node(time:seconds + eta:periapsis, 0, 0, -10).}


add maneu.
if apoapsis > 0 {
	until (maneu:orbit:apoapsis - maneu:orbit:periapsis) < 2000 {
		set maneu:prograde to maneu:prograde + 1.
		remove maneu.
		add maneu.
	}
}
else{ 
	until (maneu:orbit:apoapsis - maneu:orbit:periapsis) > 2000{
		set maneu:prograde to maneu:prograde -1.
		remove maneu.
		add maneu.
	}
}




