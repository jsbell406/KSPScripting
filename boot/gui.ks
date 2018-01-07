//parameter orbitAltitude.
// Create a GUI window
switch to 0.
LOCAL gui IS GUI(200).
run cheat.ks.
//run once lib.ks(15000).
//lib(15000).
//set orbitAltitude to 100000.
// Add widgets to the GUI
LOCAL label IS gui:ADDLABEL("run test script").
SET label:STYLE:ALIGN TO "CENTER".
SET label:STYLE:HSTRETCH TO True. // Fill horizontally
LOCAL ok TO gui:ADDBUTTON("OK").
LOCAL val IS gui:ADDTEXTFIELD("150000").
LOCAL val2 IS gui:ADDTEXTFIELD("15000").
//LOCAL t TO gui:ADDBUTTON("throt").

// Show the GUI.
gui:SHOW().

LOCAL isDone IS FALSE.
UNTIL isDone
{
  if (ok:TAKEPRESS){
      gui:HIDE().
      run cheatlaunch.ks(val:TEXT:toscalar).
      run cheat2.ks(val2:TEXT:toscalar).
      run ml.ks.
//      run josh.ks(val:TEXT:toscalar).
      SET isDone TO TRUE.
  }
    
  WAIT 0.1. // No need to waste CPU time checking too often.
}
//set t:ONCLICK to tClickCheck().
//print "OK pressed.  Now closing demo.".
// Hide when done (will also hide if power lost).
//gui:HIDE().
