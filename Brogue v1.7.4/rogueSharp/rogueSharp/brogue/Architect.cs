using System;

namespace rogueSharp
{
	public class Architect:Singleton<Architect>
	{

		private Architect ()
		{
		}

		public const int NUMBER_DUNGEON_FEATURES = RogueH.NUMBER_DUNGEON_FEATURES ;


		const int DCOLS = RogueH.DCOLS; 
		const int DROWS = RogueH.DROWS; 
		const int ROOM_TYPE_COUNT = RogueH.ROOM_TYPE_COUNT ;

		static short[,] nbDirs  =  Global .nbDirs ; 
		static short[,] cDirs   =  Global .cDirs ; 

		public const bool D_INSPECT_LEVELGEN = false ;

		public const int  CAVE_MIN_WIDTH						=50;
		public const int  CAVE_MIN_HEIGHT						=20;

		public const int HORIZONTAL_CORRIDOR_MIN_LENGTH		=5;
		public const int HORIZONTAL_CORRIDOR_MAX_LENGTH		=15;
		public const int VERTICAL_CORRIDOR_MIN_LENGTH		=2;
		public const int VERTICAL_CORRIDOR_MAX_LENGTH		=9;

		public const int NO_LAYER = (int)dungeonLayers.NO_LAYER;
		public const int DUNGEON = (int)dungeonLayers.DUNGEON;		// dungeon-level tile	(e.g. walls)
		public const int LIQUID = (int)dungeonLayers.LIQUID ;				// liquid-level tile	(e.g. lava)
		public const int GAS = (int)dungeonLayers.GAS ;				// gas-level tile		(e.g. fire, smoke, swamp gas)
		public const int SURFACE = (int)dungeonLayers.SURFACE ;			// surface-level tile	(e.g. grass)
		public const int NUMBER_TERRAIN_LAYERS = (int)dungeonLayers.NUMBER_TERRAIN_LAYERS ;	

