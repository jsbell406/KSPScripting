//parameter orbitAltitude.
// Create a GUI window
switch to 0.
LOCAL gui IS GUI(200).
//set orbitAltitude to 100000.
// Add widgets to the GUI
LOCAL label IS gui:ADDLABEL("launch to desired orbit").
SET label:STYLE:ALIGN TO "CENTER".
SET label:STYLE:HSTRETCH TO True. // Fill horizontally
LOCAL ok TO gui:ADDBUTTON("OK").
LOCAL val IS gui:ADDTEXTFIELD("orbit height").
//LOCAL t TO gui:ADDBUTTON("throt").

// Show the GUI.
gui:SHOW().

LOCAL isDone IS FALSE.
UNTIL isDone
{
  if (ok:TAKEPRESS){
      gui:HIDE().
      run cheat.ks(val:TEXT:toscalar).
      SET isDone TO TRUE.
  }
    
  WAIT 0.1. // No need to waste CPU time checking too often.
}
//set t:ONCLICK to tClickCheck().
//print "OK pressed.  Now closing demo.".
// Hide when done (will also hide if power lost).
//gui:HIDE().
