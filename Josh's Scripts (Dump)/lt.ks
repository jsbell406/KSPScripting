//This program will achieve a rough orbit of around 100k
//
//this program has been tested on a craft with the following specs
//payload mass: 732kg
//first stage: 2x FL-T800 fuel tanks, 1x LV-T45 "swivel" liquid fuel engine
//second stage: 1x FL-T400 fuel tank, 1x LV-909 "terrier" liquid fuel engine
//
//the craft must use second stage to finish preliminary burn
//the craft must have at least 5000 delta-V
//the craft must have at least 1.42 TWR 
//run setup.ks first then run this script


when altitude > 1 then{
run calc.ks.
run out.ks.
preserve.
}

run launch.ks.

when maxthrust = 0 then{
	stage.
	preserve.
}

wait until altitude > 71000.

run cirOrb.ks.

run circBurn.ks.

print "ending program in 10 seconds".
set count to 10.
until count = 0 {
	wait 1.
	print count.
	set count to count - 1.
}