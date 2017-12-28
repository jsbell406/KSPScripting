parameter orbitAltitude.
// Create a GUI window
LOCAL gui IS GUI(200).
// Add widgets to the GUI
LOCAL label IS gui:ADDLABEL("launch to test orbit").
SET label:STYLE:ALIGN TO "CENTER".
SET label:STYLE:HSTRETCH TO True. // Fill horizontally
LOCAL ok TO gui:ADDBUTTON("OK").

// Show the GUI.
gui:SHOW().
// Handle GUI widget interactions.
//
// This is the technique known as "callbacks" - instead
// of actively looking again and again to see if a button was
// pressed, the script just tells kOS that it should call a
// delegate function when it notices the button has done
// something, and then the program passively waits for that
// to happen:
global isDone IS FALSE.
function myClickChecker {
run Cheat.ks(orbitAltitude).
set isDone to true.
}
SET ok:ONCLICK TO myClickChecker@. // This could also be an anonymous function instead.
wait until isDone.

print "OK pressed.  Now closing demo.".
// Hide when done (will also hide if power lost).
gui:HIDE().