		public const tileType NOTHING = tileType.NOTHING ;
		public const tileType GRANITE = tileType.GRANITE ;
		public const tileType FLOOR = tileType.FLOOR ;
		public const tileType FLOOR_FLOODABLE = tileType.FLOOR_FLOODABLE ;
		public const tileType CARPET = tileType.CARPET ;
		public const tileType MARBLE_FLOOR = tileType.MARBLE_FLOOR ;
		public const tileType WALL = tileType.WALL ;
		public const tileType DOOR = tileType.DOOR ;
		public const tileType OPEN_DOOR = tileType.OPEN_DOOR ;
		public const tileType SECRET_DOOR = tileType.SECRET_DOOR ;
		public const tileType LOCKED_DOOR = tileType.LOCKED_DOOR ;
		public const tileType OPEN_IRON_DOOR_INERT = tileType.OPEN_IRON_DOOR_INERT ;
		public const tileType DOWN_STAIRS = tileType.DOWN_STAIRS ;
		public const tileType UP_STAIRS = tileType.UP_STAIRS ;
		public const tileType DUNGEON_EXIT = tileType.DUNGEON_EXIT ;
		public const tileType DUNGEON_PORTAL = tileType.DUNGEON_PORTAL ;
		public const tileType TORCH_WALL = tileType.TORCH_WALL ; // wall lit with a torch
		public const tileType CRYSTAL_WALL = tileType.CRYSTAL_WALL ;
		public const tileType PORTCULLIS_CLOSED = tileType.PORTCULLIS_CLOSED ;
		public const tileType PORTCULLIS_DORMANT = tileType.PORTCULLIS_DORMANT ;
		public const tileType WOODEN_BARRICADE = tileType.WOODEN_BARRICADE ;
		public const tileType PILOT_LIGHT_DORMANT = tileType.PILOT_LIGHT_DORMANT ;
		public const tileType PILOT_LIGHT = tileType.PILOT_LIGHT ;
		public const tileType HAUNTED_TORCH_DORMANT = tileType.HAUNTED_TORCH_DORMANT ;
		public const tileType HAUNTED_TORCH_TRANSITIONING = tileType.HAUNTED_TORCH_TRANSITIONING ;
		public const tileType HAUNTED_TORCH = tileType.HAUNTED_TORCH ;
		public const tileType WALL_LEVER_HIDDEN = tileType.WALL_LEVER_HIDDEN ;
		public const tileType WALL_LEVER = tileType.WALL_LEVER ;
		public const tileType WALL_LEVER_PULLED = tileType.WALL_LEVER_PULLED ;
		public const tileType WALL_LEVER_HIDDEN_DORMANT = tileType.WALL_LEVER_HIDDEN_DORMANT ;
		public const tileType STATUE_INERT = tileType.STATUE_INERT ;
		public const tileType STATUE_DORMANT = tileType.STATUE_DORMANT ;
		public const tileType STATUE_CRACKING = tileType.STATUE_CRACKING ;
		public const tileType STATUE_INSTACRACK = tileType.STATUE_INSTACRACK ;
		public const tileType PORTAL = tileType.PORTAL ;
		public const tileType TURRET_DORMANT = tileType.TURRET_DORMANT ;
		public const tileType WALL_MONSTER_DORMANT = tileType.WALL_MONSTER_DORMANT ;
		public const tileType DARK_FLOOR_DORMANT = tileType.DARK_FLOOR_DORMANT ;
		public const tileType DARK_FLOOR_DARKENING = tileType.DARK_FLOOR_DARKENING ;
		public const tileType DARK_FLOOR = tileType.DARK_FLOOR ;
		public const tileType MACHINE_TRIGGER_FLOOR = tileType.MACHINE_TRIGGER_FLOOR ;
		public const tileType ALTAR_INERT = tileType.ALTAR_INERT ;
		public const tileType ALTAR_KEYHOLE = tileType.ALTAR_KEYHOLE ;
		public const tileType ALTAR_CAGE_OPEN = tileType.ALTAR_CAGE_OPEN ;
		public const tileType ALTAR_CAGE_CLOSED = tileType.ALTAR_CAGE_CLOSED ;
		public const tileType ALTAR_SWITCH = tileType.ALTAR_SWITCH ;
		public const tileType ALTAR_SWITCH_RETRACTING = tileType.ALTAR_SWITCH_RETRACTING ;
		public const tileType ALTAR_CAGE_RETRACTABLE = tileType.ALTAR_CAGE_RETRACTABLE ;
		public const tileType PEDESTAL = tileType.PEDESTAL ;
		public const tileType MONSTER_CAGE_OPEN = tileType.MONSTER_CAGE_OPEN ;
		public const tileType MONSTER_CAGE_CLOSED = tileType.MONSTER_CAGE_CLOSED ;
		public const tileType COFFIN_CLOSED = tileType.COFFIN_CLOSED ;
		public const tileType COFFIN_OPEN = tileType.COFFIN_OPEN ;
		public const tileType GAS_TRAP_POISON_HIDDEN = tileType.GAS_TRAP_POISON_HIDDEN ;
		public const tileType GAS_TRAP_POISON = tileType.GAS_TRAP_POISON ;
		public const tileType TRAP_DOOR_HIDDEN = tileType.TRAP_DOOR_HIDDEN ;
		public const tileType TRAP_DOOR = tileType.TRAP_DOOR ;
		public const tileType GAS_TRAP_PARALYSIS_HIDDEN = tileType.GAS_TRAP_PARALYSIS_HIDDEN ;
		public const tileType GAS_TRAP_PARALYSIS = tileType.GAS_TRAP_PARALYSIS ;
		public const tileType MACHINE_PARALYSIS_VENT_HIDDEN = tileType.MACHINE_PARALYSIS_VENT_HIDDEN ;
		public const tileType MACHINE_PARALYSIS_VENT = tileType.MACHINE_PARALYSIS_VENT ;
		public const tileType GAS_TRAP_CONFUSION_HIDDEN = tileType.GAS_TRAP_CONFUSION_HIDDEN ;
		public const tileType GAS_TRAP_CONFUSION = tileType.GAS_TRAP_CONFUSION ;
		public const tileType FLAMETHROWER_HIDDEN = tileType.FLAMETHROWER_HIDDEN ;
		public const tileType FLAMETHROWER = tileType.FLAMETHROWER ;
		public const tileType FLOOD_TRAP_HIDDEN = tileType.FLOOD_TRAP_HIDDEN ;
		public const tileType FLOOD_TRAP = tileType.FLOOD_TRAP ;
		public const tileType NET_TRAP_HIDDEN = tileType.NET_TRAP_HIDDEN ;
		public const tileType NET_TRAP = tileType.NET_TRAP ;
		public const tileType ALARM_TRAP_HIDDEN = tileType.ALARM_TRAP_HIDDEN ;
		public const tileType ALARM_TRAP = tileType.ALARM_TRAP ;
		public const tileType MACHINE_POISON_GAS_VENT_HIDDEN = tileType.MACHINE_POISON_GAS_VENT_HIDDEN ;
		public const tileType MACHINE_POISON_GAS_VENT_DORMANT = tileType.MACHINE_POISON_GAS_VENT_DORMANT ;
		public const tileType MACHINE_POISON_GAS_VENT = tileType.MACHINE_POISON_GAS_VENT ;
		public const tileType MACHINE_METHANE_VENT_HIDDEN = tileType.MACHINE_METHANE_VENT_HIDDEN ;
		public const tileType MACHINE_METHANE_VENT_DORMANT = tileType.MACHINE_METHANE_VENT_DORMANT ;
		public const tileType MACHINE_METHANE_VENT = tileType.MACHINE_METHANE_VENT ;
		public const tileType STEAM_VENT = tileType.STEAM_VENT ;
		public const tileType MACHINE_PRESSURE_PLATE = tileType.MACHINE_PRESSURE_PLATE ;
		public const tileType MACHINE_PRESSURE_PLATE_USED = tileType.MACHINE_PRESSURE_PLATE_USED ;
		public const tileType MACHINE_GLYPH = tileType.MACHINE_GLYPH ;
		public const tileType MACHINE_GLYPH_INACTIVE = tileType.MACHINE_GLYPH_INACTIVE ;
		public const tileType DEWAR_CAUSTIC_GAS = tileType.DEWAR_CAUSTIC_GAS ;
		public const tileType DEWAR_CONFUSION_GAS = tileType.DEWAR_CONFUSION_GAS ;
		public const tileType DEWAR_PARALYSIS_GAS = tileType.DEWAR_PARALYSIS_GAS ;
		public const tileType DEWAR_METHANE_GAS = tileType.DEWAR_METHANE_GAS ;
		public const tileType DEEP_WATER = tileType.DEEP_WATER ;
		public const tileType SHALLOW_WATER = tileType.SHALLOW_WATER ;
		public const tileType MUD = tileType.MUD ;
		public const tileType CHASM = tileType.CHASM ;
		public const tileType CHASM_EDGE = tileType.CHASM_EDGE ;
		public const tileType MACHINE_COLLAPSE_EDGE_DORMANT = tileType.MACHINE_COLLAPSE_EDGE_DORMANT ;
		public const tileType MACHINE_COLLAPSE_EDGE_SPREADING = tileType.MACHINE_COLLAPSE_EDGE_SPREADING ;
		public const tileType LAVA = tileType.LAVA ;
		public const tileType LAVA_RETRACTABLE = tileType.LAVA_RETRACTABLE ;
		public const tileType LAVA_RETRACTING = tileType.LAVA_RETRACTING ;
		public const tileType SUNLIGHT_POOL = tileType.SUNLIGHT_POOL ;
		public const tileType DARKNESS_PATCH = tileType.DARKNESS_PATCH ;
		public const tileType ACTIVE_BRIMSTONE = tileType.ACTIVE_BRIMSTONE ;
		public const tileType INERT_BRIMSTONE = tileType.INERT_BRIMSTONE ;
		public const tileType OBSIDIAN = tileType.OBSIDIAN ;
		public const tileType BRIDGE = tileType.BRIDGE ;
		public const tileType BRIDGE_FALLING = tileType.BRIDGE_FALLING ;
		public const tileType BRIDGE_EDGE = tileType.BRIDGE_EDGE ;
		public const tileType STONE_BRIDGE = tileType.STONE_BRIDGE ;
		public const tileType MACHINE_FLOOD_WATER_DORMANT = tileType.MACHINE_FLOOD_WATER_DORMANT ;
		public const tileType MACHINE_FLOOD_WATER_SPREADING = tileType.MACHINE_FLOOD_WATER_SPREADING ;
		public const tileType MACHINE_MUD_DORMANT = tileType.MACHINE_MUD_DORMANT ;
		public const tileType HOLE = tileType.HOLE ;
		public const tileType HOLE_GLOW = tileType.HOLE_GLOW ;
		public const tileType HOLE_EDGE = tileType.HOLE_EDGE ;
		public const tileType FLOOD_WATER_DEEP = tileType.FLOOD_WATER_DEEP ;
		public const tileType FLOOD_WATER_SHALLOW = tileType.FLOOD_WATER_SHALLOW ;
		public const tileType GRASS = tileType.GRASS ;
		public const tileType DEAD_GRASS = tileType.DEAD_GRASS ;
		public const tileType GRAY_FUNGUS = tileType.GRAY_FUNGUS ;
		public const tileType LUMINESCENT_FUNGUS = tileType.LUMINESCENT_FUNGUS ;
		public const tileType LICHEN = tileType.LICHEN ;
		public const tileType HAY = tileType.HAY ;
		public const tileType RED_BLOOD = tileType.RED_BLOOD ;
		public const tileType GREEN_BLOOD = tileType.GREEN_BLOOD ;
		public const tileType PURPLE_BLOOD = tileType.PURPLE_BLOOD ;
		public const tileType ACID_SPLATTER = tileType.ACID_SPLATTER ;
		public const tileType VOMIT = tileType.VOMIT ;
		public const tileType URINE = tileType.URINE ;
		public const tileType UNICORN_POOP = tileType.UNICORN_POOP ;
		public const tileType WORM_BLOOD = tileType.WORM_BLOOD ;
		public const tileType ASH = tileType.ASH ;
		public const tileType BURNED_CARPET = tileType.BURNED_CARPET ;
		public const tileType PUDDLE = tileType.PUDDLE ;
		public const tileType BONES = tileType.BONES ;
		public const tileType RUBBLE = tileType.RUBBLE ;
		public const tileType JUNK = tileType.JUNK ;
		public const tileType BROKEN_GLASS = tileType.BROKEN_GLASS ;
		public const tileType ECTOPLASM = tileType.ECTOPLASM ;
		public const tileType EMBERS = tileType.EMBERS ;
		public const tileType SPIDERWEB = tileType.SPIDERWEB ;
		public const tileType NETTING = tileType.NETTING ;
		public const tileType FOLIAGE = tileType.FOLIAGE ;
		public const tileType DEAD_FOLIAGE = tileType.DEAD_FOLIAGE ;
		public const tileType TRAMPLED_FOLIAGE = tileType.TRAMPLED_FOLIAGE ;
		public const tileType FUNGUS_FOREST = tileType.FUNGUS_FOREST ;
		public const tileType TRAMPLED_FUNGUS_FOREST = tileType.TRAMPLED_FUNGUS_FOREST ;
		public const tileType FORCEFIELD = tileType.FORCEFIELD ;
		public const tileType FORCEFIELD_MELT = tileType.FORCEFIELD_MELT ;
		public const tileType SACRED_GLYPH = tileType.SACRED_GLYPH ;
		public const tileType MANACLE_TL = tileType.MANACLE_TL ;
		public const tileType MANACLE_BR = tileType.MANACLE_BR ;
		public const tileType MANACLE_TR = tileType.MANACLE_TR ;
		public const tileType MANACLE_BL = tileType.MANACLE_BL ;
		public const tileType MANACLE_T = tileType.MANACLE_T ;
		public const tileType MANACLE_B = tileType.MANACLE_B ;
		public const tileType MANACLE_L = tileType.MANACLE_L ;
		public const tileType MANACLE_R = tileType.MANACLE_R ;
		public const tileType PORTAL_LIGHT = tileType.PORTAL_LIGHT ;
		public const tileType GUARDIAN_GLOW = tileType.GUARDIAN_GLOW ;
		public const tileType PLAIN_FIRE = tileType.PLAIN_FIRE ;
		public const tileType BRIMSTONE_FIRE = tileType.BRIMSTONE_FIRE ;
		public const tileType FLAMEDANCER_FIRE = tileType.FLAMEDANCER_FIRE ;
		public const tileType GAS_FIRE = tileType.GAS_FIRE ;
		public const tileType GAS_EXPLOSION = tileType.GAS_EXPLOSION ;
		public const tileType DART_EXPLOSION = tileType.DART_EXPLOSION ;
		public const tileType ITEM_FIRE = tileType.ITEM_FIRE ;
		public const tileType CREATURE_FIRE = tileType.CREATURE_FIRE ;
		public const tileType POISON_GAS = tileType.POISON_GAS ;
		public const tileType CONFUSION_GAS = tileType.CONFUSION_GAS ;
		public const tileType ROT_GAS = tileType.ROT_GAS ;
		public const tileType STENCH_SMOKE_GAS = tileType.STENCH_SMOKE_GAS ;
		public const tileType PARALYSIS_GAS = tileType.PARALYSIS_GAS ;
		public const tileType METHANE_GAS = tileType.METHANE_GAS ;
		public const tileType STEAM = tileType.STEAM ;
		public const tileType DARKNESS_CLOUD = tileType.DARKNESS_CLOUD ;
		public const tileType HEALING_CLOUD = tileType.HEALING_CLOUD ;
		public const tileType BLOODFLOWER_STALK = tileType.BLOODFLOWER_STALK ;
		public const tileType BLOODFLOWER_POD = tileType.BLOODFLOWER_POD ;
		public const tileType HAVEN_BEDROLL = tileType.HAVEN_BEDROLL ;
		public const tileType DEEP_WATER_ALGAE_WELL = tileType.DEEP_WATER_ALGAE_WELL ;
		public const tileType DEEP_WATER_ALGAE_1 = tileType.DEEP_WATER_ALGAE_1 ;
		public const tileType DEEP_WATER_ALGAE_2 = tileType.DEEP_WATER_ALGAE_2 ;
		public const tileType ANCIENT_SPIRIT_VINES = tileType.ANCIENT_SPIRIT_VINES ;
		public const tileType ANCIENT_SPIRIT_GRASS = tileType.ANCIENT_SPIRIT_GRASS ;
		public const tileType AMULET_SWITCH = tileType.AMULET_SWITCH ;
		public const tileType COMMUTATION_ALTAR = tileType.COMMUTATION_ALTAR ;
		public const tileType COMMUTATION_ALTAR_INERT = tileType.COMMUTATION_ALTAR_INERT ;
		public const tileType PIPE_GLOWING = tileType.PIPE_GLOWING ;
		public const tileType PIPE_INERT = tileType.PIPE_INERT ;
		public const tileType RESURRECTION_ALTAR = tileType.RESURRECTION_ALTAR ;
		public const tileType RESURRECTION_ALTAR_INERT = tileType.RESURRECTION_ALTAR_INERT ;
		public const tileType MACHINE_TRIGGER_FLOOR_REPEATING = tileType.MACHINE_TRIGGER_FLOOR_REPEATING ;
		public const tileType STATUE_INERT_DOORWAY = tileType.STATUE_INERT_DOORWAY ;
		public const tileType STATUE_DORMANT_DOORWAY = tileType.STATUE_DORMANT_DOORWAY ;
		public const tileType CHASM_WITH_HIDDEN_BRIDGE = tileType.CHASM_WITH_HIDDEN_BRIDGE ;
		public const tileType CHASM_WITH_HIDDEN_BRIDGE_ACTIVE = tileType.CHASM_WITH_HIDDEN_BRIDGE_ACTIVE ;
		public const tileType MACHINE_CHASM_EDGE = tileType.MACHINE_CHASM_EDGE ;
		public const tileType RAT_TRAP_WALL_DORMANT = tileType.RAT_TRAP_WALL_DORMANT ;
		public const tileType RAT_TRAP_WALL_CRACKING = tileType.RAT_TRAP_WALL_CRACKING ;
		public const tileType ELECTRIC_CRYSTAL_OFF = tileType.ELECTRIC_CRYSTAL_OFF ;
		public const tileType ELECTRIC_CRYSTAL_ON = tileType.ELECTRIC_CRYSTAL_ON ;
		public const tileType TURRET_LEVER = tileType.TURRET_LEVER ;
		public const tileType WORM_TUNNEL_MARKER_DORMANT = tileType.WORM_TUNNEL_MARKER_DORMANT ;
		public const tileType WORM_TUNNEL_MARKER_ACTIVE = tileType.WORM_TUNNEL_MARKER_ACTIVE ;
		public const tileType WORM_TUNNEL_OUTER_WALL = tileType.WORM_TUNNEL_OUTER_WALL ;
		public const tileType BRAZIER = tileType.BRAZIER ;
		public const tileType MUD_FLOOR = tileType.MUD_FLOOR ;
		public const tileType MUD_WALL = tileType.MUD_WALL ;
		public const tileType MUD_DOORWAY = tileType.MUD_DOORWAY ;
		public const int NUMBER_TILETYPES = (int)tileType.NUMBER_TILETYPES ;

