using System;

namespace rogueSharp
{
	public class Monsters:Singleton<Monsters>
	{
		
		private Monsters () { }

		const ulong MONST_INVISIBLE = (ulong)monsterBehaviorFlags.MONST_INVISIBLE ; 
		const ulong MONST_INANIMATE = (ulong)monsterBehaviorFlags.MONST_INANIMATE ; 
		const ulong MONST_IMMOBILE = (ulong)monsterBehaviorFlags.MONST_IMMOBILE ; 
		const ulong MONST_CARRY_ITEM_100 = (ulong)monsterBehaviorFlags.MONST_CARRY_ITEM_100 ; 
		const ulong MONST_CARRY_ITEM_25 = (ulong)monsterBehaviorFlags.MONST_CARRY_ITEM_25 ; 
		const ulong MONST_ALWAYS_HUNTING = (ulong)monsterBehaviorFlags.MONST_ALWAYS_HUNTING ; 
		const ulong MONST_FLEES_NEAR_DEATH = (ulong)monsterBehaviorFlags.MONST_FLEES_NEAR_DEATH ; 
		const ulong MONST_ATTACKABLE_THRU_WALLS = (ulong)monsterBehaviorFlags.MONST_ATTACKABLE_THRU_WALLS ; 
		const ulong MONST_DEFEND_DEGRADE_WEAPON = (ulong)monsterBehaviorFlags.MONST_DEFEND_DEGRADE_WEAPON ; 
		const ulong MONST_IMMUNE_TO_WEAPONS = (ulong)monsterBehaviorFlags.MONST_IMMUNE_TO_WEAPONS ; 
		const ulong MONST_FLIES = (ulong)monsterBehaviorFlags.MONST_FLIES ; 
		const ulong MONST_FLITS = (ulong)monsterBehaviorFlags.MONST_FLITS ; 
		const ulong MONST_IMMUNE_TO_FIRE = (ulong)monsterBehaviorFlags.MONST_IMMUNE_TO_FIRE ; 
		const ulong MONST_CAST_SPELLS_SLOWLY = (ulong)monsterBehaviorFlags.MONST_CAST_SPELLS_SLOWLY ; 
		const ulong MONST_IMMUNE_TO_WEBS = (ulong)monsterBehaviorFlags.MONST_IMMUNE_TO_WEBS ; 
		const ulong MONST_REFLECT_4 = (ulong)monsterBehaviorFlags.MONST_REFLECT_4 ; 
		const ulong MONST_NEVER_SLEEPS = (ulong)monsterBehaviorFlags.MONST_NEVER_SLEEPS ; 
		const ulong MONST_FIERY = (ulong)monsterBehaviorFlags.MONST_FIERY ; 
		const ulong MONST_INVULNERABLE = (ulong)monsterBehaviorFlags.MONST_INVULNERABLE ; 
		const ulong MONST_IMMUNE_TO_WATER = (ulong)monsterBehaviorFlags.MONST_IMMUNE_TO_WATER ; 
		const ulong MONST_RESTRICTED_TO_LIQUID = (ulong)monsterBehaviorFlags.MONST_RESTRICTED_TO_LIQUID ; 
		const ulong MONST_SUBMERGES = (ulong)monsterBehaviorFlags.MONST_SUBMERGES ; 
		const ulong MONST_MAINTAINS_DISTANCE = (ulong)monsterBehaviorFlags.MONST_MAINTAINS_DISTANCE ; 
		const ulong MONST_WILL_NOT_USE_STAIRS = (ulong)monsterBehaviorFlags.MONST_WILL_NOT_USE_STAIRS ; 
		const ulong MONST_DIES_IF_NEGATED = (ulong)monsterBehaviorFlags.MONST_DIES_IF_NEGATED ; 
		const ulong MONST_MALE = (ulong)monsterBehaviorFlags.MONST_MALE ; 
		const ulong MONST_FEMALE = (ulong)monsterBehaviorFlags.MONST_FEMALE ; 
		const ulong MONST_NOT_LISTED_IN_SIDEBAR = (ulong)monsterBehaviorFlags.MONST_NOT_LISTED_IN_SIDEBAR ; 
		const ulong MONST_GETS_TURN_ON_ACTIVATION = (ulong)monsterBehaviorFlags.MONST_GETS_TURN_ON_ACTIVATION ; 
		const ulong MONST_ALWAYS_USE_ABILITY = (ulong)monsterBehaviorFlags.MONST_ALWAYS_USE_ABILITY ; 
		const ulong MONST_NO_POLYMORPH = (ulong)monsterBehaviorFlags.MONST_NO_POLYMORPH ; 

		const int NUMBER_OF_STATUS_EFFECTS = RogueH.NUMBER_OF_STATUS_EFFECTS; 

		// -----------------------------------------------


		public static int distanceBetween(short x1, short y1, short x2, short y2) {
			return Math.Max(Math.Abs(x1 - x2), Math.Abs(y1 - y2));
		}

		public void initializeGender(creature monst) {
			if ((monst.info.flags & MONST_MALE)!=0 && (monst.info.flags & MONST_FEMALE)!=0 ) {
				monst.info.flags &= ~(rand_percent(50) ? MONST_MALE : MONST_FEMALE);
			}
		}
		public void clearStatus(creature monst) {
			short i;

			for (i=0; i<NUMBER_OF_STATUS_EFFECTS; i++) {
				monst.status[i] = monst.maxStatus[i] = 0;
			}
		}

		//-----------------
		bool rand_percent(short percent) {
			return Random.rand_percent ( percent );

		}
	}
}

