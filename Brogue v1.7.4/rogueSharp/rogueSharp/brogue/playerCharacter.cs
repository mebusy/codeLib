using System;

namespace rogueSharp
{
	public class playerCharacter
	{
		public playerCharacter () { }


		const int MAX_WAYPOINT_COUNT = RogueH.MAX_WAYPOINT_COUNT ;
		const int DCOLS = RogueH.DCOLS ;
		const int DROWS = RogueH.DROWS ;
		const int FEAT_COUNT = (int)featTypes.FEAT_COUNT ;

		public short depthLevel;					// which dungeon level are we on
		public short deepestLevel;

		public bool disturbed;					// player should stop auto-acting
		public bool autoPlayingLevel;			// seriously, don't interrupt
		public bool automationActive;			// cut some corners during redraws to speed things up

		public bool justRested;					// previous turn was a rest -- used in stealth

		public bool updatedSafetyMapThisTurn;	// so it's updated no more than once per turn
		public bool updatedAllySafetyMapThisTurn;	// so it's updated no more than once per turn
		public bool updatedMapToSafeTerrainThisTurn;// so it's updated no more than once per turn
		public bool updatedMapToShoreThisTurn;		// so it's updated no more than once per turn
		public bool easyMode;					// enables easy mode
		public bool inWater;					// helps with the blue water filter effect

		public bool creaturesWillFlashThisTurn;	// there are creatures out there that need to flash before the turn ends


		// -----

		public ulong seed;					// the master seed for generating the entire dungeon
		public short RNG;	

		public ulong gold;					// how much gold we have
		public ulong goldGenerated;		// how much gold has been generated on the levels, not counting gold held by monsters
		public short strength;
		public ushort monsterSpawnFuse;	// how much longer till a random monster spawns

		public item weapon;
		public item armor;
		public item ringLeft;
		public item ringRight;

		public flare[] flares;
		public short flareCount;
		public short flareCapacity;

		public creature yendorWarden;
		private lightSource __minersLight__ = new lightSource() ;
		public lightSource minersLight {     
			get    {      return __minersLight__;    }  
			set    {
				if(value!=null) ObjectCopier.CopyFrom<lightSource>(  __minersLight__ , value  )  ;  
			}
		}   
		public float minersLightRadius; 

		public short ticksTillUpdateEnvironment;	// so that some periodic things happen in objective time

		// metered items
		public long foodSpawned;					// amount of nutrition units spawned so far this game
		public short lifePotionFrequency;
		public short lifePotionsSpawned;
		public short strengthPotionFrequency;
		public short enchantScrollFrequency;

		// waypoints:
		public readonly short[][][] wpDistance = new short[MAX_WAYPOINT_COUNT][][];
		public short wpCount;
		public readonly short [,]wpCoordinates = new short[MAX_WAYPOINT_COUNT,2];
		public short wpRefreshTicker;

		public short rewardRoomsGenerated;			// to meter the number of reward machines

		// ring bonuses:
		public short clairvoyance;
		public short stealthBonus;
		public short regenerationBonus;
		public short lightMultiplier;
		public short awarenessBonus;
		public short transference;
		public short wisdomBonus;
		public short reaping;

		public readonly bool[] featRecord = new bool[FEAT_COUNT];

		// maps
		public short [][]mapToShore;					// how many steps to get back to shore
		public short [][]mapToSafeTerrain;			// so monsters can get to safety

		public short previousHealthPercent;        // remembers what your health proportion was at the start of the turn,
		public short previousPoisonPercent;        // and your poison proportion, to display percentage alerts for each

		public ushort scentTurnNumber;		// helps make scent-casting work
		public ulong playerTurnNumber;     // number of input turns in recording. Does not increment during paralysis.
		public ulong absoluteTurnNumber;   // number of turns since the beginning of time. Always increments.

		public readonly short[] cursorLoc = new short[2];					// used for the return key functionality
		public creature lastTarget;				// to keep track of the last monster the player has thrown at or zapped

		public short machineNumber;				// so each machine on a level gets a unique number

		public short xpxpThisTurn;					// how many squares the player explored this turn

		public ulong nextGameSeed;

		public readonly short[]  upLoc = new short[2];						// upstairs location this level
		public readonly short[] downLoc = new short[2];					// downstairs location this level


	}
}