		const directions NO_DIRECTION = directions.NO_DIRECTION;
		// Cardinal directions; must be 0-3:
		const directions UP = directions.UP;
		const directions DOWN = directions.DOWN;
		const directions LEFT = directions.LEFT;
		const directions RIGHT = directions.RIGHT;
		// Secondary directions; must be 4-7:
		const directions UPLEFT = directions.UPLEFT;
		const directions DOWNLEFT = directions.DOWNLEFT;
		const directions UPRIGHT = directions.UPRIGHT;
		const directions DOWNRIGHT = directions.DOWNRIGHT;

		const int DIRECTION_COUNT = (int) directions.DIRECTION_COUNT;


		const ulong DP_BASIC = (ulong)dungeonProfileTypes.DP_BASIC;
		const ulong DP_BASIC_FIRST_ROOM = (ulong)dungeonProfileTypes.DP_BASIC_FIRST_ROOM;

		const ulong DP_GOBLIN_WARREN = (ulong)dungeonProfileTypes.DP_GOBLIN_WARREN;
		const ulong DP_SENTINEL_SANCTUARY = (ulong)dungeonProfileTypes.DP_SENTINEL_SANCTUARY;

		const ulong NUMBER_DUNGEON_PROFILES = (ulong)dungeonProfileTypes.NUMBER_DUNGEON_PROFILES;

		// ref

		tcell[,] tmap = Global .tmap ;						// grids with info about the map
		pcell[,] pmap = Global  .pmap  ;
		dungeonProfile[] dungeonProfileCatalog = Global.GetInstance().dungeonProfileCatalog;

		// fields
		short topBlobMinX, topBlobMinY, blobWidth, blobHeight;


		public void resetDFMessageEligibility() {
			short i;

			for (i=0; i<NUMBER_DUNGEON_FEATURES; i++) {
				
				Global.GetInstance().dungeonFeatureCatalog[i].messageDisplayed = false;
			}
		}

