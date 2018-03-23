using System;

namespace rogueSharp
{
	public class RogueMain : Singleton<RogueMain>
	{
		private RogueMain () {
			
		}


		//---------------- contant ----------------
		const int DEEPEST_LEVEL = RogueH.DEEPEST_LEVEL ;
		const int DCOLS = RogueH.DCOLS; 
		const int DROWS = RogueH.DROWS; 

		const int NUMBER_DUNGEON_FEATURES = RogueH.NUMBER_DUNGEON_FEATURES ;

		const short RNG_SUBSTANTIVE = (short)RNGs.RNG_SUBSTANTIVE ;
		const short RNG_COSMETIC =  (short)RNGs.RNG_COSMETIC ;

		const int MAX_WAYPOINT_COUNT = RogueH.MAX_WAYPOINT_COUNT ;
		const int NUMBER_MONSTER_KINDS = RogueH.NUMBER_MONSTER_KINDS ;
		const int FEAT_COUNT = (int)featTypes.FEAT_COUNT ;
		const int MAX_ITEMS_IN_MONSTER_ITEMS_HOPPER = RogueH.MAX_ITEMS_IN_MONSTER_ITEMS_HOPPER ;

		const int STOMACH_SIZE = RogueH.STOMACH_SIZE ;

		//----- itemCategory
		const ushort FOOD = (ushort)itemCategory.FOOD;
		const ushort WEAPON = (ushort)itemCategory.WEAPON;
		const ushort ARMOR = (ushort)itemCategory.ARMOR;
		const ushort POTION = (ushort)itemCategory.POTION;
		const ushort SCROLL = (ushort)itemCategory.SCROLL;
		const ushort STAFF = (ushort)itemCategory.STAFF;
		const ushort WAND = (ushort)itemCategory.WAND;
		const ushort RING = (ushort)itemCategory.RING;
		const ushort CHARM = (ushort)itemCategory.CHARM;
		const ushort GOLD = (ushort)itemCategory.GOLD;
		const ushort AMULET = (ushort)itemCategory.AMULET;
		const ushort GEM = (ushort)itemCategory.GEM;
		const ushort KEY = (ushort)itemCategory.KEY;
//
//		const ushort CAN_BE_DETECTED = (ushort)itemCategory.CAN_BE_DETECTED;
//		const ushort PRENAMED_CATEGORY = (ushort)itemCategory.PRENAMED_CATEGORY;
//		const ushort NEVER_IDENTIFIABLE = (ushort)itemCategory.NEVER_IDENTIFIABLE;
//		const ushort COUNTS_TOWARD_SCORE = (ushort)itemCategory.COUNTS_TOWARD_SCORE;
//		const ushort CAN_BE_SWAPPED = (ushort)itemCategory.CAN_BE_SWAPPED;
		const ushort ALL_ITEMS = (ushort)itemCategory.ALL_ITEMS;

