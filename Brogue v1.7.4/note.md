
 - Viewport.mm
 	- for each cell
 		- letter  in _letterArray
 		- bgColor in _bgColorArray
 		- letter color in _letterColorArray
 		- attribute (dict) in _attributes
 			- fastFont , NSFontAttributeName 
 			- [NSColor blackColor] , NSForegroundColorAttributeName
 		- rect in _rectArray

 - RogueDriver.m
 	- playBrogue  
 		- -> rogueMain() , RogueMain.c 
 			- -> mainBrogueJunction() , RogueMain.c 


 - RogueMain.c
 	- mainBrogueJunction()
 		- basic program loop
 		- Do what player wants to do next
 			- by storing it in rogue.nextGame -- possibilities listed in enum NGCommands
 			- The path (rogue.nextGamePath) is essentially a parameter for this command, and tells ***NG_VIEW_RECORDING*** and ***NG_OPEN_GAME*** which file to open.
 			- If there is no command (i.e. if rogue.nextGame contains NG_NOTHING), then we'll display the title screen so the player can choose.
 		- function details:
 			- clear screen , and displayBuffer