		public void zeroOutGrid( char[,] grid) {
			short i, j;
			for (i=0; i<DCOLS; i++) {
				for (j=0; j<DROWS; j++) {
					grid[i,j] = (char)0;
				}
			}
		}

		void clearLevel() {
			short i, j;

			for( i=0; i<DCOLS; i++ ) {
				for( j=0; j<DROWS; j++ ) {
					// init dungeon layer as 花岗岩 only
					pmap[i,j].layers[DUNGEON] = GRANITE;
					pmap[i,j].layers[LIQUID] = NOTHING;
					pmap[i,j].layers[GAS] = NOTHING;
					pmap[i,j].layers[SURFACE] = NOTHING;

					pmap[i,j].machineNumber = 0;
					pmap[i,j].rememberedTerrain = NOTHING;
					pmap[i,j].rememberedTerrainFlags = (ulong)(terrainFlagCatalog.T_OBSTRUCTS_EVERYTHING);
					pmap[i,j].rememberedTMFlags = 0;
					pmap[i,j].rememberedCellFlags = 0;
					pmap[i,j].rememberedItemCategory = 0;
					pmap[i,j].rememberedItemKind = 0;
					pmap[i,j].rememberedItemQuantity = 0;
					pmap[i,j].flags = 0;
					pmap[i,j].volume = 0;
				}
			}
		}

		void adjustDungeonProfileForDepth(dungeonProfile theProfile) {
			playerCharacter rogue = RogueMain.GetInstance().getRogue(); 

			short descentPercent = (short) Random.clamp(100 * (rogue.depthLevel - 1) / ( RogueH.AMULET_LEVEL - 1), 0, 100);

			theProfile.roomFrequencies[0] += (short)(20 * (100 - descentPercent) / 100);
			theProfile.roomFrequencies[1] += (short)(10 * (100 - descentPercent) / 100);
			theProfile.roomFrequencies[3] += (short)( 7 * (100 - descentPercent) / 100);
			theProfile.roomFrequencies[5] += (short)(10 * descentPercent / 100);

			theProfile.corridorChance += (short)(80 * (100 - descentPercent) / 100);
		}

		void adjustDungeonFirstRoomProfileForDepth(dungeonProfile theProfile) {
			playerCharacter rogue = RogueMain.GetInstance().getRogue(); 

			short i;
			short descentPercent = (short) Random.clamp(100 * (rogue.depthLevel - 1) / (RogueH.AMULET_LEVEL - 1), 0, 100);

			if (rogue.depthLevel == 1) {
				// All dungeons start with the entrance room on depth 1.
				for (i = 0; i < RogueH.ROOM_TYPE_COUNT; i++) {
					theProfile.roomFrequencies[i] = 0;
				}
				theProfile.roomFrequencies[7] = 1;
			} else {
				theProfile.roomFrequencies[6] += (short)( 50 * descentPercent / 100 );
			}
		}

		void designCrossRoom(short[][] grid) {
			short roomWidth, roomHeight, roomWidth2, roomHeight2, roomX, roomY, roomX2, roomY2;

			Grid.fillGrid(grid, 0);

			roomWidth = rand_range(3, 12);
			roomX = rand_range( Math.Max(0, DCOLS/2 - (roomWidth - 1)), Math.Min(DCOLS, DCOLS/2));
			roomWidth2 = rand_range(4, 20);
			roomX2 = (short)((roomX + (roomWidth / 2) + rand_range(0, 2) + rand_range(0, 2) - 3) - (roomWidth2 / 2));

			roomHeight = rand_range(3, 7);
			roomY = (short)(DROWS/2 - roomHeight);

			roomHeight2 = rand_range(2, 5);
			roomY2 = (short)(DROWS/2 - roomHeight2 - (rand_range(0, 2) + rand_range(0, 1)));

			drawRectangleOnGrid(grid, roomX - 5, roomY + 5, roomWidth, roomHeight, 1);
			drawRectangleOnGrid(grid, roomX2 - 5, roomY2 + 5, roomWidth2, roomHeight2, 1);
		}

		void designSymmetricalCrossRoom(short[][] grid) {
			short majorWidth, majorHeight, minorWidth, minorHeight;

			Grid.fillGrid(grid, 0);

			majorWidth = rand_range(4, 8);
			majorHeight = rand_range(4, 5);

			minorWidth = rand_range(3, 4);
			if (majorHeight % 2 == 0) {
				minorWidth -= 1;
			}
			minorHeight = 3;//rand_range(2, 3);
			if (majorWidth % 2 == 0) {
				minorHeight -= 1;
			}

			drawRectangleOnGrid(grid, (DCOLS - majorWidth)/2, (DROWS - minorHeight)/2, majorWidth, minorHeight, 1);
			drawRectangleOnGrid(grid, (DCOLS - minorWidth)/2, (DROWS - majorHeight)/2, minorWidth, majorHeight, 1);
		}

		void designSmallRoom(short[][] grid) {
			short width, height;

			Grid.fillGrid(grid, 0);
			width = rand_range(3, 6);
			height = rand_range(2, 4);
			drawRectangleOnGrid(grid, (DCOLS - width) / 2, (DROWS - height) / 2, width, height, 1);
		}

		void designCircularRoom(short[][]grid) {
			short radius;

			if (rand_percent(5)) {
				radius = rand_range(4, 10);
			} else {
				radius = rand_range(2, 4);
			}

			Grid.fillGrid(grid, 0);
			drawCircleOnGrid(grid, DCOLS/2, DROWS/2, radius, 1);

			if (radius > 6
				&& rand_percent(50)) {
				drawCircleOnGrid(grid, DCOLS/2, DROWS/2, rand_range(3, radius - 3), 0);
			}
		}

		void designChunkyRoom(short[][] grid) {
			short i, x, y;
			short minX, maxX, minY, maxY;
			short chunkCount = rand_range(2, 8);

			Grid.fillGrid(grid, 0);
			drawCircleOnGrid(grid, DCOLS/2, DROWS/2, 2, 1);
			minX = DCOLS/2 - 3;
			maxX = DCOLS/2 + 3;
			minY = DROWS/2 - 3;
			maxY = DROWS/2 + 3;

			for (i=0; i<chunkCount;) {
				x = rand_range(minX, maxX);
				y = rand_range(minY, maxY);
				if (grid[x][y] !=0 ) {
					//            colorOverDungeon(&darkGray);
					//            hiliteGrid(grid, &white, 100);

					drawCircleOnGrid(grid, x, y, 2, 1);
					i++;
					minX = (short)Math.Max(1, Math.Min(x - 3, minX));
					maxX = (short)Math.Min(DCOLS - 2, Math.Max(x + 3, maxX));
					minY = (short)Math.Max(1, Math.Min(y - 3, minY));
					maxY = (short)Math.Min(DROWS - 2, Math.Max(y + 3, maxY));

					//            hiliteGrid(grid, &green, 50);
					//            temporaryMessage("Added a chunk:", true);
				}
			}
		}

		void designCavern(short[][] grid, short minWidth, short maxWidth, short minHeight, short maxHeight) {
			short destX, destY;
			short caveX, caveY, caveWidth, caveHeight;
			short fillX, fillY=0;
			bool foundFillPoint = false;
			short[][] blobGrid;
			blobGrid = Grid.allocGrid();

			Grid.fillGrid(grid, 0);
			createBlobOnGrid(blobGrid,
				out caveX, out caveY, out caveWidth, out caveHeight,
				5, minWidth, minHeight, maxWidth, maxHeight, 55, "ffffffttt".ToCharArray(), "ffffttttt".ToCharArray());

			//    colorOverDungeon(&darkGray);
			//    hiliteGrid(blobGrid, &tanColor, 80);
			//    temporaryMessage("Here's the cave:", true);

			// Position the new cave in the middle of the grid...
			destX = (short)((DCOLS - caveWidth) / 2);
			destY = (short)((DROWS - caveHeight) / 2);
			// ...pick a floodfill insertion point...
			for (fillX = 0; fillX < DCOLS && !foundFillPoint; fillX++) {
				for (fillY = 0; fillY < DROWS && !foundFillPoint; fillY++) {
					if (blobGrid[fillX][fillY]!=0) {
						foundFillPoint = true;
					}
				}
			}
			// ...and copy it to the master grid.
			insertRoomAt(grid, blobGrid, destX - caveX, destY - caveY, fillX, fillY);
			Grid.freeGrid(blobGrid);
		}