		const short STATUS_DONNING = (short)statusEffects.STATUS_DONNING;
		const short STATUS_WEAKENED = (short)statusEffects.STATUS_WEAKENED;
		const short STATUS_TELEPATHIC = (short)statusEffects.STATUS_TELEPATHIC;
		const short STATUS_HALLUCINATING = (short)statusEffects.STATUS_HALLUCINATING;
		const short STATUS_LEVITATING = (short)statusEffects.STATUS_LEVITATING;
		const short STATUS_SLOWED = (short)statusEffects.STATUS_SLOWED;
		const short STATUS_HASTED = (short)statusEffects.STATUS_HASTED;
		const short STATUS_CONFUSED = (short)statusEffects.STATUS_CONFUSED;
		const short STATUS_BURNING = (short)statusEffects.STATUS_BURNING;
		const short STATUS_PARALYZED = (short)statusEffects.STATUS_PARALYZED;
		const short STATUS_POISONED = (short)statusEffects.STATUS_POISONED;
		const short STATUS_STUCK = (short)statusEffects.STATUS_STUCK;
		const short STATUS_NAUSEOUS = (short)statusEffects.STATUS_NAUSEOUS;
		const short STATUS_DISCORDANT = (short)statusEffects.STATUS_DISCORDANT;
		const short STATUS_IMMUNE_TO_FIRE = (short)statusEffects.STATUS_IMMUNE_TO_FIRE;
		const short STATUS_EXPLOSION_IMMUNITY = (short)statusEffects.STATUS_EXPLOSION_IMMUNITY;
		const short STATUS_NUTRITION = (short)statusEffects.STATUS_NUTRITION;
		const short STATUS_ENTERS_LEVEL_IN = (short)statusEffects.STATUS_ENTERS_LEVEL_IN;
		const short STATUS_MAGICAL_FEAR = (short)statusEffects.STATUS_MAGICAL_FEAR;
		const short STATUS_ENTRANCED = (short)statusEffects.STATUS_ENTRANCED;
		const short STATUS_DARKNESS = (short)statusEffects.STATUS_DARKNESS;
		const short STATUS_LIFESPAN_REMAINING = (short)statusEffects.STATUS_LIFESPAN_REMAINING;
		const short STATUS_SHIELDED = (short)statusEffects.STATUS_SHIELDED;
		const short STATUS_INVISIBLE = (short)statusEffects.STATUS_INVISIBLE;
		const short STATUS_AGGRAVATING = (short)statusEffects.STATUS_AGGRAVATING;
		const short NUMBER_OF_STATUS_EFFECTS = (short)statusEffects.NUMBER_OF_STATUS_EFFECTS;

		const creatureStates MONSTER_SLEEPING = creatureStates.MONSTER_SLEEPING;
		const creatureStates MONSTER_TRACKING_SCENT = creatureStates.MONSTER_TRACKING_SCENT;
		const creatureStates MONSTER_WANDERING = creatureStates.MONSTER_WANDERING;
		const creatureStates MONSTER_FLEEING = creatureStates.MONSTER_FLEEING;
		const creatureStates MONSTER_ALLY = creatureStates.MONSTER_ALLY;

		const ulong ITEM_IDENTIFIED = (ulong)itemFlags.ITEM_IDENTIFIED;
		const ulong ITEM_EQUIPPED = (ulong)itemFlags.ITEM_EQUIPPED;
		const ulong ITEM_CURSED = (ulong)itemFlags.ITEM_CURSED;
		const ulong ITEM_PROTECTED = (ulong)itemFlags.ITEM_PROTECTED;

		const ulong ITEM_RUNIC = (ulong)itemFlags.ITEM_RUNIC;
		const ulong ITEM_RUNIC_HINTED = (ulong)itemFlags.ITEM_RUNIC_HINTED;
		const ulong ITEM_RUNIC_IDENTIFIED = (ulong)itemFlags.ITEM_RUNIC_IDENTIFIED;
		const ulong ITEM_CAN_BE_IDENTIFIED = (ulong)itemFlags.ITEM_CAN_BE_IDENTIFIED;
		const ulong ITEM_PREPLACED = (ulong)itemFlags.ITEM_PREPLACED;
		const ulong ITEM_FLAMMABLE = (ulong)itemFlags.ITEM_FLAMMABLE;
		const ulong ITEM_MAGIC_DETECTED = (ulong)itemFlags.ITEM_MAGIC_DETECTED;
		const ulong ITEM_MAX_CHARGES_KNOWN = (ulong)itemFlags.ITEM_MAX_CHARGES_KNOWN;
		const ulong ITEM_IS_KEY = (ulong)itemFlags.ITEM_IS_KEY;


		//---------------- data ----------------

		levelData[] levels;
		playerCharacter rogue = new playerCharacter();
		public playerCharacter getRogue() { return rogue; }

		creature player ; //  = new creature();
		public creature getPlayer() { return player; }

		char[,] displayDetail = new char[DCOLS,DROWS];		// used to make certain per-cell data accessible to external code (e.g. terminal adaptations)

