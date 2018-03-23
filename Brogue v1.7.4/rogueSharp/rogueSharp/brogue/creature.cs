using System;

/* comments , print only 
typedef struct creature {
	creatureType info;
	short xLoc;
	short yLoc;
	short depth;
	short currentHP;
	long turnsUntilRegen;
	short regenPerTurn;					// number of HP to regenerate every single turn
	short weaknessAmount;				// number of points of weakness that are inflicted by the weakness status
    short poisonAmount;                 // number of points of damage per turn from poison
	enum creatureStates creatureState;	// current behavioral state
	enum creatureModes creatureMode;	// current behavioral mode (higher-level than state)
    
    short mutationIndex;                // what mutation the monster has (or -1 for none)
    
    // Waypoints:
    short targetWaypointIndex;          // the index number of the waypoint we're pathing toward
    boolean waypointAlreadyVisited[MAX_WAYPOINT_COUNT]; // checklist of waypoints
    short lastSeenPlayerAt[2];          // last location at which the monster hunted the player
	
    short targetCorpseLoc[2];			// location of the corpse that the monster is approaching to gain its abilities
	char targetCorpseName[30];			// name of the deceased monster that we're approaching to gain its abilities
	unsigned long absorptionFlags;		// ability/behavior flags that the monster will gain when absorption is complete
	boolean absorbBehavior;				// above flag is behavior instead of ability (ignored if absorptionBolt is set)
    short absorptionBolt;               // bolt index that the monster will learn to cast when absorption is complete
	short corpseAbsorptionCounter;		// used to measure both the time until the monster stops being interested in the corpse,
										// and, later, the time until the monster finishes absorbing the corpse.
	short **mapToMe;					// if a pack leader, this is a periodically updated pathing map to get to the leader
	short **safetyMap;					// fleeing monsters store their own safety map when out of player FOV to avoid omniscience
	short ticksUntilTurn;				// how long before the creature gets its next move
	
	// Locally cached statistics that may be temporarily modified:
	short movementSpeed;
	short attackSpeed;
	
	short turnsSpentStationary;			// how many (subjective) turns it's been since the creature moved between tiles
	short flashStrength;				// monster will flash soon; this indicates the percent strength of flash
	color flashColor;					// the color that the monster will flash
	short status[NUMBER_OF_STATUS_EFFECTS];
	short maxStatus[NUMBER_OF_STATUS_EFFECTS]; // used to set the max point on the status bars
	unsigned long bookkeepingFlags;
	short spawnDepth;					// keep track of the depth of the machine to which they relate (for activation monsters)
    short machineHome;                  // monsters that spawn in a machine keep track of the machine number here (for activation monsters)
	short xpxp;							// exploration experience (used to time telepathic bonding for allies)
	short newPowerCount;                // how many more times this monster can absorb a fallen monster
    short totalPowerCount;              // how many times has the monster been empowered? Used to recover abilities when negated.
	struct creature *leader;			// only if monster is a follower
	struct creature *carriedMonster;	// when vampires turn into bats, one of the bats restores the vampire when it dies
	struct creature *nextCreature;
	struct item *carriedItem;			// only used for monsters
}
*/

namespace rogueSharp 
{ 
	
	public class creature { 
		const int MAX_WAYPOINT_COUNT = RogueH.MAX_WAYPOINT_COUNT; 
		const int NUMBER_OF_STATUS_EFFECTS = RogueH.NUMBER_OF_STATUS_EFFECTS; 

		private creatureType __info__  = new creatureType ( _foreColor : Global.black , _damage: new randomRange()) ;
		public creatureType info   // the Name property  
		{     
			get    {      return __info__;    }  
			set    {
				if(value!=null) ObjectCopier.CopyFrom<creatureType>(  __info__ , value  )  ;
			}
		}   

		public short xLoc ;
		public short yLoc ;
		public short depth ;
		public short currentHP ;
		public long turnsUntilRegen ;
		public short regenPerTurn ;
		public short weaknessAmount ;
		public short poisonAmount ;
		public creatureStates creatureState ;
		public creatureModes creatureMode ;
		public short mutationIndex ;
		public short targetWaypointIndex ;
		public readonly bool [] waypointAlreadyVisited  = new bool [MAX_WAYPOINT_COUNT];
		public readonly short [] lastSeenPlayerAt  = new short [2];
		public readonly short [] targetCorpseLoc  = new short [2];
		public readonly char [] targetCorpseName  = new char [30];
		public ulong absorptionFlags ;
		public bool absorbBehavior ;
		public short absorptionBolt ;
		public short corpseAbsorptionCounter ;
		public short [][] mapToMe ;
		public short [][] safetyMap ;
		public short ticksUntilTurn ;
		public short movementSpeed ;
		public short attackSpeed ;
		public short turnsSpentStationary ;
		public short flashStrength ;
		private color __flashColor__  = new color () ;
		public color flashColor 
		{
			get    {      return __flashColor__;    }  
			set    {
				if(value!=null) ObjectCopier.CopyFrom<color>(  __flashColor__ , value  )  ;
			}
		}

		public readonly short [] status  = new short [NUMBER_OF_STATUS_EFFECTS];
		public readonly short [] maxStatus  = new short [NUMBER_OF_STATUS_EFFECTS];
		public ulong bookkeepingFlags ;
		public short spawnDepth ;
		public short machineHome ;
		public short xpxp ;
		public short newPowerCount ;
		public short totalPowerCount ;
		public creature leader ;
		public creature carriedMonster ;
		public creature nextCreature ;
		public item carriedItem ;

		public creature() { 

		} // constructure  

	} // class 
} // namespace 


//  creature;