		void cellularAutomataRound(short[][] grid, char[] birthParameters , char[] survivalParameters ) {
			short i, j, nbCount, newX, newY;
			int dir;
			short [][] buffer2;

			buffer2 = Grid.allocGrid();
			Grid.copyGrid(buffer2, grid); // Make a backup of grid in buffer2, so that each generation is isolated.

			for(i=0; i<DCOLS; i++) {
				for(j=0; j<DROWS; j++) {
					nbCount = 0;
					for (dir=0; dir< RogueH.DIRECTION_COUNT; dir++) {
						newX = (short)( i + nbDirs[dir,0]);
						newY = (short)( j + nbDirs[dir,1]);
						if (IO.GetInstance().coordinatesAreInMap(newX, newY)
							&& buffer2[newX][newY]!=0) {

							nbCount++;
						}
					}
					if (buffer2[i][j]==0 && birthParameters[nbCount] == 't') {
						grid[i][j] = 1;	// birth
					} else if (buffer2[i][j]!=0 && survivalParameters[nbCount] == 't') {
						// survival
					} else {
						grid[i][j] = 0;	// death
					}
				}
			}

			Grid.freeGrid(buffer2);
		}

		// Loads up **grid with the results of a cellular automata simulation.
		void createBlobOnGrid(short [][]grid,
			out short retMinX, out short retMinY, out short retWidth, out short retHeight,
			short roundCount,
			short minBlobWidth, short minBlobHeight,
			short maxBlobWidth, short maxBlobHeight, short percentSeeded,
			char[] birthParameters, char[] survivalParameters) {

			short i, j, k;
			short blobNumber, blobSize, topBlobNumber, topBlobSize;

			short topBlobMinX, topBlobMinY, topBlobMaxX, topBlobMaxY, blobWidth, blobHeight;
			//short buffer2[maxBlobWidth][maxBlobHeight]; // buffer[][] is already a global short array
			bool foundACellThisLine;

			// Generate blobs until they satisfy the minBlobWidth and minBlobHeight restraints
			do {
				// Clear buffer.
				Grid.fillGrid(grid, 0);

				// Fill relevant portion with noise based on the percentSeeded argument.
				for(i=0; i<maxBlobWidth; i++) {
					for(j=0; j<maxBlobHeight; j++) {
						grid[i][j] = (short)(rand_percent(percentSeeded) ? 1 : 0);
					}
				}

				//        colorOverDungeon(&darkGray);
				//        hiliteGrid(grid, &white, 100);
				//        temporaryMessage("Random starting noise:", true);

				// Some iterations of cellular automata
				for (k=0; k<roundCount; k++) {
					cellularAutomataRound(grid, birthParameters, survivalParameters);

					//            colorOverDungeon(&darkGray);
					//            hiliteGrid(grid, &white, 100);
					//            temporaryMessage("Cellular automata progress:", true);
				}

				//        colorOverDungeon(&darkGray);
				//        hiliteGrid(grid, &white, 100);
				//        temporaryMessage("Cellular automata result:", true);

				// Now to measure the result. These are best-of variables; start them out at worst-case values.
				topBlobSize =   0;
				topBlobNumber = 0;
				topBlobMinX =   maxBlobWidth;
				topBlobMaxX =   0;
				topBlobMinY =   maxBlobHeight;
				topBlobMaxY =   0;

				// Fill each blob with its own number, starting with 2 (since 1 means floor), and keeping track of the biggest:
				blobNumber = 2;

				for(i=0; i<DCOLS; i++) {
					for(j=0; j<DROWS; j++) {
						if (grid[i][j] == 1) { // an unmarked blob
							// Mark all the cells and returns the total size:
							blobSize = Grid.fillContiguousRegion(grid, i, j, blobNumber);
							if (blobSize > topBlobSize) { // if this blob is a new record
								topBlobSize = blobSize;
								topBlobNumber = blobNumber;
							}
							blobNumber++;
						}
					}
				}

				// Figure out the top blob's height and width:
				// First find the max & min x:
				for(i=0; i<DCOLS; i++) {
					foundACellThisLine = false;
					for(j=0; j<DROWS; j++) {
						if (grid[i][j] == topBlobNumber) {
							foundACellThisLine = true;
							break;
						}
					}
					if (foundACellThisLine) {
						if (i < topBlobMinX) {
							topBlobMinX = i;
						}
						if (i > topBlobMaxX) {
							topBlobMaxX = i;
						}
					}
				}

				// Then the max & min y:
				for(j=0; j<DROWS; j++) {
					foundACellThisLine = false;
					for(i=0; i<DCOLS; i++) {
						if (grid[i][j] == topBlobNumber) {
							foundACellThisLine = true;
							break;
						}
					}
					if (foundACellThisLine) {
						if (j < topBlobMinY) {
							topBlobMinY = j;
						}
						if (j > topBlobMaxY) {
							topBlobMaxY = j;
						}
					}
				}

				blobWidth =	(short)(	(topBlobMaxX - topBlobMinX) + 1);
				blobHeight =(short)(	(topBlobMaxY - topBlobMinY) + 1);

			} while (blobWidth < minBlobWidth
				|| blobHeight < minBlobHeight
				|| topBlobNumber == 0);

			// Replace the winning blob with 1's, and everything else with 0's:
			for(i=0; i<DCOLS; i++) {
				for(j=0; j<DROWS; j++) {
					if (grid[i][j] == topBlobNumber) {
						grid[i][j] = 1;
					} else {
						grid[i][j] = 0;
					}
				}
			}

			// Populate the returned variables.
			retMinX = topBlobMinX;
			retMinY = topBlobMinY;
			retWidth = blobWidth;
			retHeight = blobHeight;
		}

		// This is a special room that appears at the entrance to the dungeon on depth 1.
		void designEntranceRoom(short[][] grid) {
			short roomWidth, roomHeight, roomWidth2, roomHeight2, roomX, roomY, roomX2, roomY2;

			Grid.fillGrid(grid, 0);

			roomWidth = 8;
			roomHeight = 10;
			roomWidth2 = 20;
			roomHeight2 = 5;
			roomX = (short)(DCOLS/2 - roomWidth/2 - 1);
			roomY = (short)(DROWS - roomHeight - 2);
			roomX2 = (short)(DCOLS/2 - roomWidth2/2 - 1);
			roomY2 = (short)(DROWS - roomHeight2 - 2);

			drawRectangleOnGrid(grid, roomX, roomY, roomWidth, roomHeight, 1);
			drawRectangleOnGrid(grid, roomX2, roomY2, roomWidth2, roomHeight2, 1);
		}


		// If the indicated tile [x][y] is a wall on the room stored in grid, and it could be the site of
		// a door out of that room, then return the outbound direction that the door faces.
		// Otherwise, return NO_DIRECTION.
		directions directionOfDoorSite(short[][] grid, int x, int y) {
			int dir;
			directions solutionDir;
			int newX, newY, oppX, oppY;

			if (grid[x][y]!=0) { // Already occupied
				return NO_DIRECTION;
			}

			solutionDir = NO_DIRECTION;
			for (dir=0; dir<4; dir++) {
				/*
				 *  eg. n|T|o
				 */

				newX = x + nbDirs[dir,0];
				newY = y + nbDirs[dir,1];
				oppX = x - nbDirs[dir,0];
				oppY = y - nbDirs[dir,1];
				if (IO.GetInstance().coordinatesAreInMap(oppX, oppY)
					&& IO.GetInstance().coordinatesAreInMap(newX, newY)
					// oppsite tile is floor, that is , tile [x][y] is the wall of room
					&& grid[oppX][oppY] == 1) {

					// This grid cell would be a valid tile on which to place a door that, facing outward, points dir.
					if (solutionDir != NO_DIRECTION) {
						// Already claimed by another direction; no doors here!
						// 发生这种情况  tile [x][y] 不在当前房间的墙上, 或者, 在墙角位置，也不能用来放置门
						return NO_DIRECTION;
					}
					solutionDir = (directions)dir;
				}
			}
			return solutionDir;
		}