		color[, ]dynamicColors =  Global.GetInstance().dynamicColors;
			
		creatureType[] monsterCatalog = Global.GetInstance().monsterCatalog ;
		feat[] featTable = Global.GetInstance().featTable ;
		lightSource[] lightCatalog = Global.GetInstance().lightCatalog ;

		tcell[,] tmap = Global .tmap ;						// grids with info about the map
		pcell[,] pmap = Global  .pmap  ;


		creature monsters;
		creature dormantMonsters;
		creature graveyard;
		creature purgatory;

		item floorItems;
		public item packItems;
		item monsterItemsHopper;

		short [][]scentMap;
		short [,,]terrainRandomValues = new short[DCOLS,DROWS,8];
		short [][]safetyMap;								// used to help monsters flee
		short [][]allySafetyMap;							// used to help allies flee
		short [][]chokeMap;	

		// temp value ?
		short oldRNG;

		// ----------------------------------

		int rand_range( int lower , int upper) {
			int result =  Random.rand_range (lower, upper);

			//Debug.Log ( string.Format("randdome between {0}-{1}: {2} " , lower, upper , result) );
			return result;
		}

		public void initializeRogue( ulong seed ) {
			// short oldRNG;  // moved
			item theItem;

			rogue.RNG = RNG_SUBSTANTIVE;
			//if (!rogue.playbackMode) 
			{
				rogue.seed = Random.seedRandomGenerator(seed);
				//previousGameSeed = rogue.seed;
			}

			levels = commonFunc.GetInstance().initialize_1D_objectArray<levelData> ( DEEPEST_LEVEL+1 );// malloc(sizeof(levelData) * (DEEPEST_LEVEL+1));

			// 固定的 level1 入口楼梯
			levels[0].upStairsLoc[0] = (DCOLS - 1) / 2 - 1;
			levels[0].upStairsLoc[1] = DROWS - 2;

			// reset enchant and gain strength frequencies
			rogue.lifePotionFrequency = 0;
			rogue.strengthPotionFrequency = 40;
			rogue.enchantScrollFrequency = 60;

			// all DF messages are eligible for display
			Architect.GetInstance().resetDFMessageEligibility();

			// initialize the levels list
			for (int i=0; i<DEEPEST_LEVEL+1; i++) {
				// qibinyi ,add to avoid crash
				levels[i].scentMap = null ;

				levels[i].levelSeed = (ulong) rand_range(0, 9999);
				levels[i].levelSeed += (ulong) (10000 * rand_range(0, 9999) );
				levels[i].monsters = null;
				levels[i].dormantMonsters = null;
				levels[i].items = null;
				levels[i].visited = false;
				levels[i].playerExitedVia[0] = 0;
				levels[i].playerExitedVia[1] = 0;

				// 随机 楼梯位置,  DEEPEST_LEVEL 前
				do {
					levels[i].downStairsLoc[0] = (short)rand_range(1, DCOLS - 2);
					levels[i].downStairsLoc[1] = (short)rand_range(1, DROWS - 2);
				} while ( Monsters.distanceBetween(levels[i].upStairsLoc[0], levels[i].upStairsLoc[1],
					levels[i].downStairsLoc[0], levels[i].downStairsLoc[1]) < DCOLS / 3);
				
				if (i < DEEPEST_LEVEL) {
					levels[i+1].upStairsLoc[0] = levels[i].downStairsLoc[0];
					levels[i+1].upStairsLoc[1] = levels[i].downStairsLoc[1];
				}
			}

			// initialize the waypoints list
			for (int i=0; i<MAX_WAYPOINT_COUNT; i++) {
				rogue.wpDistance [i] = Grid.allocGrid();
				Grid.fillGrid(rogue.wpDistance[i], 0);
			}

			rogue.rewardRoomsGenerated = 0;

			// pre-shuffle the random terrain colors
			oldRNG = rogue.RNG;
			rogue.RNG = RNG_COSMETIC;
			//assureCosmeticRNG;
			for (int i=0; i<DCOLS; i++) {
				for( int j=0; j<DROWS; j++ ) {
					for (int k=0; k<8; k++) {
						terrainRandomValues[i,j,k] = (short)rand_range(0, 1000);
					}
				}
			}
			rogue.RNG = oldRNG; //restoreRNG();

			Architect.GetInstance().zeroOutGrid(displayDetail);

			// monsterCatalog ID 初始化
			for ( int i=0; i<NUMBER_MONSTER_KINDS; i++) {
				monsterCatalog[i].monsterID = (monsterTypes)i;
			}

			// Debug.Log ( "" + Global. white.red );

			Items.GetInstance ().shuffleFlavors ();

			for (int i = 0; i < FEAT_COUNT; i++) {
				rogue.featRecord[i] = featTable[i].initialValue;
			}

			/* TODO
			deleteMessages();
			for (i = 0; i < MESSAGE_ARCHIVE_LINES; i++) { // Clear the message archive.
				messageArchive[i][0] = '\0';   // commonFunc.zeroOut_1D_array ?
			}
			messageArchivePosition = 0;			
			//*/

			// Seed the stacks.
			floorItems = new item();
			floorItems.nextItem = null ;

			packItems = new item();
			packItems.nextItem = null ;

			monsterItemsHopper = new item();
			monsterItemsHopper.nextItem = null ;

			// item carried by monster
			for (int i = 0; i < MAX_ITEMS_IN_MONSTER_ITEMS_HOPPER; i++) {
				theItem = generateItem(ALL_ITEMS & ~FOOD, -1); // Monsters can't carry food: the food clock cannot be cheated!
				theItem.nextItem = monsterItemsHopper.nextItem;
				monsterItemsHopper.nextItem = theItem;
			}
			//*
			monsters = new creature ();
			monsters.nextCreature = null;

			dormantMonsters = new creature ();
			dormantMonsters.nextCreature = null;

			graveyard = new creature ();
			graveyard.nextCreature = null;

			purgatory = new creature ();
			purgatory.nextCreature = null;
			//*/

			scentMap			= null;

			safetyMap			= Grid.allocGrid();
			allySafetyMap		= Grid.allocGrid();
			chokeMap			= Grid.allocGrid();

			rogue.mapToSafeTerrain = Grid.allocGrid();

			// Zero out the dynamic grids, as an essential safeguard against OOSes:
			Grid.fillGrid(safetyMap, 0);
			Grid.fillGrid(allySafetyMap, 0);
			Grid.fillGrid(chokeMap, 0);
			Grid.fillGrid(rogue.mapToSafeTerrain, 0);

			// initialize the player
			player  = new creature() ;
			player.info = monsterCatalog[0]; // caution: problem may occur

			Monsters.GetInstance().initializeGender(player);
			player.movementSpeed = player.info.movementSpeed;
			player.attackSpeed = player.info.attackSpeed;
			Monsters.GetInstance().clearStatus(player);
			player.carriedItem = null;
			player.status[STATUS_NUTRITION] = player.maxStatus[STATUS_NUTRITION] = STOMACH_SIZE;
			player.currentHP = player.info.maxHP;
			rogue.previousHealthPercent = 100;
			rogue.previousPoisonPercent = 0;
			player.creatureState = MONSTER_ALLY;
			player.ticksUntilTurn = 0;
			player.mutationIndex = -1;
			//*/

			// init rogue
			rogue.depthLevel = 1;
			rogue.deepestLevel = 1;
			rogue.scentTurnNumber = 1000;
			rogue.playerTurnNumber = 0;
			rogue.absoluteTurnNumber = 0;
			rogue.foodSpawned = 0;
			rogue.lifePotionsSpawned = 0;
			rogue.gold = 0;
			rogue.goldGenerated = 0;
			rogue.disturbed = false;
			rogue.autoPlayingLevel = false;
			rogue.automationActive = false;
			rogue.justRested = false;
			rogue.easyMode = false;
			rogue.inWater = false;
			rogue.creaturesWillFlashThisTurn = false;
			rogue.updatedSafetyMapThisTurn = false;
			rogue.updatedAllySafetyMapThisTurn = false;
			rogue.updatedMapToSafeTerrainThisTurn = false;
			rogue.updatedMapToShoreThisTurn = false;
			rogue.strength = 12;
			rogue.weapon = null;
			rogue.armor = null;
			rogue.ringLeft = null;
			rogue.ringRight = null;
			rogue.monsterSpawnFuse = (ushort)rand_range(125, 175);
			rogue.ticksTillUpdateEnvironment = 100;
			rogue.mapToShore = null;
			rogue.cursorLoc[0] = rogue.cursorLoc[1] = -1;
			rogue.xpxpThisTurn = 0;

			rogue.yendorWarden = null;

			rogue.flares = null;
			rogue.flareCount = rogue.flareCapacity = 0;


			rogue.minersLight = lightCatalog[ (int)Global.MINERS_LIGHT];
			rogue.clairvoyance = rogue.regenerationBonus
				= rogue.stealthBonus = rogue.transference = rogue.wisdomBonus = rogue.reaping = 0;
			rogue.lightMultiplier = 1;

			theItem = generateItem(FOOD, (short)foodKind.RATION);
			theItem = addItemToPack(theItem);

			theItem = generateItem(WEAPON, (short)weaponKind.DAGGER);
			theItem.enchant1 = theItem.enchant2 = 0;
			theItem.flags &= ~(ITEM_CURSED | ITEM_RUNIC);
			identify(theItem);
			theItem = addItemToPack(theItem);
			equipItem(theItem, false);

			theItem = generateItem(WEAPON, (short)weaponKind.DART);
			theItem.enchant1 = theItem.enchant2 = 0;
			theItem.quantity = 15;
			theItem.flags &= ~(ITEM_CURSED | ITEM_RUNIC);
			identify(theItem);
			theItem = addItemToPack(theItem);

			theItem = generateItem(ARMOR, (short)armorKind.LEATHER_ARMOR);
			theItem.enchant1 = 0;
			theItem.flags &= ~(ITEM_CURSED | ITEM_RUNIC);
			identify(theItem);
			theItem = addItemToPack(theItem);
			equipItem(theItem, false);
			player.status[STATUS_DONNING] = 0;

			recalculateEquipmentBonuses();

			/* TODO
			blackOutScreen();

			//*/
			welcome();

		} //  end initializeRogue


