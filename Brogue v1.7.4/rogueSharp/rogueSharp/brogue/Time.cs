using System;

namespace rogueSharp
{
	public class Time : Singleton<Time> 
	{

		// Call this periodically (when haste/slow wears off and when moving between depths)
		// to keep environmental updates in sync with player turns.
		public void synchronizePlayerTimeState() {
			playerCharacter rogue = RogueMain.GetInstance().getRogue(); 
			creature player = RogueMain.GetInstance ().getPlayer ();

			rogue.ticksTillUpdateEnvironment = player.ticksUntilTurn;
		}
	}
}