		void chooseRandomDoorSites(short[][] roomMap, short[,] doorSites) { // doorSites [4][2]
			int i, j, k, newX, newY;
			int dir;
			short[][] grid;
			bool  doorSiteFailed;

			// 因为需要 临时记录 门的状态 dir+2
			// 所以使用一个新的 grid, 避免污染 roomMap
			grid = Grid. allocGrid();
			Grid.copyGrid(grid, roomMap);

			//    colorOverDungeon(&darkGray);
			//    hiliteGrid(grid, &blue, 100);
			//    temporaryMessage("Generating this room:", true);
			//    const char dirChars[] = "^v<>";

			for (i=0; i<DCOLS; i++) {
				for (j=0; j<DROWS; j++) {
					if (grid[i][j]==0) {
						// 这里是花岗岩

						// 检查这个位置是否可能用来放置门
						dir = (int)directionOfDoorSite(roomMap, i, j);
						if ( (directions)dir != NO_DIRECTION) {
							// Trace a ray 10 spaces outward from the door site to make sure it doesn't intersect the room.
							// If it does, it's not a valid door site.
							newX = i + nbDirs[(int)dir,0];
							newY = j + nbDirs[(int)dir,1];
							doorSiteFailed = false;
							for (k=0; k<10 && IO.GetInstance().coordinatesAreInMap(newX, newY) && !doorSiteFailed; k++) {
								if (grid[newX][newY]!=0) {
									doorSiteFailed = true;
								}
								newX += nbDirs[(int)dir,0];
								newY += nbDirs[(int)dir,1];
							}
							if (!doorSiteFailed) {
								//                        plotCharWithColor(dirChars[dir], mapToWindowX(i), mapToWindowY(j), &black, &green);
								grid[i][j] = (short)( dir + 2 ); // So as not to conflict with 0 or 1, which are used to indicate exterior/interior.
							}
						}
					}
				}
			}

			//    temporaryMessage("Door candidates:", true);

			// Pick four doors, one in each direction, and store them in doorSites[dir].
			for (dir=0; dir<4; dir++) {
				Grid.randomLocationInGrid(grid, out (doorSites[dir,0]), out (doorSites[dir,1]), (short)(dir + 2));
			}

			Grid.freeGrid(grid);
		}


		void attachHallwayTo(short[][] grid, short[,] doorSites ) {
			int  i, x, y, newX, newY;
			short []dirs = new short[4];
			short length;
			short dir=-1, dir2=-1;
			bool allowObliqueHallwayExit;

			// Pick a direction.
			Random.fillSequentialList(dirs, 4);
			Random.shuffleList(dirs, 4);
			for (i=0; i<4; i++) {
				dir = dirs[i];
				if (doorSites[dir,0] != -1
					&& doorSites[dir,1] != -1
					&& IO.GetInstance().coordinatesAreInMap(doorSites[dir,0] + nbDirs[dir,0] * HORIZONTAL_CORRIDOR_MAX_LENGTH,
						doorSites[dir,1] + nbDirs[dir,1] * VERTICAL_CORRIDOR_MAX_LENGTH)) {
					break; // That's our direction!
				}
			}
			if (i==4) {
				return; // No valid direction for hallways.
			}

			if ((directions)dir == UP || (directions)dir == DOWN) {
				length = rand_range(VERTICAL_CORRIDOR_MIN_LENGTH, VERTICAL_CORRIDOR_MAX_LENGTH);
			} else {
				length = rand_range(HORIZONTAL_CORRIDOR_MIN_LENGTH, HORIZONTAL_CORRIDOR_MAX_LENGTH);
			}

			// 从门的位置开始
			x = doorSites[dir,0];
			y = doorSites[dir,1];
			for (i = 0; i < length; i++) {
				// 这个条件判断 没意义？ 肯定ture吧
				if (coordinatesAreInMap(x, y)) {
					grid [x][y] = 1;// true;
				}
				x += nbDirs[dir,0];
				y += nbDirs[dir,1];
			}
			x = (int)Random.clamp(x - nbDirs[dir,0], 0, DCOLS - 1);
			y = (int)Random.clamp(y - nbDirs[dir,1], 0, DROWS - 1); // Now (x, y) points at the last interior cell of the hallway.
			allowObliqueHallwayExit = rand_percent(15);
			for (dir2 = 0; dir2 < 4; dir2++) {
				newX = x + nbDirs[dir2,0];
				newY = y + nbDirs[dir2,1];

				// 1. 如果不允许 不同方向的 走廊出口，则其他三个方向的门位置都 取消
				// 2. 新 门位置超出地图， 取消
				// 3. 新 门位置 不是 花岗岩，取消
				if ((dir2 != dir && !allowObliqueHallwayExit)
					|| !coordinatesAreInMap(newX, newY)
					|| grid[newX][newY]!=0 ) {

					doorSites[dir2,0] = -1;
					doorSites[dir2,1] = -1;
				} else {
					doorSites[dir2,0] = (short)newX;
					doorSites[dir2,1] = (short)newY;
				}
			}
		}


		// Put a random room shape somewhere on the binary grid,
		// and optionally record the coordinates of up to four door sites in doorSites.
		// If attachHallway is true, then it will bolt a perpendicular hallway onto the room at one of the four standard door sites,
		// and then relocate three of the door sites to radiate from the end of the hallway. (The fourth is defunct.)
		// RoomTypeFrequencies specifies the probability of each room type, in the following order:
		//      0. Cross room
		//      1. Small symmetrical cross room
		//      2. Small room
		//      3. Circular room
		//      4. Chunky room
		//      5. Cave
		//      6. Cavern (the kind that fills a level)
		//      7. Entrance room (the big upside-down T room at the start of depth 1)

		void designRandomRoom(short[][] grid, bool  attachHallway, short[,] doorSites,
			short[] roomTypeFrequencies) 
		{
			short randIndex, i, sum;
			int dir;

			sum = 0;
			for (i=0; i<  ROOM_TYPE_COUNT; i++) {
				sum += roomTypeFrequencies[i];
			}
			randIndex = rand_range(0, sum - 1);
			for (i=0; i<ROOM_TYPE_COUNT; i++) {
				if (randIndex < roomTypeFrequencies[i]) {
					break; // "i" is our room type.
				} else {
					randIndex -= roomTypeFrequencies[i];
				}
			}
			switch (i) {
			case 0:
				designCrossRoom(grid);
				break;
			case 1:
				designSymmetricalCrossRoom(grid);
				break;
			case 2:
				designSmallRoom(grid);
				break;
			case 3:
				designCircularRoom(grid);
				break;
			case 4:
				designChunkyRoom(grid);
				break;
			case 5:
				switch (rand_range(0, 2)) {
				case 0:
					designCavern(grid, 3, 12, 4, 8); // Compact cave room.
					break;
				case 1:
					designCavern(grid, 3, 12, 15, DROWS-2); // Large north-south cave room.
					break;
				case 2:
					designCavern(grid, 20, DROWS-2, 4, 8); // Large east-west cave room.
					break;
				default:
					break;
				}
				break;
			case 6:
				designCavern(grid, CAVE_MIN_WIDTH, DCOLS - 2, CAVE_MIN_HEIGHT, DROWS - 2);
				break;
			case 7:
				designEntranceRoom(grid);
				break;
			default:
				break;
			}

			if (doorSites != null ) {
				chooseRandomDoorSites(grid, doorSites);
				if (attachHallway) {
					// 下面的代码没用，并且这种实现 不随机
					dir =  rand_range(0, 3);
					for (i=0; doorSites[(int)dir,0] == -1 && i < 3; i++) {
						dir = (dir + 1) % 4; // Each room will have at least 2 valid directions for doors.
					}
					// end 无用代码
					attachHallwayTo(grid, doorSites);
				}
			}
		}