		public void startLevel(short oldLevelNumber, short stairDirection) {
			ulong oldSeed;
			item theItem;
			short[] loc = new short [2];
			short i, j, x, y, px, py, flying, dir;

			bool placedPlayer;
			creature monst;
			dungeonLayers layer;
			ulong timeAway;
			short [][]mapToStairs;
			short [][]mapToPit;
			bool connectingStairsDiscovered;

			if (oldLevelNumber == DEEPEST_LEVEL && stairDirection != -1) {
				return;
			}

			Time.GetInstance().synchronizePlayerTimeState();

			rogue.updatedSafetyMapThisTurn			= false;
			rogue.updatedAllySafetyMapThisTurn		= false;
			rogue.updatedMapToSafeTerrainThisTurn	= false;


			rogue.cursorLoc[0] = -1;
			rogue.cursorLoc[1] = -1;
			rogue.lastTarget = null;

			connectingStairsDiscovered = (pmap[rogue.downLoc[0],rogue.downLoc[1]].flags & (int)( tileFlags.DISCOVERED | tileFlags.MAGIC_MAPPED ) )!=0 ? true : false;
			if (stairDirection == 0) { // fallen
				levels[oldLevelNumber-1].playerExitedVia[0] = player.xLoc;
				levels[oldLevelNumber-1].playerExitedVia[1] = player.yLoc;
			}

			// TODO
			//if (oldLevelNumber != rogue.depthLevel) {
			// ...


			for (monst = monsters.nextCreature; monst != null; monst = monst.nextCreature) {
				if (monst.mapToMe!=null) {
					Grid.freeGrid(monst.mapToMe);
					monst.mapToMe = null;
				}
				if (monst.safetyMap!=null) {
					Grid.freeGrid(monst.safetyMap);
					monst.safetyMap = null;
				}
			}

			levels[oldLevelNumber-1].monsters = monsters.nextCreature;
			levels[oldLevelNumber-1].dormantMonsters = dormantMonsters.nextCreature;
			levels[oldLevelNumber-1].items = floorItems.nextItem;

			for (i=0; i<DCOLS; i++) {
				for (j=0; j<DROWS; j++) {
					if ( (pmap[i,j].flags & (int)tileFlags.VISIBLE) != 0) {
						// Remember visible cells upon exiting.
						Movement.GetInstance().storeMemories(i, j);
					}
					for (layer = 0; layer < dungeonLayers.NUMBER_TERRAIN_LAYERS; layer++) {
						levels[oldLevelNumber - 1].mapStorage[i,j].layers[(int)layer] = pmap[i,j].layers[(int)layer];
					}
					levels[oldLevelNumber - 1].mapStorage[i,j].volume = pmap[i,j].volume;
					levels[oldLevelNumber - 1].mapStorage[i,j].flags = (pmap[i,j].flags & (int)tileFlags.PERMANENT_TILE_FLAGS);
					levels[oldLevelNumber - 1].mapStorage[i,j].rememberedAppearance = pmap[i,j].rememberedAppearance;
					levels[oldLevelNumber - 1].mapStorage[i,j].rememberedTerrain = pmap[i,j].rememberedTerrain;
					levels[oldLevelNumber - 1].mapStorage[i,j].rememberedItemCategory = pmap[i,j].rememberedItemCategory;
					levels[oldLevelNumber - 1].mapStorage[i,j].rememberedItemKind = pmap[i,j].rememberedItemKind;
					levels[oldLevelNumber - 1].mapStorage[i,j].rememberedCellFlags = pmap[i,j].rememberedCellFlags;
					levels[oldLevelNumber - 1].mapStorage[i,j].rememberedTerrainFlags = pmap[i,j].rememberedTerrainFlags;
					levels[oldLevelNumber - 1].mapStorage[i,j].rememberedTMFlags = pmap[i,j].rememberedTMFlags;
					levels[oldLevelNumber - 1].mapStorage[i,j].machineNumber = pmap[i,j].machineNumber;
				}
			}

			levels[oldLevelNumber - 1].awaySince = rogue.absoluteTurnNumber;

			//	Prepare the new level
			rogue.minersLightRadius = 2.25f + (DCOLS - 1) * (float) Math.Pow(0.85f, rogue.depthLevel);
			updateColors();
			Items.GetInstance().updateRingBonuses(); // also updates miner's light


			if (!levels[rogue.depthLevel - 1].visited) { // level has not already been visited
				levels[rogue.depthLevel - 1].scentMap = Grid.allocGrid();
				scentMap = levels[rogue.depthLevel - 1].scentMap;
				Grid.fillGrid(levels[rogue.depthLevel - 1].scentMap, 0);
				// generate new level
				oldSeed = (ulong) rand_range(0, 9999);
				oldSeed += (ulong)( 10000 * rand_range(0, 9999) );
				Random.seedRandomGenerator(levels[rogue.depthLevel - 1].levelSeed);

				// Load up next level's monsters and items, since one might have fallen from above.
				monsters.nextCreature			= levels[rogue.depthLevel-1].monsters;
				dormantMonsters.nextCreature	= levels[rogue.depthLevel-1].dormantMonsters;
				floorItems.nextItem			= levels[rogue.depthLevel-1].items;

				levels[rogue.depthLevel-1].monsters = null;
				levels[rogue.depthLevel-1].dormantMonsters = null;
				levels[rogue.depthLevel-1].items = null;

				Architect.GetInstance().digDungeon();
				/*
				initializeLevel();
				setUpWaypoints();

				shuffleTerrainColors(100, false);

				// If we somehow failed to generate the amulet altar,
				// just toss an amulet in there somewhere.
				// It'll be fiiine!
				if (rogue.depthLevel == RogueH.AMULET_LEVEL
					&& !numberOfMatchingPackItems(AMULET, 0, 0, false)
					&& levels[rogue.depthLevel-1].visited == false) {

					for (theItem = floorItems.nextItem; theItem != null; theItem = theItem.nextItem) {
						if (theItem.category & AMULET) {
							break;
						}
					}
					for (monst = monsters.nextCreature; monst != null; monst = monst.nextCreature) {
						if (monst.carriedItem
							&& (monst.carriedItem.category & AMULET)) {

							theItem = monst.carriedItem;
							break;
						}
					}
					if (!theItem) {
						placeItem(generateItem(AMULET, 0), 0, 0);
					}
				}
				//*/
				Random.seedRandomGenerator(oldSeed);

				//logLevel();

				// Simulate 50 turns so the level is broken in (swamp gas accumulating, brimstone percolating, etc.).
				timeAway = 50;

			}


		} // end startlevel


