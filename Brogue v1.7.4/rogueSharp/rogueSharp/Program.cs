using System;

namespace rogueSharp
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			Global.preInitData ();

			playerCharacter rogue = RogueMain.GetInstance().getRogue(); 
			rogue.nextGameSeed = 0; // Seed based on clock.

			RogueMain.GetInstance().initializeRogue ( rogue.nextGameSeed );
			RogueMain.GetInstance().startLevel ( rogue.depthLevel, 1 );
		}
	}


}