		void attachRooms(short[][] grid,   dungeonProfile theDP, short attempts, short maxRoomCount) {
			short roomsBuilt, roomsAttempted;
			short[][] roomMap;
			short [,] doorSites = new short[4,2];
			short i, x, y;
			short [] sCoord = new short[DCOLS*DROWS];
			directions dir, oppDir;

			Random.fillSequentialList(sCoord, DCOLS*DROWS);
			Random.shuffleList(sCoord, DCOLS*DROWS);

			roomMap = Grid.allocGrid();
			for (roomsBuilt = roomsAttempted = 0; roomsBuilt < maxRoomCount && roomsAttempted < attempts; roomsAttempted++) {
				// Build a room in hyperspace.
				Grid.fillGrid(roomMap, 0);
				// 最后5次尝试，不生成 走廊
				designRandomRoom(roomMap, roomsAttempted <= attempts - 5 && rand_percent(theDP.corridorChance),
					doorSites, theDP.roomFrequencies);

				if (D_INSPECT_LEVELGEN) {
					IO.GetInstance().colorOverDungeon(Global.darkGray);
					Grid.GetInstance().hiliteGrid(roomMap, Global.blue, 100);
					if (doorSites[0,0] != -1) IO.GetInstance().plotCharWithColor('^', mapToWindowX(doorSites[0,0]), mapToWindowY(doorSites[0,1]), Global.black, Global.green);
					if (doorSites[1,0] != -1) IO.GetInstance().plotCharWithColor('v', mapToWindowX(doorSites[1,0]), mapToWindowY(doorSites[1,1]), Global.black, Global.green);
					if (doorSites[2,0] != -1) IO.GetInstance().plotCharWithColor('<', mapToWindowX(doorSites[2,0]), mapToWindowY(doorSites[2,1]), Global.black, Global.green);
					if (doorSites[3,0] != -1) IO.GetInstance().plotCharWithColor('>', mapToWindowX(doorSites[3,0]), mapToWindowY(doorSites[3,1]), Global.black, Global.green);

					IO.temporaryMessage("Generating this room:", true);
				}

				// Slide hyperspace across real space, in a random but predetermined order, until the room matches up with a wall.
				for (i = 0; i < DCOLS*DROWS; i++) {
					x = (short)(sCoord[i] / DROWS);
					y = (short)(sCoord[i] % DROWS);

					dir = directionOfDoorSite(grid, x, y);
					oppDir = (directions)oppositeDirection( (short)dir);
					if (
						// 这个位置可以放 方向dir的门
						dir != NO_DIRECTION
						// 要 attach的房间 有 方向oppDir的门
						&& doorSites[(int)oppDir,0] != -1
						// roomMap 可以放到 （x - doorSites[(int)oppDir,0], y - doorSites[(int)oppDir,1] 位置）
						&& roomFitsAt(grid, roomMap, x - doorSites[(int)oppDir,0], y - doorSites[(int)oppDir,1])  ) {

						// Room fits here.
						if (D_INSPECT_LEVELGEN) {
							IO.GetInstance().colorOverDungeon(Global.darkGray);
							Grid.GetInstance().hiliteGrid(grid, Global.white, 100);
						}
						insertRoomAt(grid, roomMap, x - doorSites[(int)oppDir,0], y - doorSites[(int)oppDir,1], 
													    doorSites[(int)oppDir,0],     doorSites[(int)oppDir,1]);
						grid[x][y] = 2; // Door site.
						if (D_INSPECT_LEVELGEN) {
							Grid.GetInstance().hiliteGrid(grid, Global.green, 50);
							IO.temporaryMessage("Added room.", true);
						}
						roomsBuilt++;
						break;
					}
				}
			}

			Grid.freeGrid(roomMap);
		}

		public void insertRoomAt(short[][] dungeonMap, short[][] roomMap,   int roomToDungeonX,   int roomToDungeonY,   int xRoom,   int yRoom) {
			int newX, newY;
			int dir;

			RogueMain.brogueAssert( IO.GetInstance().coordinatesAreInMap(xRoom + roomToDungeonX, yRoom + roomToDungeonY));

			// 门的位置 先 标记为 1
			dungeonMap[xRoom + roomToDungeonX][yRoom + roomToDungeonY] = 1;
			for (dir = 0; dir < 4; dir++) {
				newX = xRoom + nbDirs[dir,0];
				newY = yRoom + nbDirs[dir,1];
				if ( IO.GetInstance().coordinatesAreInMap(newX, newY)
					&& roomMap[newX][newY] !=0
					&& IO.GetInstance().coordinatesAreInMap(newX + roomToDungeonX, newY + roomToDungeonY)
					&& dungeonMap[newX + roomToDungeonX][newY + roomToDungeonY] == 0) {

					insertRoomAt(dungeonMap, roomMap, roomToDungeonX, roomToDungeonY, newX, newY);
				}
			}
		}

		bool roomFitsAt(short[][] dungeonMap, short[][] roomMap, int roomToDungeonX, int roomToDungeonY) {
			int xRoom, yRoom, xDungeon, yDungeon, i, j;

			for (xRoom = 0; xRoom < DCOLS; xRoom++) {
				for (yRoom = 0; yRoom < DROWS; yRoom++) {
					// 测试 新room
					if (roomMap[xRoom][yRoom]!=0) {
						xDungeon = xRoom + roomToDungeonX;
						yDungeon = yRoom + roomToDungeonY;

						for (i = xDungeon - 1; i <= xDungeon + 1; i++) {
							for (j = yDungeon - 1; j <= yDungeon + 1; j++) {
								if (!coordinatesAreInMap(i, j)
									|| dungeonMap[i][j] > 0) {
									return false;
								}
							}
						}
					}
				}
			}
			return true;
		}

		// Called by digDungeon().
		// Slaps a bunch of rooms and hallways into the grid.
		// On the grid, a 0 denotes granite, a 1 denotes floor, and a 2 denotes a possible door site.
		// -1 denotes off-limits areas -- rooms can't be placed there and also can't sprout off of there.
		// Parent function will translate this grid into pmap[][] to make floors, walls, doors, etc.
		void carveDungeon(short[][] grid) {
			dungeonProfile theDP = new dungeonProfile() , theFirstRoomDP = new dungeonProfile() ;

			ObjectCopier.CopyFrom( theDP , dungeonProfileCatalog[DP_BASIC] );
			adjustDungeonProfileForDepth(theDP);

			ObjectCopier.CopyFrom( theFirstRoomDP , dungeonProfileCatalog[DP_BASIC_FIRST_ROOM] );
			adjustDungeonFirstRoomProfileForDepth(theFirstRoomDP);


			designRandomRoom(grid, false, null, theFirstRoomDP.roomFrequencies);

			if (D_INSPECT_LEVELGEN) {
				IO.GetInstance().colorOverDungeon(Global.darkGray);

				Grid.GetInstance().hiliteGrid(grid, Global. white, 100);
				IO.temporaryMessage("First room placed:", true);

			}

			attachRooms(grid, theDP, 35, 35);

			//    colorOverDungeon(&darkGray);
			//    hiliteGrid(grid, &white, 100);
			//    temporaryMessage("How does this finished level look?", true);
		}