		// call this once per level to set all the dynamic colors as a function of depth
		void updateColors() {
			short i;

			for (i=0; i< RogueH.NUMBER_DYNAMIC_COLORS; i++) {
				//*(dynamicColors[i,0]) = *(dynamicColors[i,1]);
				ObjectCopier.CopyFrom(  dynamicColors[i,0] , dynamicColors[i,1]  );
				IO.applyColorAverage(dynamicColors[i,0], dynamicColors[i,2], (short) Math.Min(100, Math.Max(0, rogue.depthLevel * 100 / RogueH.AMULET_LEVEL)));
			}
		}

		/*
		public void restoreRNG() {
			rogue.RNG = oldRNG;
		}

		public void assureCosmeticRNG() {
			short oldRNG = rogue.RNG;
			rogue.RNG = RNG_COSMETIC;
		}
		//*/

		

		void welcome() {
			//*
			char[] buf = new char[DCOLS*3];
			char[] buf2 = new char [DCOLS*3];

			IO.message("Hello and welcome, adventurer, to the Dungeons of Doom!", false);
			commonFunc.strcpy(buf, "Retrieve the ");
			IO.GetInstance().encodeMessageColor(buf, commonFunc.strlen(buf), Global.itemMessageColor);
			commonFunc.strcat(buf, "Amulet of Yendor");
			IO.GetInstance().encodeMessageColor(buf, commonFunc.strlen(buf), Global.white);
			commonFunc.sprintf(buf2, 
				" from the {0}th floor and escape with it!", __arglist(RogueH.AMULET_LEVEL));
			commonFunc.strcat(buf, buf2);
			IO.message(buf, false);
			//*/
			/*
			if (KEYBOARD_LABELS) {
				messageWithColor("Press <?> for help at any time.", &backgroundMessageColor, false);
			}
			//*/
			
			IO.flavorMessage("The doors to the dungeon slam shut behind you.");

		}

		public static void brogueAssert( bool cond) {
			if (!cond)
				throw new Exception ();
		}

		// ---------------// ---------------// ---------------// ---------------
		// ---------------// ---------------// ---------------// ---------------
		// ---------------// ---------------// ---------------// ---------------

		item generateItem( ushort theCategory, short theKind) {
			return Items.GetInstance().generateItem( theCategory , theKind );
		}
		item addItemToPack(item theItem) {
			return Items.GetInstance ().addItemToPack ( theItem );
		}
		void identify(item theItem) {
			Items.GetInstance ().identify (theItem);
		}
		void equipItem(item theItem, bool  force) {
			Items.GetInstance ().equipItem(theItem, force) ;
		}

		void recalculateEquipmentBonuses() {
			Items.GetInstance ().recalculateEquipmentBonuses ();
		}

	}
}