		// Add some loops to the otherwise simply connected network of rooms.
		void addLoops(short[][] grid, short minimumPathingDistance) {
			int newX, newY, oppX, oppY;
			short [][]pathMap, costMap;
			int i, d, x, y;
			short []sCoord = new short[DCOLS*DROWS];
			short [,]dirCoords  = {{1, 0}, {0, 1}};

			Random.fillSequentialList(sCoord, DCOLS*DROWS);
			Random.shuffleList(sCoord, DCOLS*DROWS);

			if (D_INSPECT_LEVELGEN) {
				IO.GetInstance().colorOverDungeon(Global.darkGray);
				Grid.GetInstance().hiliteGrid(grid, Global.white, 100);
			}

			pathMap = Grid.allocGrid();
			costMap = Grid.allocGrid();
			Grid.copyGrid(costMap, grid);
			Grid.findReplaceGrid(costMap, 0, 0, RogueH. PDS_OBSTRUCTION);
			Grid.findReplaceGrid(costMap, 1, 30000, 1);

			for (i = 0; i < DCOLS*DROWS; i++) {
				x = sCoord[i]/DROWS;
				y = sCoord[i] % DROWS;
				if (grid[x][y]==0) {
					for (d=0; d <= 1; d++) { // Try a horizontal door, and then a vertical door.
						newX = x + dirCoords[d,0];
						oppX = x - dirCoords[d,0];
						newY = y + dirCoords[d,1];
						oppY = y - dirCoords[d,1];
						if (coordinatesAreInMap(newX, newY)
							&& coordinatesAreInMap(oppX, oppY)
							&& grid[newX][newY] > 0
							&& grid[oppX][oppY] > 0) { // If the tile being inspected has floor on both sides,

							Grid.fillGrid(pathMap, 30000);
							pathMap[newX][newY] = 0;
							//dijkstraScan(pathMap, costMap, false);
							if (pathMap[oppX][oppY] > minimumPathingDistance) { // and if the pathing distance between the two flanking floor tiles exceeds minimumPathingDistance,
								grid[x][y] = 2;             // then turn the tile into a doorway.
								costMap[x][y] = 1;          // (Cost map also needs updating.)
								if (D_INSPECT_LEVELGEN) {
									IO.GetInstance().plotCharWithColor( Global.DOOR_CHAR, mapToWindowX(x), mapToWindowY(y), Global.black, Global.green);
								}
								break;
							}
						}
					}
				}
			}
			if (D_INSPECT_LEVELGEN) {
				IO.temporaryMessage("Added secondary connections:", true);
			}
			Grid.freeGrid(pathMap);
			Grid.freeGrid(costMap);
		}

		// This is the master function for digging out a dungeon level.
		// Finishing touches -- items, monsters, staircases, etc. -- are handled elsewhere.
		public void digDungeon() {
			playerCharacter rogue = RogueMain.GetInstance().getRogue(); 

			short i, j;
		    
		    short[][] grid;
			
			rogue.machineNumber = 0;
			
			topBlobMinX = topBlobMinY = blobWidth = blobHeight = 0;

			// Clear level and fill with granite
			clearLevel();
		    
		    grid = Grid.allocGrid();
		    carveDungeon(grid);
		    addLoops(grid, 20);
		    for (i=0; i<DCOLS; i++) {
		        for (j=0; j<DROWS; j++) {
		            if (grid[i][j] == 1) {
		                pmap[i,j].layers[DUNGEON] = FLOOR;
		            } else if (grid[i][j] == 2) {
						pmap[i,j].layers[DUNGEON] = (rand_percent(60) && rogue.depthLevel < RogueH. DEEPEST_LEVEL ? DOOR : FLOOR);
		            }
		        }
		    }
		    Grid.freeGrid(grid);
		    /*
		    finishWalls(false);
			
			if (D_INSPECT_LEVELGEN) {
				dumpLevelToScreen();
		        IO.temporaryMessage("Carved into the granite:", true);
			}
			//DEBUG printf("\n%i loops created.", numLoops);
			//DEBUG logLevel();
			
			// Time to add lakes and chasms. Strategy is to generate a series of blob lakes of decreasing size. For each lake,
			// propose a position, and then check via a flood fill that the level would remain connected with that placement (i.e. that
			// each passable tile can still be reached). If not, make 9 more placement attempts before abandoning that lake
			// and proceeding to generate the next smaller one.
			// Canvas sizes start at 30x15 and decrease by 2x1 at a time down to a minimum of 20x10. Min generated size is always 4x4.
			
			// DEBUG logLevel();
			
			// Now design the lakes and then fill them with various liquids (lava, water, chasm, brimstone).
		    short **lakeMap = allocGrid();
			designLakes(lakeMap);
			fillLakes(lakeMap);
		    freeGrid(lakeMap);
			
			// Run the non-machine autoGenerators.
			runAutogenerators(false);
			
			// Remove diagonal openings.
			removeDiagonalOpenings();
			
			if (D_INSPECT_LEVELGEN) {
				dumpLevelToScreen();
				temporaryMessage("Diagonal openings removed.", true);
			}
			
			// Now add some treasure machines.
			addMachines();
			
			if (D_INSPECT_LEVELGEN) {
				dumpLevelToScreen();
				temporaryMessage("Machines added.", true);
			}
		    
			// Run the machine autoGenerators.
			runAutogenerators(true);
			
			// Now knock down the boundaries between similar lakes where possible.
			cleanUpLakeBoundaries();
			
			if (D_INSPECT_LEVELGEN) {
				dumpLevelToScreen();
				temporaryMessage("Lake boundaries cleaned up.", true);
			}
			
			// Now add some bridges.
			while (buildABridge());
			
			if (D_INSPECT_LEVELGEN) {
				dumpLevelToScreen();
				temporaryMessage("Bridges added.", true);
			}
		    
			// Now remove orphaned doors and upgrade some doors to secret doors
		    finishDoors();
			
			// Now finish any exposed granite with walls and revert any unexposed walls to granite
			finishWalls(true);
			
			if (D_INSPECT_LEVELGEN) {
				dumpLevelToScreen();
				temporaryMessage("Finishing touches added. Level has been generated.", true);
			}
			//*/
		}


		public static short oppositeDirection(short theDir) {
			switch ( (directions)theDir) {
			case UP:
				return (short)DOWN;
			case DOWN:
				return (short)UP;
			case LEFT:
				return (short)RIGHT;
			case RIGHT:
				return (short)LEFT;
			case UPRIGHT:
				return (short)DOWNLEFT;
			case DOWNLEFT:
				return (short)UPRIGHT;
			case UPLEFT:
				return (short)DOWNRIGHT;
			case DOWNRIGHT:
				return (short)UPLEFT;
			case NO_DIRECTION:
				return (short)NO_DIRECTION;
			default:
				return (short)-1;
			}
		}

		//---------------
		//---------------
		short rand_range( int lower , int upper) {
			int result =  Random.rand_range (lower, upper);

			//Debug.Log ( string.Format("randdome between {0}-{1}: {2} " , lower, upper , result) );
			return (short)result;
		}

		void drawRectangleOnGrid(short [][]grid, int x, int y, int width, int height, short value) {
			Grid.drawRectangleOnGrid ( grid, x, y, width, height, value );
		}

		void drawCircleOnGrid(short[][] grid, int x, int y, int radius, short value) {
			Grid.drawCircleOnGrid( grid, x, y, radius, value) ;
		}

		bool rand_percent(short percent) {
			return Random.rand_percent ( percent );

		}

		bool coordinatesAreInMap(int x, int y) 
		{
			return IO.GetInstance().coordinatesAreInMap( x, y) ;
		}

		int mapToWindowX(int x)						
		{ 
			return IO.GetInstance ().mapToWindowX (x);
		}

		int mapToWindowY( int y)
		{
			return IO.GetInstance ().mapToWindowY( y);
		}
	}
}

