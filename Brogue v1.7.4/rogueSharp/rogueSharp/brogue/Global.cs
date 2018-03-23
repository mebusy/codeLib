#define USE_UNICODE

using System;

namespace rogueSharp
{
	public class Global : Singleton<Global>
	{
		private Global ()
		{
			Debug.Log ( "~~~~ Global initialized" );
		}

		public const int DCOLS = RogueH.DCOLS;
		public const int DROWS = RogueH.DROWS;

		const int NUMBER_POTION_KINDS = (int)potionKind.NUMBER_POTION_KINDS ;
		const int NUMBER_STAFF_KINDS = (int)staffKind.NUMBER_STAFF_KINDS ;
		const int NUMBER_WAND_KINDS = (int)wandKind.NUMBER_WAND_KINDS ;
		const int NUMBER_SCROLL_KINDS = (int)scrollKind.NUMBER_SCROLL_KINDS ;
		const int NUMBER_RING_KINDS = (int)ringKind.NUMBER_RING_KINDS ;

		const int NUMBER_ITEM_COLORS = RogueH.NUMBER_ITEM_COLORS ;
		const int NUMBER_ITEM_WOODS = RogueH.NUMBER_ITEM_WOODS ;
		const int NUMBER_ITEM_GEMS = RogueH.NUMBER_ITEM_GEMS ;
		const int NUMBER_ITEM_METALS = RogueH.NUMBER_ITEM_METALS ;

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


		public const dungeonLayers NO_LAYER = dungeonLayers.NO_LAYER;
		public const dungeonLayers DUNGEON = dungeonLayers.DUNGEON;		// dungeon-level tile	(e.g. walls)
		public const dungeonLayers LIQUID = dungeonLayers.LIQUID ;				// liquid-level tile	(e.g. lava)
		public const dungeonLayers GAS = dungeonLayers.GAS ;				// gas-level tile		(e.g. fire, smoke, swamp gas)
		public const dungeonLayers SURFACE = dungeonLayers.SURFACE ;			// surface-level tile	(e.g. grass)
		public const int NUMBER_TERRAIN_LAYERS = (int)dungeonLayers.NUMBER_TERRAIN_LAYERS ;	


		public const dungeonFeatureTypes DF_GRANITE_COLUMN = dungeonFeatureTypes.DF_GRANITE_COLUMN ;
		public const dungeonFeatureTypes DF_CRYSTAL_WALL = dungeonFeatureTypes.DF_CRYSTAL_WALL ;
		public const dungeonFeatureTypes DF_LUMINESCENT_FUNGUS = dungeonFeatureTypes.DF_LUMINESCENT_FUNGUS ;
		public const dungeonFeatureTypes DF_GRASS = dungeonFeatureTypes.DF_GRASS ;
		public const dungeonFeatureTypes DF_DEAD_GRASS = dungeonFeatureTypes.DF_DEAD_GRASS ;
		public const dungeonFeatureTypes DF_BONES = dungeonFeatureTypes.DF_BONES ;
		public const dungeonFeatureTypes DF_RUBBLE = dungeonFeatureTypes.DF_RUBBLE ;
		public const dungeonFeatureTypes DF_FOLIAGE = dungeonFeatureTypes.DF_FOLIAGE ;
		public const dungeonFeatureTypes DF_FUNGUS_FOREST = dungeonFeatureTypes.DF_FUNGUS_FOREST ;
		public const dungeonFeatureTypes DF_DEAD_FOLIAGE = dungeonFeatureTypes.DF_DEAD_FOLIAGE ;
		public const dungeonFeatureTypes DF_SUNLIGHT = dungeonFeatureTypes.DF_SUNLIGHT ;
		public const dungeonFeatureTypes DF_DARKNESS = dungeonFeatureTypes.DF_DARKNESS ;
		public const dungeonFeatureTypes DF_SHOW_DOOR = dungeonFeatureTypes.DF_SHOW_DOOR ;
		public const dungeonFeatureTypes DF_SHOW_POISON_GAS_TRAP = dungeonFeatureTypes.DF_SHOW_POISON_GAS_TRAP ;
		public const dungeonFeatureTypes DF_SHOW_PARALYSIS_GAS_TRAP = dungeonFeatureTypes.DF_SHOW_PARALYSIS_GAS_TRAP ;
		public const dungeonFeatureTypes DF_SHOW_TRAPDOOR_HALO = dungeonFeatureTypes.DF_SHOW_TRAPDOOR_HALO ;
		public const dungeonFeatureTypes DF_SHOW_TRAPDOOR = dungeonFeatureTypes.DF_SHOW_TRAPDOOR ;
		public const dungeonFeatureTypes DF_SHOW_CONFUSION_GAS_TRAP = dungeonFeatureTypes.DF_SHOW_CONFUSION_GAS_TRAP ;
		public const dungeonFeatureTypes DF_SHOW_FLAMETHROWER_TRAP = dungeonFeatureTypes.DF_SHOW_FLAMETHROWER_TRAP ;
		public const dungeonFeatureTypes DF_SHOW_FLOOD_TRAP = dungeonFeatureTypes.DF_SHOW_FLOOD_TRAP ;
		public const dungeonFeatureTypes DF_SHOW_NET_TRAP = dungeonFeatureTypes.DF_SHOW_NET_TRAP ;
		public const dungeonFeatureTypes DF_SHOW_ALARM_TRAP = dungeonFeatureTypes.DF_SHOW_ALARM_TRAP ;
		public const dungeonFeatureTypes DF_RED_BLOOD = dungeonFeatureTypes.DF_RED_BLOOD ;
		public const dungeonFeatureTypes DF_GREEN_BLOOD = dungeonFeatureTypes.DF_GREEN_BLOOD ;
		public const dungeonFeatureTypes DF_PURPLE_BLOOD = dungeonFeatureTypes.DF_PURPLE_BLOOD ;
		public const dungeonFeatureTypes DF_WORM_BLOOD = dungeonFeatureTypes.DF_WORM_BLOOD ;
		public const dungeonFeatureTypes DF_ACID_BLOOD = dungeonFeatureTypes.DF_ACID_BLOOD ;
		public const dungeonFeatureTypes DF_ASH_BLOOD = dungeonFeatureTypes.DF_ASH_BLOOD ;
		public const dungeonFeatureTypes DF_EMBER_BLOOD = dungeonFeatureTypes.DF_EMBER_BLOOD ;
		public const dungeonFeatureTypes DF_ECTOPLASM_BLOOD = dungeonFeatureTypes.DF_ECTOPLASM_BLOOD ;
		public const dungeonFeatureTypes DF_RUBBLE_BLOOD = dungeonFeatureTypes.DF_RUBBLE_BLOOD ;
		public const dungeonFeatureTypes DF_ROT_GAS_BLOOD = dungeonFeatureTypes.DF_ROT_GAS_BLOOD ;
		public const dungeonFeatureTypes DF_VOMIT = dungeonFeatureTypes.DF_VOMIT ;
		public const dungeonFeatureTypes DF_BLOAT_DEATH = dungeonFeatureTypes.DF_BLOAT_DEATH ;
		public const dungeonFeatureTypes DF_BLOAT_EXPLOSION = dungeonFeatureTypes.DF_BLOAT_EXPLOSION ;
		public const dungeonFeatureTypes DF_BLOOD_EXPLOSION = dungeonFeatureTypes.DF_BLOOD_EXPLOSION ;
		public const dungeonFeatureTypes DF_FLAMEDANCER_CORONA = dungeonFeatureTypes.DF_FLAMEDANCER_CORONA ;
		public const dungeonFeatureTypes DF_MUTATION_EXPLOSION = dungeonFeatureTypes.DF_MUTATION_EXPLOSION ;
		public const dungeonFeatureTypes DF_MUTATION_LICHEN = dungeonFeatureTypes.DF_MUTATION_LICHEN ;
		public const dungeonFeatureTypes DF_REPEL_CREATURES = dungeonFeatureTypes.DF_REPEL_CREATURES ;
		public const dungeonFeatureTypes DF_ROT_GAS_PUFF = dungeonFeatureTypes.DF_ROT_GAS_PUFF ;
		public const dungeonFeatureTypes DF_STEAM_PUFF = dungeonFeatureTypes.DF_STEAM_PUFF ;
		public const dungeonFeatureTypes DF_STEAM_ACCUMULATION = dungeonFeatureTypes.DF_STEAM_ACCUMULATION ;
		public const dungeonFeatureTypes DF_METHANE_GAS_PUFF = dungeonFeatureTypes.DF_METHANE_GAS_PUFF ;
		public const dungeonFeatureTypes DF_SALAMANDER_FLAME = dungeonFeatureTypes.DF_SALAMANDER_FLAME ;
		public const dungeonFeatureTypes DF_URINE = dungeonFeatureTypes.DF_URINE ;
		public const dungeonFeatureTypes DF_UNICORN_POOP = dungeonFeatureTypes.DF_UNICORN_POOP ;
		public const dungeonFeatureTypes DF_PUDDLE = dungeonFeatureTypes.DF_PUDDLE ;
		public const dungeonFeatureTypes DF_ASH = dungeonFeatureTypes.DF_ASH ;
		public const dungeonFeatureTypes DF_ECTOPLASM_DROPLET = dungeonFeatureTypes.DF_ECTOPLASM_DROPLET ;
		public const dungeonFeatureTypes DF_FORCEFIELD = dungeonFeatureTypes.DF_FORCEFIELD ;
		public const dungeonFeatureTypes DF_FORCEFIELD_MELT = dungeonFeatureTypes.DF_FORCEFIELD_MELT ;
		public const dungeonFeatureTypes DF_SACRED_GLYPHS = dungeonFeatureTypes.DF_SACRED_GLYPHS ;
		public const dungeonFeatureTypes DF_LICHEN_GROW = dungeonFeatureTypes.DF_LICHEN_GROW ;
		public const dungeonFeatureTypes DF_TUNNELIZE = dungeonFeatureTypes.DF_TUNNELIZE ;
		public const dungeonFeatureTypes DF_SHATTERING_SPELL = dungeonFeatureTypes.DF_SHATTERING_SPELL ;

		// spiderwebs
		public const dungeonFeatureTypes DF_WEB_SMALL = dungeonFeatureTypes.DF_WEB_SMALL ;
		public const dungeonFeatureTypes DF_WEB_LARGE = dungeonFeatureTypes.DF_WEB_LARGE ;

		// ancient spirit
		public const dungeonFeatureTypes DF_ANCIENT_SPIRIT_VINES = dungeonFeatureTypes.DF_ANCIENT_SPIRIT_VINES ;
		public const dungeonFeatureTypes DF_ANCIENT_SPIRIT_GRASS = dungeonFeatureTypes.DF_ANCIENT_SPIRIT_GRASS ;

		// foliage
		public const dungeonFeatureTypes DF_TRAMPLED_FOLIAGE = dungeonFeatureTypes.DF_TRAMPLED_FOLIAGE ;
		public const dungeonFeatureTypes DF_SMALL_DEAD_GRASS = dungeonFeatureTypes.DF_SMALL_DEAD_GRASS ;
		public const dungeonFeatureTypes DF_FOLIAGE_REGROW = dungeonFeatureTypes.DF_FOLIAGE_REGROW ;
		public const dungeonFeatureTypes DF_TRAMPLED_FUNGUS_FOREST = dungeonFeatureTypes.DF_TRAMPLED_FUNGUS_FOREST ;
		public const dungeonFeatureTypes DF_FUNGUS_FOREST_REGROW = dungeonFeatureTypes.DF_FUNGUS_FOREST_REGROW ;

		// brimstone
		public const dungeonFeatureTypes DF_ACTIVE_BRIMSTONE = dungeonFeatureTypes.DF_ACTIVE_BRIMSTONE ;
		public const dungeonFeatureTypes DF_INERT_BRIMSTONE = dungeonFeatureTypes.DF_INERT_BRIMSTONE ;

		// bloodwort
		public const dungeonFeatureTypes DF_BLOODFLOWER_PODS_GROW_INITIAL = dungeonFeatureTypes.DF_BLOODFLOWER_PODS_GROW_INITIAL ;
		public const dungeonFeatureTypes DF_BLOODFLOWER_PODS_GROW = dungeonFeatureTypes.DF_BLOODFLOWER_PODS_GROW ;
		public const dungeonFeatureTypes DF_BLOODFLOWER_POD_BURST = dungeonFeatureTypes.DF_BLOODFLOWER_POD_BURST ;

		// dewars
		public const dungeonFeatureTypes DF_DEWAR_CAUSTIC = dungeonFeatureTypes.DF_DEWAR_CAUSTIC ;
		public const dungeonFeatureTypes DF_DEWAR_CONFUSION = dungeonFeatureTypes.DF_DEWAR_CONFUSION ;
		public const dungeonFeatureTypes DF_DEWAR_PARALYSIS = dungeonFeatureTypes.DF_DEWAR_PARALYSIS ;
		public const dungeonFeatureTypes DF_DEWAR_METHANE = dungeonFeatureTypes.DF_DEWAR_METHANE ;
		public const dungeonFeatureTypes DF_DEWAR_GLASS = dungeonFeatureTypes.DF_DEWAR_GLASS ;
		public const dungeonFeatureTypes DF_CARPET_AREA = dungeonFeatureTypes.DF_CARPET_AREA ;

		// algae
		public const dungeonFeatureTypes DF_BUILD_ALGAE_WELL = dungeonFeatureTypes.DF_BUILD_ALGAE_WELL ;
		public const dungeonFeatureTypes DF_ALGAE_1 = dungeonFeatureTypes.DF_ALGAE_1 ;
		public const dungeonFeatureTypes DF_ALGAE_2 = dungeonFeatureTypes.DF_ALGAE_2 ;
		public const dungeonFeatureTypes DF_ALGAE_REVERT = dungeonFeatureTypes.DF_ALGAE_REVERT ;
		public const dungeonFeatureTypes DF_OPEN_DOOR = dungeonFeatureTypes.DF_OPEN_DOOR ;
		public const dungeonFeatureTypes DF_CLOSED_DOOR = dungeonFeatureTypes.DF_CLOSED_DOOR ;
		public const dungeonFeatureTypes DF_OPEN_IRON_DOOR_INERT = dungeonFeatureTypes.DF_OPEN_IRON_DOOR_INERT ;
		public const dungeonFeatureTypes DF_ITEM_CAGE_OPEN = dungeonFeatureTypes.DF_ITEM_CAGE_OPEN ;
		public const dungeonFeatureTypes DF_ITEM_CAGE_CLOSE = dungeonFeatureTypes.DF_ITEM_CAGE_CLOSE ;
		public const dungeonFeatureTypes DF_ALTAR_INERT = dungeonFeatureTypes.DF_ALTAR_INERT ;
		public const dungeonFeatureTypes DF_ALTAR_RETRACT = dungeonFeatureTypes.DF_ALTAR_RETRACT ;
		public const dungeonFeatureTypes DF_PORTAL_ACTIVATE = dungeonFeatureTypes.DF_PORTAL_ACTIVATE ;
		public const dungeonFeatureTypes DF_INACTIVE_GLYPH = dungeonFeatureTypes.DF_INACTIVE_GLYPH ;
		public const dungeonFeatureTypes DF_ACTIVE_GLYPH = dungeonFeatureTypes.DF_ACTIVE_GLYPH ;
		public const dungeonFeatureTypes DF_SILENT_GLYPH_GLOW = dungeonFeatureTypes.DF_SILENT_GLYPH_GLOW ;
		public const dungeonFeatureTypes DF_GUARDIAN_STEP = dungeonFeatureTypes.DF_GUARDIAN_STEP ;
		public const dungeonFeatureTypes DF_MIRROR_TOTEM_STEP = dungeonFeatureTypes.DF_MIRROR_TOTEM_STEP ;
		public const dungeonFeatureTypes DF_GLYPH_CIRCLE = dungeonFeatureTypes.DF_GLYPH_CIRCLE ;
		public const dungeonFeatureTypes DF_REVEAL_LEVER = dungeonFeatureTypes.DF_REVEAL_LEVER ;
		public const dungeonFeatureTypes DF_PULL_LEVER = dungeonFeatureTypes.DF_PULL_LEVER ;
		public const dungeonFeatureTypes DF_CREATE_LEVER = dungeonFeatureTypes.DF_CREATE_LEVER ;
		public const dungeonFeatureTypes DF_BRIDGE_FALL_PREP = dungeonFeatureTypes.DF_BRIDGE_FALL_PREP ;
		public const dungeonFeatureTypes DF_BRIDGE_FALL = dungeonFeatureTypes.DF_BRIDGE_FALL ;
		public const dungeonFeatureTypes DF_PLAIN_FIRE = dungeonFeatureTypes.DF_PLAIN_FIRE ;
		public const dungeonFeatureTypes DF_GAS_FIRE = dungeonFeatureTypes.DF_GAS_FIRE ;
		public const dungeonFeatureTypes DF_EXPLOSION_FIRE = dungeonFeatureTypes.DF_EXPLOSION_FIRE ;
		public const dungeonFeatureTypes DF_DART_EXPLOSION = dungeonFeatureTypes.DF_DART_EXPLOSION ;
		public const dungeonFeatureTypes DF_BRIMSTONE_FIRE = dungeonFeatureTypes.DF_BRIMSTONE_FIRE ;
		public const dungeonFeatureTypes DF_BRIDGE_FIRE = dungeonFeatureTypes.DF_BRIDGE_FIRE ;
		public const dungeonFeatureTypes DF_FLAMETHROWER = dungeonFeatureTypes.DF_FLAMETHROWER ;
		public const dungeonFeatureTypes DF_EMBERS = dungeonFeatureTypes.DF_EMBERS ;
		public const dungeonFeatureTypes DF_EMBERS_PATCH = dungeonFeatureTypes.DF_EMBERS_PATCH ;
		public const dungeonFeatureTypes DF_OBSIDIAN = dungeonFeatureTypes.DF_OBSIDIAN ;
		public const dungeonFeatureTypes DF_ITEM_FIRE = dungeonFeatureTypes.DF_ITEM_FIRE ;
		public const dungeonFeatureTypes DF_CREATURE_FIRE = dungeonFeatureTypes.DF_CREATURE_FIRE ;
		public const dungeonFeatureTypes DF_FLOOD = dungeonFeatureTypes.DF_FLOOD ;
		public const dungeonFeatureTypes DF_FLOOD_2 = dungeonFeatureTypes.DF_FLOOD_2 ;
		public const dungeonFeatureTypes DF_FLOOD_DRAIN = dungeonFeatureTypes.DF_FLOOD_DRAIN ;
		public const dungeonFeatureTypes DF_HOLE_2 = dungeonFeatureTypes.DF_HOLE_2 ;
		public const dungeonFeatureTypes DF_HOLE_DRAIN = dungeonFeatureTypes.DF_HOLE_DRAIN ;
		public const dungeonFeatureTypes DF_POISON_GAS_CLOUD = dungeonFeatureTypes.DF_POISON_GAS_CLOUD ;
		public const dungeonFeatureTypes DF_CONFUSION_GAS_TRAP_CLOUD = dungeonFeatureTypes.DF_CONFUSION_GAS_TRAP_CLOUD ;
		public const dungeonFeatureTypes DF_NET = dungeonFeatureTypes.DF_NET ;
		public const dungeonFeatureTypes DF_AGGRAVATE_TRAP = dungeonFeatureTypes.DF_AGGRAVATE_TRAP ;
		public const dungeonFeatureTypes DF_METHANE_GAS_ARMAGEDDON = dungeonFeatureTypes.DF_METHANE_GAS_ARMAGEDDON ;

		// potions
		public const dungeonFeatureTypes DF_POISON_GAS_CLOUD_POTION = dungeonFeatureTypes.DF_POISON_GAS_CLOUD_POTION ;
		public const dungeonFeatureTypes DF_PARALYSIS_GAS_CLOUD_POTION = dungeonFeatureTypes.DF_PARALYSIS_GAS_CLOUD_POTION ;
		public const dungeonFeatureTypes DF_CONFUSION_GAS_CLOUD_POTION = dungeonFeatureTypes.DF_CONFUSION_GAS_CLOUD_POTION ;
		public const dungeonFeatureTypes DF_INCINERATION_POTION = dungeonFeatureTypes.DF_INCINERATION_POTION ;
		public const dungeonFeatureTypes DF_DARKNESS_POTION = dungeonFeatureTypes.DF_DARKNESS_POTION ;
		public const dungeonFeatureTypes DF_HOLE_POTION = dungeonFeatureTypes.DF_HOLE_POTION ;
		public const dungeonFeatureTypes DF_LICHEN_PLANTED = dungeonFeatureTypes.DF_LICHEN_PLANTED ;

		// other items
		public const dungeonFeatureTypes DF_ARMOR_IMMOLATION = dungeonFeatureTypes.DF_ARMOR_IMMOLATION ;
		public const dungeonFeatureTypes DF_STAFF_HOLE = dungeonFeatureTypes.DF_STAFF_HOLE ;
		public const dungeonFeatureTypes DF_STAFF_HOLE_EDGE = dungeonFeatureTypes.DF_STAFF_HOLE_EDGE ;

		// commutation altar
		public const dungeonFeatureTypes DF_ALTAR_COMMUTE = dungeonFeatureTypes.DF_ALTAR_COMMUTE ;
		public const dungeonFeatureTypes DF_MAGIC_PIPING = dungeonFeatureTypes.DF_MAGIC_PIPING ;
		public const dungeonFeatureTypes DF_INERT_PIPE = dungeonFeatureTypes.DF_INERT_PIPE ;

		// resurrection altar
		public const dungeonFeatureTypes DF_ALTAR_RESURRECT = dungeonFeatureTypes.DF_ALTAR_RESURRECT ;
		public const dungeonFeatureTypes DF_MACHINE_FLOOR_TRIGGER_REPEATING = dungeonFeatureTypes.DF_MACHINE_FLOOR_TRIGGER_REPEATING ;

		// vampire in coffin
		public const dungeonFeatureTypes DF_COFFIN_BURSTS = dungeonFeatureTypes.DF_COFFIN_BURSTS ;
		public const dungeonFeatureTypes DF_COFFIN_BURNS = dungeonFeatureTypes.DF_COFFIN_BURNS ;
		public const dungeonFeatureTypes DF_TRIGGER_AREA = dungeonFeatureTypes.DF_TRIGGER_AREA ;

		// throwing tutorial -- button in chasm
		public const dungeonFeatureTypes DF_CAGE_DISAPPEARS = dungeonFeatureTypes.DF_CAGE_DISAPPEARS ;
		public const dungeonFeatureTypes DF_MEDIUM_HOLE = dungeonFeatureTypes.DF_MEDIUM_HOLE ;
		public const dungeonFeatureTypes DF_MEDIUM_LAVA_POND = dungeonFeatureTypes.DF_MEDIUM_LAVA_POND ;
		public const dungeonFeatureTypes DF_MACHINE_PRESSURE_PLATE_USED = dungeonFeatureTypes.DF_MACHINE_PRESSURE_PLATE_USED ;

		// rat trap
		public const dungeonFeatureTypes DF_WALL_CRACK = dungeonFeatureTypes.DF_WALL_CRACK ;

		// wooden barricade at entrance
		public const dungeonFeatureTypes DF_WOODEN_BARRICADE_BURN = dungeonFeatureTypes.DF_WOODEN_BARRICADE_BURN ;

		// wooden barricade around altar, dead grass all around
		public const dungeonFeatureTypes DF_SURROUND_WOODEN_BARRICADE = dungeonFeatureTypes.DF_SURROUND_WOODEN_BARRICADE ;

		// pools of water that, when triggered, slowly expand to fill the room
		public const dungeonFeatureTypes DF_SPREADABLE_WATER = dungeonFeatureTypes.DF_SPREADABLE_WATER ;
		public const dungeonFeatureTypes DF_SHALLOW_WATER = dungeonFeatureTypes.DF_SHALLOW_WATER ;
		public const dungeonFeatureTypes DF_WATER_SPREADS = dungeonFeatureTypes.DF_WATER_SPREADS ;
		public const dungeonFeatureTypes DF_SPREADABLE_WATER_POOL = dungeonFeatureTypes.DF_SPREADABLE_WATER_POOL ;
		public const dungeonFeatureTypes DF_SPREADABLE_DEEP_WATER_POOL = dungeonFeatureTypes.DF_SPREADABLE_DEEP_WATER_POOL ;

		// when triggered, the ground gradually turns into chasm:
		public const dungeonFeatureTypes DF_SPREADABLE_COLLAPSE = dungeonFeatureTypes.DF_SPREADABLE_COLLAPSE ;
		public const dungeonFeatureTypes DF_COLLAPSE = dungeonFeatureTypes.DF_COLLAPSE ;
		public const dungeonFeatureTypes DF_COLLAPSE_SPREADS = dungeonFeatureTypes.DF_COLLAPSE_SPREADS ;
		public const dungeonFeatureTypes DF_ADD_MACHINE_COLLAPSE_EDGE_DORMANT = dungeonFeatureTypes.DF_ADD_MACHINE_COLLAPSE_EDGE_DORMANT ;

		// when triggered, a bridge appears:
		public const dungeonFeatureTypes DF_BRIDGE_ACTIVATE = dungeonFeatureTypes.DF_BRIDGE_ACTIVATE ;
		public const dungeonFeatureTypes DF_BRIDGE_ACTIVATE_ANNOUNCE = dungeonFeatureTypes.DF_BRIDGE_ACTIVATE_ANNOUNCE ;
		public const dungeonFeatureTypes DF_BRIDGE_APPEARS = dungeonFeatureTypes.DF_BRIDGE_APPEARS ;
		public const dungeonFeatureTypes DF_ADD_DORMANT_CHASM_HALO = dungeonFeatureTypes.DF_ADD_DORMANT_CHASM_HALO ;

		// when triggered, the lava retracts:
		public const dungeonFeatureTypes DF_LAVA_RETRACTABLE = dungeonFeatureTypes.DF_LAVA_RETRACTABLE ;
		public const dungeonFeatureTypes DF_RETRACTING_LAVA = dungeonFeatureTypes.DF_RETRACTING_LAVA ;
		public const dungeonFeatureTypes DF_OBSIDIAN_WITH_STEAM = dungeonFeatureTypes.DF_OBSIDIAN_WITH_STEAM ;

		// when triggered, the door seals and caustic gas fills the room
		public const dungeonFeatureTypes DF_SHOW_POISON_GAS_VENT = dungeonFeatureTypes.DF_SHOW_POISON_GAS_VENT ;
		public const dungeonFeatureTypes DF_POISON_GAS_VENT_OPEN = dungeonFeatureTypes.DF_POISON_GAS_VENT_OPEN ;
		public const dungeonFeatureTypes DF_ACTIVATE_PORTCULLIS = dungeonFeatureTypes.DF_ACTIVATE_PORTCULLIS ;
		public const dungeonFeatureTypes DF_OPEN_PORTCULLIS = dungeonFeatureTypes.DF_OPEN_PORTCULLIS ;
		public const dungeonFeatureTypes DF_VENT_SPEW_POISON_GAS = dungeonFeatureTypes.DF_VENT_SPEW_POISON_GAS ;

		// when triggered, pilot light ignites and explosive gas fills the room
		public const dungeonFeatureTypes DF_SHOW_METHANE_VENT = dungeonFeatureTypes.DF_SHOW_METHANE_VENT ;
		public const dungeonFeatureTypes DF_METHANE_VENT_OPEN = dungeonFeatureTypes.DF_METHANE_VENT_OPEN ;
		public const dungeonFeatureTypes DF_VENT_SPEW_METHANE = dungeonFeatureTypes.DF_VENT_SPEW_METHANE ;
		public const dungeonFeatureTypes DF_PILOT_LIGHT = dungeonFeatureTypes.DF_PILOT_LIGHT ;

		// paralysis trap: trigger plate with gas vents nearby
		public const dungeonFeatureTypes DF_DISCOVER_PARALYSIS_VENT = dungeonFeatureTypes.DF_DISCOVER_PARALYSIS_VENT ;
		public const dungeonFeatureTypes DF_PARALYSIS_VENT_SPEW = dungeonFeatureTypes.DF_PARALYSIS_VENT_SPEW ;
		public const dungeonFeatureTypes DF_REVEAL_PARALYSIS_VENT_SILENTLY = dungeonFeatureTypes.DF_REVEAL_PARALYSIS_VENT_SILENTLY ;

		// thematic dungeon
		public const dungeonFeatureTypes DF_AMBIENT_BLOOD = dungeonFeatureTypes.DF_AMBIENT_BLOOD ;

		// statues crack for a few turns and then shatter, revealing the monster inside
		public const dungeonFeatureTypes DF_CRACKING_STATUE = dungeonFeatureTypes.DF_CRACKING_STATUE ;
		public const dungeonFeatureTypes DF_STATUE_SHATTER = dungeonFeatureTypes.DF_STATUE_SHATTER ;

		// a turret appears:
		public const dungeonFeatureTypes DF_TURRET_EMERGE = dungeonFeatureTypes.DF_TURRET_EMERGE ;

		// an elaborate worm catacomb opens up
		public const dungeonFeatureTypes DF_WORM_TUNNEL_MARKER_DORMANT = dungeonFeatureTypes.DF_WORM_TUNNEL_MARKER_DORMANT ;
		public const dungeonFeatureTypes DF_WORM_TUNNEL_MARKER_ACTIVE = dungeonFeatureTypes.DF_WORM_TUNNEL_MARKER_ACTIVE ;
		public const dungeonFeatureTypes DF_GRANITE_CRUMBLES = dungeonFeatureTypes.DF_GRANITE_CRUMBLES ;
		public const dungeonFeatureTypes DF_WALL_OPEN = dungeonFeatureTypes.DF_WALL_OPEN ;

		// the room gradually darkens
		public const dungeonFeatureTypes DF_DARKENING_FLOOR = dungeonFeatureTypes.DF_DARKENING_FLOOR ;
		public const dungeonFeatureTypes DF_DARK_FLOOR = dungeonFeatureTypes.DF_DARK_FLOOR ;
		public const dungeonFeatureTypes DF_HAUNTED_TORCH_TRANSITION = dungeonFeatureTypes.DF_HAUNTED_TORCH_TRANSITION ;
		public const dungeonFeatureTypes DF_HAUNTED_TORCH = dungeonFeatureTypes.DF_HAUNTED_TORCH ;

		// bubbles rise from the mud and bog monsters spawn
		public const dungeonFeatureTypes DF_MUD_DORMANT = dungeonFeatureTypes.DF_MUD_DORMANT ;
		public const dungeonFeatureTypes DF_MUD_ACTIVATE = dungeonFeatureTypes.DF_MUD_ACTIVATE ;

		// crystals charge when hit by lightning
		public const dungeonFeatureTypes DF_ELECTRIC_CRYSTAL_ON = dungeonFeatureTypes.DF_ELECTRIC_CRYSTAL_ON ;
		public const dungeonFeatureTypes DF_TURRET_LEVER = dungeonFeatureTypes.DF_TURRET_LEVER ;

		// idyll:
		public const dungeonFeatureTypes DF_SHALLOW_WATER_POOL = dungeonFeatureTypes.DF_SHALLOW_WATER_POOL ;
		public const dungeonFeatureTypes DF_DEEP_WATER_POOL = dungeonFeatureTypes.DF_DEEP_WATER_POOL ;

		// swamp:
		public const dungeonFeatureTypes DF_SWAMP_WATER = dungeonFeatureTypes.DF_SWAMP_WATER ;
		public const dungeonFeatureTypes DF_SWAMP = dungeonFeatureTypes.DF_SWAMP ;
		public const dungeonFeatureTypes DF_SWAMP_MUD = dungeonFeatureTypes.DF_SWAMP_MUD ;

		// camp:
		public const dungeonFeatureTypes DF_HAY = dungeonFeatureTypes.DF_HAY ;
		public const dungeonFeatureTypes DF_JUNK = dungeonFeatureTypes.DF_JUNK ;

		// remnants:
		public const dungeonFeatureTypes DF_REMNANT = dungeonFeatureTypes.DF_REMNANT ;
		public const dungeonFeatureTypes DF_REMNANT_ASH = dungeonFeatureTypes.DF_REMNANT_ASH ;

		// chasm catwalk:
		public const dungeonFeatureTypes DF_CHASM_HOLE = dungeonFeatureTypes.DF_CHASM_HOLE ;
		public const dungeonFeatureTypes DF_CATWALK_BRIDGE = dungeonFeatureTypes.DF_CATWALK_BRIDGE ;

		// lake catwalk:
		public const dungeonFeatureTypes DF_LAKE_CELL = dungeonFeatureTypes.DF_LAKE_CELL ;
		public const dungeonFeatureTypes DF_LAKE_HALO = dungeonFeatureTypes.DF_LAKE_HALO ;

		// worm den:
		public const dungeonFeatureTypes DF_WALL_SHATTER = dungeonFeatureTypes.DF_WALL_SHATTER ;

		// monster cages open:
		public const dungeonFeatureTypes DF_MONSTER_CAGE_OPENS = dungeonFeatureTypes.DF_MONSTER_CAGE_OPENS ;

		// goblin warren:
		public const dungeonFeatureTypes DF_STENCH_BURN = dungeonFeatureTypes.DF_STENCH_BURN ;
		public const dungeonFeatureTypes DF_STENCH_SMOLDER = dungeonFeatureTypes.DF_STENCH_SMOLDER ;

		public const int NUMBER_DUNGEON_FEATURES = RogueH.NUMBER_DUNGEON_FEATURES ;

		public const ulong DFF_EVACUATE_CREATURES_FIRST = (ulong)DFFlags.DFF_EVACUATE_CREATURES_FIRST ;	// Creatures in the DF area get moved outside of it
		public const ulong DFF_SUBSEQ_EVERYWHERE = (ulong)DFFlags.DFF_SUBSEQ_EVERYWHERE ;	// Subsequent DF spawns in every cell that this DF spawns in, instead of only the origin
		public const ulong DFF_TREAT_AS_BLOCKING = (ulong)DFFlags.DFF_TREAT_AS_BLOCKING ;	// If filling the footprint of this DF with walls would disrupt level connectivity, then abort.
		public const ulong DFF_PERMIT_BLOCKING = (ulong)DFFlags.DFF_PERMIT_BLOCKING ;	// Generate this DF without regard to level connectivity.
		public const ulong DFF_ACTIVATE_DORMANT_MONSTER = (ulong)DFFlags.DFF_ACTIVATE_DORMANT_MONSTER ;	// Dormant monsters on this tile will appear -- e.g. when a statue bursts to reveal a monster.
		public const ulong DFF_CLEAR_OTHER_TERRAIN = (ulong)DFFlags.DFF_CLEAR_OTHER_TERRAIN ;	// Erase other terrain in the footprint of this DF.
		public const ulong DFF_BLOCKED_BY_OTHER_LAYERS = (ulong)DFFlags.DFF_BLOCKED_BY_OTHER_LAYERS ;	// Will not propagate into a cell if any layer in that cell has a superior priority.
		public const ulong DFF_SUPERPRIORITY = (ulong)DFFlags.DFF_SUPERPRIORITY ;	// Will overwrite terrain of a superior priority.
		public const ulong DFF_AGGRAVATES_MONSTERS = (ulong)DFFlags.DFF_AGGRAVATES_MONSTERS ;    // Will act as though an aggravate monster scroll of effectRadius radius had been read at that point.
		public const ulong DFF_RESURRECT_ALLY = (ulong)DFFlags.DFF_RESURRECT_ALLY ;    // Will bring back to life your most recently deceased ally.

		public const lightType NO_LIGHT = lightType.NO_LIGHT ;
		public const lightType MINERS_LIGHT = lightType.MINERS_LIGHT ;
		public const lightType BURNING_CREATURE_LIGHT = lightType.BURNING_CREATURE_LIGHT ;
		public const lightType WISP_LIGHT = lightType.WISP_LIGHT ;
		public const lightType SALAMANDER_LIGHT = lightType.SALAMANDER_LIGHT ;
		public const lightType IMP_LIGHT = lightType.IMP_LIGHT ;
		public const lightType PIXIE_LIGHT = lightType.PIXIE_LIGHT ;
		public const lightType LICH_LIGHT = lightType.LICH_LIGHT ;
		public const lightType FLAMEDANCER_LIGHT = lightType.FLAMEDANCER_LIGHT ;
		public const lightType SENTINEL_LIGHT = lightType.SENTINEL_LIGHT ;
		public const lightType UNICORN_LIGHT = lightType.UNICORN_LIGHT ;
		public const lightType IFRIT_LIGHT = lightType.IFRIT_LIGHT ;
		public const lightType PHOENIX_LIGHT = lightType.PHOENIX_LIGHT ;
		public const lightType PHOENIX_EGG_LIGHT = lightType.PHOENIX_EGG_LIGHT ;
		public const lightType YENDOR_LIGHT = lightType.YENDOR_LIGHT ;
		public const lightType SPECTRAL_BLADE_LIGHT = lightType.SPECTRAL_BLADE_LIGHT ;
		public const lightType SPECTRAL_IMAGE_LIGHT = lightType.SPECTRAL_IMAGE_LIGHT ;
		public const lightType SPARK_TURRET_LIGHT = lightType.SPARK_TURRET_LIGHT ;
		public const lightType EXPLOSIVE_BLOAT_LIGHT = lightType.EXPLOSIVE_BLOAT_LIGHT ;
		public const lightType BOLT_LIGHT_SOURCE = lightType.BOLT_LIGHT_SOURCE ;
		public const lightType TELEPATHY_LIGHT = lightType.TELEPATHY_LIGHT ;
		public const lightType SCROLL_PROTECTION_LIGHT = lightType.SCROLL_PROTECTION_LIGHT ;
		public const lightType SCROLL_ENCHANTMENT_LIGHT = lightType.SCROLL_ENCHANTMENT_LIGHT ;
		public const lightType POTION_STRENGTH_LIGHT = lightType.POTION_STRENGTH_LIGHT ;
		public const lightType EMPOWERMENT_LIGHT = lightType.EMPOWERMENT_LIGHT ;
		public const lightType GENERIC_FLASH_LIGHT = lightType.GENERIC_FLASH_LIGHT ;
		public const lightType FALLEN_TORCH_FLASH_LIGHT = lightType.FALLEN_TORCH_FLASH_LIGHT ;
		public const lightType SUMMONING_FLASH_LIGHT = lightType.SUMMONING_FLASH_LIGHT ;
		public const lightType EXPLOSION_FLARE_LIGHT = lightType.EXPLOSION_FLARE_LIGHT ;
		public const lightType QUIETUS_FLARE_LIGHT = lightType.QUIETUS_FLARE_LIGHT ;
		public const lightType SLAYING_FLARE_LIGHT = lightType.SLAYING_FLARE_LIGHT ;
		public const lightType CHARGE_FLASH_LIGHT = lightType.CHARGE_FLASH_LIGHT ;
		public const lightType TORCH_LIGHT = lightType.TORCH_LIGHT ;
		public const lightType LAVA_LIGHT = lightType.LAVA_LIGHT ;
		public const lightType SUN_LIGHT = lightType.SUN_LIGHT ;
		public const lightType DARKNESS_PATCH_LIGHT = lightType.DARKNESS_PATCH_LIGHT ;
		public const lightType FUNGUS_LIGHT = lightType.FUNGUS_LIGHT ;
		public const lightType FUNGUS_FOREST_LIGHT = lightType.FUNGUS_FOREST_LIGHT ;
		public const lightType LUMINESCENT_ALGAE_BLUE_LIGHT = lightType.LUMINESCENT_ALGAE_BLUE_LIGHT ;
		public const lightType LUMINESCENT_ALGAE_GREEN_LIGHT = lightType.LUMINESCENT_ALGAE_GREEN_LIGHT ;
		public const lightType ECTOPLASM_LIGHT = lightType.ECTOPLASM_LIGHT ;
		public const lightType UNICORN_POOP_LIGHT = lightType.UNICORN_POOP_LIGHT ;
		public const lightType EMBER_LIGHT = lightType.EMBER_LIGHT ;
		public const lightType FIRE_LIGHT = lightType.FIRE_LIGHT ;
		public const lightType BRIMSTONE_FIRE_LIGHT = lightType.BRIMSTONE_FIRE_LIGHT ;
		public const lightType EXPLOSION_LIGHT = lightType.EXPLOSION_LIGHT ;
		public const lightType INCENDIARY_DART_LIGHT = lightType.INCENDIARY_DART_LIGHT ;
		public const lightType PORTAL_ACTIVATE_LIGHT = lightType.PORTAL_ACTIVATE_LIGHT ;
		public const lightType CONFUSION_GAS_LIGHT = lightType.CONFUSION_GAS_LIGHT ;
		public const lightType DARKNESS_CLOUD_LIGHT = lightType.DARKNESS_CLOUD_LIGHT ;
		public const lightType FORCEFIELD_LIGHT = lightType.FORCEFIELD_LIGHT ;
		public const lightType CRYSTAL_WALL_LIGHT = lightType.CRYSTAL_WALL_LIGHT ;
		public const lightType CANDLE_LIGHT = lightType.CANDLE_LIGHT ;
		public const lightType HAUNTED_TORCH_LIGHT = lightType.HAUNTED_TORCH_LIGHT ;
		public const lightType GLYPH_LIGHT_DIM = lightType.GLYPH_LIGHT_DIM ;
		public const lightType GLYPH_LIGHT_BRIGHT = lightType.GLYPH_LIGHT_BRIGHT ;
		public const lightType SACRED_GLYPH_LIGHT = lightType.SACRED_GLYPH_LIGHT ;
		public const lightType DESCENT_LIGHT = lightType.DESCENT_LIGHT ;
		public const int NUMBER_LIGHT_KINDS = (int)lightType.NUMBER_LIGHT_KINDS ;


		public const ulong MONST_INVISIBLE = (ulong)monsterBehaviorFlags.MONST_INVISIBLE ; 
		public const ulong MONST_INANIMATE = (ulong)monsterBehaviorFlags.MONST_INANIMATE ; 
		public const ulong MONST_IMMOBILE = (ulong)monsterBehaviorFlags.MONST_IMMOBILE ; 
		public const ulong MONST_CARRY_ITEM_100 = (ulong)monsterBehaviorFlags.MONST_CARRY_ITEM_100 ; 
		public const ulong MONST_CARRY_ITEM_25 = (ulong)monsterBehaviorFlags.MONST_CARRY_ITEM_25 ; 
		public const ulong MONST_ALWAYS_HUNTING = (ulong)monsterBehaviorFlags.MONST_ALWAYS_HUNTING ; 
		public const ulong MONST_FLEES_NEAR_DEATH = (ulong)monsterBehaviorFlags.MONST_FLEES_NEAR_DEATH ; 
		public const ulong MONST_ATTACKABLE_THRU_WALLS = (ulong)monsterBehaviorFlags.MONST_ATTACKABLE_THRU_WALLS ; 
		public const ulong MONST_DEFEND_DEGRADE_WEAPON = (ulong)monsterBehaviorFlags.MONST_DEFEND_DEGRADE_WEAPON ; 
		public const ulong MONST_IMMUNE_TO_WEAPONS = (ulong)monsterBehaviorFlags.MONST_IMMUNE_TO_WEAPONS ; 
		public const ulong MONST_FLIES = (ulong)monsterBehaviorFlags.MONST_FLIES ; 
		public const ulong MONST_FLITS = (ulong)monsterBehaviorFlags.MONST_FLITS ; 
		public const ulong MONST_IMMUNE_TO_FIRE = (ulong)monsterBehaviorFlags.MONST_IMMUNE_TO_FIRE ; 
		public const ulong MONST_CAST_SPELLS_SLOWLY = (ulong)monsterBehaviorFlags.MONST_CAST_SPELLS_SLOWLY ; 
		public const ulong MONST_IMMUNE_TO_WEBS = (ulong)monsterBehaviorFlags.MONST_IMMUNE_TO_WEBS ; 
		public const ulong MONST_REFLECT_4 = (ulong)monsterBehaviorFlags.MONST_REFLECT_4 ; 
		public const ulong MONST_NEVER_SLEEPS = (ulong)monsterBehaviorFlags.MONST_NEVER_SLEEPS ; 
		public const ulong MONST_FIERY = (ulong)monsterBehaviorFlags.MONST_FIERY ; 
		public const ulong MONST_INVULNERABLE = (ulong)monsterBehaviorFlags.MONST_INVULNERABLE ; 
		public const ulong MONST_IMMUNE_TO_WATER = (ulong)monsterBehaviorFlags.MONST_IMMUNE_TO_WATER ; 
		public const ulong MONST_RESTRICTED_TO_LIQUID = (ulong)monsterBehaviorFlags.MONST_RESTRICTED_TO_LIQUID ; 
		public const ulong MONST_SUBMERGES = (ulong)monsterBehaviorFlags.MONST_SUBMERGES ; 
		public const ulong MONST_MAINTAINS_DISTANCE = (ulong)monsterBehaviorFlags.MONST_MAINTAINS_DISTANCE ; 
		public const ulong MONST_WILL_NOT_USE_STAIRS = (ulong)monsterBehaviorFlags.MONST_WILL_NOT_USE_STAIRS ; 
		public const ulong MONST_DIES_IF_NEGATED = (ulong)monsterBehaviorFlags.MONST_DIES_IF_NEGATED ; 
		public const ulong MONST_MALE = (ulong)monsterBehaviorFlags.MONST_MALE ; 
		public const ulong MONST_FEMALE = (ulong)monsterBehaviorFlags.MONST_FEMALE ; 
		public const ulong MONST_NOT_LISTED_IN_SIDEBAR = (ulong)monsterBehaviorFlags.MONST_NOT_LISTED_IN_SIDEBAR ; 
		public const ulong MONST_GETS_TURN_ON_ACTIVATION = (ulong)monsterBehaviorFlags.MONST_GETS_TURN_ON_ACTIVATION ; 
		public const ulong MONST_ALWAYS_USE_ABILITY = (ulong)monsterBehaviorFlags.MONST_ALWAYS_USE_ABILITY ; 
		public const ulong MONST_NO_POLYMORPH = (ulong)monsterBehaviorFlags.MONST_NO_POLYMORPH ; 

		public const ulong NEGATABLE_TRAITS = (ulong)monsterBehaviorFlags.NEGATABLE_TRAITS ; 
		public const ulong MONST_TURRET = (ulong)monsterBehaviorFlags.MONST_TURRET ; 
		public const ulong LEARNABLE_BEHAVIORS = (ulong)monsterBehaviorFlags.LEARNABLE_BEHAVIORS ; 
		public const ulong MONST_NEVER_VORPAL_ENEMY = (ulong)monsterBehaviorFlags.MONST_NEVER_VORPAL_ENEMY ; 
		public const ulong MONST_NEVER_MUTATED = (ulong)monsterBehaviorFlags.MONST_NEVER_MUTATED ; 


		const monsterTypes MK_YOU = monsterTypes.MK_YOU;
		const monsterTypes MK_RAT = monsterTypes.MK_RAT;
		const monsterTypes MK_KOBOLD = monsterTypes.MK_KOBOLD;
		const monsterTypes MK_JACKAL = monsterTypes.MK_JACKAL;
		const monsterTypes MK_EEL = monsterTypes.MK_EEL;
		const monsterTypes MK_MONKEY = monsterTypes.MK_MONKEY;
		const monsterTypes MK_BLOAT = monsterTypes.MK_BLOAT;
		const monsterTypes MK_PIT_BLOAT = monsterTypes.MK_PIT_BLOAT;
		const monsterTypes MK_GOBLIN = monsterTypes.MK_GOBLIN;
		const monsterTypes MK_GOBLIN_CONJURER = monsterTypes.MK_GOBLIN_CONJURER;
		const monsterTypes MK_GOBLIN_MYSTIC = monsterTypes.MK_GOBLIN_MYSTIC;
		const monsterTypes MK_GOBLIN_TOTEM = monsterTypes.MK_GOBLIN_TOTEM;
		const monsterTypes MK_PINK_JELLY = monsterTypes.MK_PINK_JELLY;
		const monsterTypes MK_TOAD = monsterTypes.MK_TOAD;
		const monsterTypes MK_VAMPIRE_BAT = monsterTypes.MK_VAMPIRE_BAT;
		const monsterTypes MK_ARROW_TURRET = monsterTypes.MK_ARROW_TURRET;
		const monsterTypes MK_ACID_MOUND = monsterTypes.MK_ACID_MOUND;
		const monsterTypes MK_CENTIPEDE = monsterTypes.MK_CENTIPEDE;
		const monsterTypes MK_OGRE = monsterTypes.MK_OGRE;
		const monsterTypes MK_BOG_MONSTER = monsterTypes.MK_BOG_MONSTER;
		const monsterTypes MK_OGRE_TOTEM = monsterTypes.MK_OGRE_TOTEM;
		const monsterTypes MK_SPIDER = monsterTypes.MK_SPIDER;
		const monsterTypes MK_SPARK_TURRET = monsterTypes.MK_SPARK_TURRET;
		const monsterTypes MK_WILL_O_THE_WISP = monsterTypes.MK_WILL_O_THE_WISP;
		const monsterTypes MK_WRAITH = monsterTypes.MK_WRAITH;
		const monsterTypes MK_ZOMBIE = monsterTypes.MK_ZOMBIE;
		const monsterTypes MK_TROLL = monsterTypes.MK_TROLL;
		const monsterTypes MK_OGRE_SHAMAN = monsterTypes.MK_OGRE_SHAMAN;
		const monsterTypes MK_NAGA = monsterTypes.MK_NAGA;
		const monsterTypes MK_SALAMANDER = monsterTypes.MK_SALAMANDER;
		const monsterTypes MK_EXPLOSIVE_BLOAT = monsterTypes.MK_EXPLOSIVE_BLOAT;
		const monsterTypes MK_DAR_BLADEMASTER = monsterTypes.MK_DAR_BLADEMASTER;
		const monsterTypes MK_DAR_PRIESTESS = monsterTypes.MK_DAR_PRIESTESS;
		const monsterTypes MK_DAR_BATTLEMAGE = monsterTypes.MK_DAR_BATTLEMAGE;
		const monsterTypes MK_ACID_JELLY = monsterTypes.MK_ACID_JELLY;
		const monsterTypes MK_CENTAUR = monsterTypes.MK_CENTAUR;
		const monsterTypes MK_UNDERWORM = monsterTypes.MK_UNDERWORM;
		const monsterTypes MK_SENTINEL = monsterTypes.MK_SENTINEL;
		const monsterTypes MK_ACID_TURRET = monsterTypes.MK_ACID_TURRET;
		const monsterTypes MK_DART_TURRET = monsterTypes.MK_DART_TURRET;
		const monsterTypes MK_KRAKEN = monsterTypes.MK_KRAKEN;
		const monsterTypes MK_LICH = monsterTypes.MK_LICH;
		const monsterTypes MK_PHYLACTERY = monsterTypes.MK_PHYLACTERY;
		const monsterTypes MK_PIXIE = monsterTypes.MK_PIXIE;
		const monsterTypes MK_PHANTOM = monsterTypes.MK_PHANTOM;
		const monsterTypes MK_FLAME_TURRET = monsterTypes.MK_FLAME_TURRET;
		const monsterTypes MK_IMP = monsterTypes.MK_IMP;
		const monsterTypes MK_FURY = monsterTypes.MK_FURY;
		const monsterTypes MK_REVENANT = monsterTypes.MK_REVENANT;
		const monsterTypes MK_TENTACLE_HORROR = monsterTypes.MK_TENTACLE_HORROR;
		const monsterTypes MK_GOLEM = monsterTypes.MK_GOLEM;
		const monsterTypes MK_DRAGON = monsterTypes.MK_DRAGON;

		const monsterTypes MK_GOBLIN_CHIEFTAN = monsterTypes.MK_GOBLIN_CHIEFTAN;
		const monsterTypes MK_BLACK_JELLY = monsterTypes.MK_BLACK_JELLY;
		const monsterTypes MK_VAMPIRE = monsterTypes.MK_VAMPIRE;
		const monsterTypes MK_FLAMEDANCER = monsterTypes.MK_FLAMEDANCER;

		const monsterTypes MK_SPECTRAL_BLADE = monsterTypes.MK_SPECTRAL_BLADE;
		const monsterTypes MK_SPECTRAL_IMAGE = monsterTypes.MK_SPECTRAL_IMAGE;
		const monsterTypes MK_GUARDIAN = monsterTypes.MK_GUARDIAN;
		const monsterTypes MK_WINGED_GUARDIAN = monsterTypes.MK_WINGED_GUARDIAN;
		const monsterTypes MK_CHARM_GUARDIAN = monsterTypes.MK_CHARM_GUARDIAN;
		const monsterTypes MK_WARDEN_OF_YENDOR = monsterTypes.MK_WARDEN_OF_YENDOR;
		const monsterTypes MK_ELDRITCH_TOTEM = monsterTypes.MK_ELDRITCH_TOTEM;
		const monsterTypes MK_MIRRORED_TOTEM = monsterTypes.MK_MIRRORED_TOTEM;

		const monsterTypes MK_UNICORN = monsterTypes.MK_UNICORN;
		const monsterTypes MK_IFRIT = monsterTypes.MK_IFRIT;
		const monsterTypes MK_PHOENIX = monsterTypes.MK_PHOENIX;
		const monsterTypes MK_PHOENIX_EGG = monsterTypes.MK_PHOENIX_EGG;
		const monsterTypes MK_ANCIENT_SPIRIT = monsterTypes.MK_ANCIENT_SPIRIT;

		const int NUMBER_MONSTER_KINDS = (int)monsterTypes.NUMBER_MONSTER_KINDS; 

		//--------------------------------------------------

		public const ulong MA_HIT_HALLUCINATE = (ulong)monsterAbilityFlags.MA_HIT_HALLUCINATE ; 
		public const ulong MA_HIT_STEAL_FLEE = (ulong)monsterAbilityFlags.MA_HIT_STEAL_FLEE ; 
		public const ulong MA_ENTER_SUMMONS = (ulong)monsterAbilityFlags.MA_ENTER_SUMMONS ; 
		public const ulong MA_HIT_DEGRADE_ARMOR = (ulong)monsterAbilityFlags.MA_HIT_DEGRADE_ARMOR ; 
		public const ulong MA_CAST_SUMMON = (ulong)monsterAbilityFlags.MA_CAST_SUMMON ; 
		public const ulong MA_SEIZES = (ulong)monsterAbilityFlags.MA_SEIZES ; 
		public const ulong MA_POISONS = (ulong)monsterAbilityFlags.MA_POISONS ; 
		public const ulong MA_DF_ON_DEATH = (ulong)monsterAbilityFlags.MA_DF_ON_DEATH ; 
		public const ulong MA_CLONE_SELF_ON_DEFEND = (ulong)monsterAbilityFlags.MA_CLONE_SELF_ON_DEFEND ; 
		public const ulong MA_KAMIKAZE = (ulong)monsterAbilityFlags.MA_KAMIKAZE ; 
		public const ulong MA_TRANSFERENCE = (ulong)monsterAbilityFlags.MA_TRANSFERENCE ; 
		public const ulong MA_CAUSES_WEAKNESS = (ulong)monsterAbilityFlags.MA_CAUSES_WEAKNESS ; 
		public const ulong MA_ATTACKS_PENETRATE = (ulong)monsterAbilityFlags.MA_ATTACKS_PENETRATE ; 
		public const ulong MA_ATTACKS_ALL_ADJACENT = (ulong)monsterAbilityFlags.MA_ATTACKS_ALL_ADJACENT ; 
		public const ulong MA_ATTACKS_EXTEND = (ulong)monsterAbilityFlags.MA_ATTACKS_EXTEND ; 
		public const ulong MA_AVOID_CORRIDORS = (ulong)monsterAbilityFlags.MA_AVOID_CORRIDORS ; 

		public const ulong SPECIAL_HIT = (ulong)monsterAbilityFlags.SPECIAL_HIT ; 
		public const ulong LEARNABLE_ABILITIES = (ulong)monsterAbilityFlags.LEARNABLE_ABILITIES ; 

		public const ulong MA_NON_NEGATABLE_ABILITIES = (ulong)monsterAbilityFlags.MA_NON_NEGATABLE_ABILITIES ; 
		public const ulong MA_NEVER_VORPAL_ENEMY = (ulong)monsterAbilityFlags.MA_NEVER_VORPAL_ENEMY ; 
		public const ulong MA_NEVER_MUTATED = (ulong)monsterAbilityFlags.MA_NEVER_MUTATED ; 

		//--------------------------------------------------

		public const ulong MB_WAS_VISIBLE = (ulong)monsterBookkeepingFlags.MB_WAS_VISIBLE ; 
		public const ulong MB_TELEPATHICALLY_REVEALED = (ulong)monsterBookkeepingFlags.MB_TELEPATHICALLY_REVEALED ; 
		public const ulong MB_PREPLACED = (ulong)monsterBookkeepingFlags.MB_PREPLACED ; 
		public const ulong MB_APPROACHING_UPSTAIRS = (ulong)monsterBookkeepingFlags.MB_APPROACHING_UPSTAIRS ; 
		public const ulong MB_APPROACHING_DOWNSTAIRS = (ulong)monsterBookkeepingFlags.MB_APPROACHING_DOWNSTAIRS ; 
		public const ulong MB_APPROACHING_PIT = (ulong)monsterBookkeepingFlags.MB_APPROACHING_PIT ; 
		public const ulong MB_LEADER = (ulong)monsterBookkeepingFlags.MB_LEADER ; 
		public const ulong MB_FOLLOWER = (ulong)monsterBookkeepingFlags.MB_FOLLOWER ; 
		public const ulong MB_CAPTIVE = (ulong)monsterBookkeepingFlags.MB_CAPTIVE ; 
		public const ulong MB_SEIZED = (ulong)monsterBookkeepingFlags.MB_SEIZED ; 
		public const ulong MB_SEIZING = (ulong)monsterBookkeepingFlags.MB_SEIZING ; 
		public const ulong MB_SUBMERGED = (ulong)monsterBookkeepingFlags.MB_SUBMERGED ; 
		public const ulong MB_JUST_SUMMONED = (ulong)monsterBookkeepingFlags.MB_JUST_SUMMONED ; 
		public const ulong MB_WILL_FLASH = (ulong)monsterBookkeepingFlags.MB_WILL_FLASH ; 
		public const ulong MB_BOUND_TO_LEADER = (ulong)monsterBookkeepingFlags.MB_BOUND_TO_LEADER ; 
		public const ulong MB_ABSORBING = (ulong)monsterBookkeepingFlags.MB_ABSORBING ; 
		public const ulong MB_DOES_NOT_TRACK_LEADER = (ulong)monsterBookkeepingFlags.MB_DOES_NOT_TRACK_LEADER ; 
		public const ulong MB_IS_FALLING = (ulong)monsterBookkeepingFlags.MB_IS_FALLING ; 
		public const ulong MB_IS_DYING = (ulong)monsterBookkeepingFlags.MB_IS_DYING ; 
		public const ulong MB_GIVEN_UP_ON_SCENT = (ulong)monsterBookkeepingFlags.MB_GIVEN_UP_ON_SCENT ; 
		public const ulong MB_IS_DORMANT = (ulong)monsterBookkeepingFlags.MB_IS_DORMANT ; 
		public const ulong MB_HAS_SOUL = (ulong)monsterBookkeepingFlags.MB_HAS_SOUL ; 
		public const ulong MB_ALREADY_SEEN = (ulong)monsterBookkeepingFlags.MB_ALREADY_SEEN ; 

		//--------------------------------------------------


		public const boltType BOLT_NONE = boltType.BOLT_NONE ; 
		public const boltType BOLT_TELEPORT = boltType.BOLT_TELEPORT ; 
		public const boltType BOLT_SLOW = boltType.BOLT_SLOW ; 
		public const boltType BOLT_POLYMORPH = boltType.BOLT_POLYMORPH ; 
		public const boltType BOLT_NEGATION = boltType.BOLT_NEGATION ; 
		public const boltType BOLT_DOMINATION = boltType.BOLT_DOMINATION ; 
		public const boltType BOLT_BECKONING = boltType.BOLT_BECKONING ; 
		public const boltType BOLT_PLENTY = boltType.BOLT_PLENTY ; 
		public const boltType BOLT_INVISIBILITY = boltType.BOLT_INVISIBILITY ; 
		public const boltType BOLT_EMPOWERMENT = boltType.BOLT_EMPOWERMENT ; 
		public const boltType BOLT_LIGHTNING = boltType.BOLT_LIGHTNING ; 
		public const boltType BOLT_FIRE = boltType.BOLT_FIRE ; 
		public const boltType BOLT_POISON = boltType.BOLT_POISON ; 
		public const boltType BOLT_TUNNELING = boltType.BOLT_TUNNELING ; 
		public const boltType BOLT_BLINKING = boltType.BOLT_BLINKING ; 
		public const boltType BOLT_ENTRANCEMENT = boltType.BOLT_ENTRANCEMENT ; 
		public const boltType BOLT_OBSTRUCTION = boltType.BOLT_OBSTRUCTION ; 
		public const boltType BOLT_DISCORD = boltType.BOLT_DISCORD ; 
		public const boltType BOLT_CONJURATION = boltType.BOLT_CONJURATION ; 
		public const boltType BOLT_HEALING = boltType.BOLT_HEALING ; 
		public const boltType BOLT_HASTE = boltType.BOLT_HASTE ; 
		public const boltType BOLT_SLOW_2 = boltType.BOLT_SLOW_2 ; 
		public const boltType BOLT_SHIELDING = boltType.BOLT_SHIELDING ; 
		public const boltType BOLT_SPIDERWEB = boltType.BOLT_SPIDERWEB ; 
		public const boltType BOLT_SPARK = boltType.BOLT_SPARK ; 
		public const boltType BOLT_DRAGONFIRE = boltType.BOLT_DRAGONFIRE ; 
		public const boltType BOLT_DISTANCE_ATTACK = boltType.BOLT_DISTANCE_ATTACK ; 
		public const boltType BOLT_POISON_DART = boltType.BOLT_POISON_DART ; 
		public const boltType BOLT_ACID_TURRET_ATTACK = boltType.BOLT_ACID_TURRET_ATTACK ; 
		public const boltType BOLT_ANCIENT_SPIRIT_VINES = boltType.BOLT_ANCIENT_SPIRIT_VINES ; 
		public const boltType BOLT_WHIP = boltType.BOLT_WHIP ; 
		public const int NUMBER_BOLT_KINDS = (int)boltType.NUMBER_BOLT_KINDS ; 

		//--------------------------------------------------

		const ulong T_OBSTRUCTS_PASSABILITY = (ulong)terrainFlagCatalog.T_OBSTRUCTS_PASSABILITY;
		const ulong T_OBSTRUCTS_VISION = (ulong)terrainFlagCatalog.T_OBSTRUCTS_VISION;
		const ulong T_OBSTRUCTS_ITEMS = (ulong)terrainFlagCatalog.T_OBSTRUCTS_ITEMS;
		const ulong T_OBSTRUCTS_SURFACE_EFFECTS = (ulong)terrainFlagCatalog.T_OBSTRUCTS_SURFACE_EFFECTS;
		const ulong T_OBSTRUCTS_GAS = (ulong)terrainFlagCatalog.T_OBSTRUCTS_GAS;
		const ulong T_OBSTRUCTS_DIAGONAL_MOVEMENT = (ulong)terrainFlagCatalog.T_OBSTRUCTS_DIAGONAL_MOVEMENT;
		const ulong T_SPONTANEOUSLY_IGNITES = (ulong)terrainFlagCatalog.T_SPONTANEOUSLY_IGNITES;
		const ulong T_AUTO_DESCENT = (ulong)terrainFlagCatalog.T_AUTO_DESCENT;
		const ulong T_LAVA_INSTA_DEATH = (ulong)terrainFlagCatalog.T_LAVA_INSTA_DEATH;
		const ulong T_CAUSES_POISON = (ulong)terrainFlagCatalog.T_CAUSES_POISON;
		const ulong T_IS_FLAMMABLE = (ulong)terrainFlagCatalog.T_IS_FLAMMABLE;
		const ulong T_IS_FIRE = (ulong)terrainFlagCatalog.T_IS_FIRE;
		const ulong T_ENTANGLES = (ulong)terrainFlagCatalog.T_ENTANGLES;
		const ulong T_IS_DEEP_WATER = (ulong)terrainFlagCatalog.T_IS_DEEP_WATER;
		const ulong T_CAUSES_DAMAGE = (ulong)terrainFlagCatalog.T_CAUSES_DAMAGE;
		const ulong T_CAUSES_NAUSEA = (ulong)terrainFlagCatalog.T_CAUSES_NAUSEA;
		const ulong T_CAUSES_PARALYSIS = (ulong)terrainFlagCatalog.T_CAUSES_PARALYSIS;
		const ulong T_CAUSES_CONFUSION = (ulong)terrainFlagCatalog.T_CAUSES_CONFUSION;
		const ulong T_CAUSES_HEALING = (ulong)terrainFlagCatalog.T_CAUSES_HEALING;
		const ulong T_IS_DF_TRAP = (ulong)terrainFlagCatalog.T_IS_DF_TRAP;
		const ulong T_CAUSES_EXPLOSIVE_DAMAGE = (ulong)terrainFlagCatalog.T_CAUSES_EXPLOSIVE_DAMAGE;
		const ulong T_SACRED = (ulong)terrainFlagCatalog.T_SACRED;

		const ulong T_OBSTRUCTS_SCENT = (ulong)terrainFlagCatalog.T_OBSTRUCTS_SCENT;
		const ulong T_PATHING_BLOCKER = (ulong)terrainFlagCatalog.T_PATHING_BLOCKER;
		const ulong T_DIVIDES_LEVEL = (ulong)terrainFlagCatalog.T_DIVIDES_LEVEL;
		const ulong T_LAKE_PATHING_BLOCKER = (ulong)terrainFlagCatalog.T_LAKE_PATHING_BLOCKER;
		const ulong T_WAYPOINT_BLOCKER = (ulong)terrainFlagCatalog.T_WAYPOINT_BLOCKER;
		const ulong T_MOVES_ITEMS = (ulong)terrainFlagCatalog.T_MOVES_ITEMS;
		const ulong T_CAN_BE_BRIDGED = (ulong)terrainFlagCatalog.T_CAN_BE_BRIDGED;
		const ulong T_OBSTRUCTS_EVERYTHING = (ulong)terrainFlagCatalog.T_OBSTRUCTS_EVERYTHING;
		const ulong T_HARMFUL_TERRAIN = (ulong)terrainFlagCatalog.T_HARMFUL_TERRAIN;
		const ulong T_RESPIRATION_IMMUNITIES = (ulong)terrainFlagCatalog.T_RESPIRATION_IMMUNITIES;


		const ulong TM_IS_SECRET = (ulong)terrainMechanicalFlagCatalog.TM_IS_SECRET;
		const ulong TM_PROMOTES_WITH_KEY = (ulong)terrainMechanicalFlagCatalog.TM_PROMOTES_WITH_KEY;
		const ulong TM_PROMOTES_WITHOUT_KEY = (ulong)terrainMechanicalFlagCatalog.TM_PROMOTES_WITHOUT_KEY;
		const ulong TM_PROMOTES_ON_STEP = (ulong)terrainMechanicalFlagCatalog.TM_PROMOTES_ON_STEP;
		const ulong TM_PROMOTES_ON_ITEM_PICKUP = (ulong)terrainMechanicalFlagCatalog.TM_PROMOTES_ON_ITEM_PICKUP;
		const ulong TM_PROMOTES_ON_PLAYER_ENTRY = (ulong)terrainMechanicalFlagCatalog.TM_PROMOTES_ON_PLAYER_ENTRY;
		const ulong TM_PROMOTES_ON_ELECTRICITY = (ulong)terrainMechanicalFlagCatalog.TM_PROMOTES_ON_ELECTRICITY;
		const ulong TM_ALLOWS_SUBMERGING = (ulong)terrainMechanicalFlagCatalog.TM_ALLOWS_SUBMERGING;
		const ulong TM_IS_WIRED = (ulong)terrainMechanicalFlagCatalog.TM_IS_WIRED;
		const ulong TM_IS_CIRCUIT_BREAKER = (ulong)terrainMechanicalFlagCatalog.TM_IS_CIRCUIT_BREAKER;
		const ulong TM_GAS_DISSIPATES = (ulong)terrainMechanicalFlagCatalog.TM_GAS_DISSIPATES;
		const ulong TM_GAS_DISSIPATES_QUICKLY = (ulong)terrainMechanicalFlagCatalog.TM_GAS_DISSIPATES_QUICKLY;
		const ulong TM_EXTINGUISHES_FIRE = (ulong)terrainMechanicalFlagCatalog.TM_EXTINGUISHES_FIRE;
		const ulong TM_VANISHES_UPON_PROMOTION = (ulong)terrainMechanicalFlagCatalog.TM_VANISHES_UPON_PROMOTION;
		const ulong TM_REFLECTS_BOLTS = (ulong)terrainMechanicalFlagCatalog.TM_REFLECTS_BOLTS;
		const ulong TM_STAND_IN_TILE = (ulong)terrainMechanicalFlagCatalog.TM_STAND_IN_TILE;
		const ulong TM_LIST_IN_SIDEBAR = (ulong)terrainMechanicalFlagCatalog.TM_LIST_IN_SIDEBAR;
		const ulong TM_VISUALLY_DISTINCT = (ulong)terrainMechanicalFlagCatalog.TM_VISUALLY_DISTINCT;
		const ulong TM_BRIGHT_MEMORY = (ulong)terrainMechanicalFlagCatalog.TM_BRIGHT_MEMORY;
		const ulong TM_EXPLOSIVE_PROMOTE = (ulong)terrainMechanicalFlagCatalog.TM_EXPLOSIVE_PROMOTE;
		const ulong TM_CONNECTS_LEVEL = (ulong)terrainMechanicalFlagCatalog.TM_CONNECTS_LEVEL;
		const ulong TM_INTERRUPT_EXPLORATION_WHEN_SEEN = (ulong)terrainMechanicalFlagCatalog.TM_INTERRUPT_EXPLORATION_WHEN_SEEN;
		const ulong TM_INVERT_WHEN_HIGHLIGHTED = (ulong)terrainMechanicalFlagCatalog.TM_INVERT_WHEN_HIGHLIGHTED;
		const ulong TM_SWAP_ENCHANTS_ACTIVATION = (ulong)terrainMechanicalFlagCatalog.TM_SWAP_ENCHANTS_ACTIVATION;





		//#pragma mark Colors
		//									Red		Green	Blue	RedRand	GreenRand	BlueRand	Rand	Dances?
		// basic colors
		public static readonly color white =					new color(100,	100,	100,	0,		0,			0,			0,		false);
		public static readonly color gray =					new color(50,	50,		50,		0,		0,			0,			0,		false);
		public static readonly color darkGray =				new color(30,	30,		30,		0,		0,			0,			0,		false);
		public static readonly color veryDarkGray =			new color(15,	15,		15,		0,		0,			0,			0,		false);
		public static readonly color black =					new color(0,		0,		0,		0,		0,			0,			0,		false);
		public static readonly color yellow =				new color(100,	100,	0,		0,		0,			0,			0,		false);
		public static readonly color darkYellow =			new color(50,	50,		0,		0,		0,			0,			0,		false);
		public static readonly color teal =					new color(30,	100,	100,	0,		0,			0,			0,		false);
		public static readonly color purple =				new color(100,	0,		100,	0,		0,			0,			0,		false);
		public static readonly color darkPurple =			new color(50,	0,		50,		0,		0,			0,			0,		false);
		public static readonly color brown =					new color(60,	40,		0,		0,		0,			0,			0,		false);
		public static readonly color green =					new color(0,		100,	0,		0,		0,			0,			0,		false);
		public static readonly color darkGreen =				new color(0,		50,		0,		0,		0,			0,			0,		false);
		public static readonly color orange =				new color(100,	50,		0,		0,		0,			0,			0,		false);
		public static readonly color darkOrange =			new color(50,	25,		0,		0,		0,			0,			0,		false);
		public static readonly color blue =					new color(0,		0,		100,	0,		0,			0,			0,		false);
		public static readonly color darkBlue =				new color(0,		0,		50,		0,		0,			0,			0,		false);
		public static readonly color darkTurquoise =         new color(0,		40,		65,		0,		0,			0,			0,		false);
		public static readonly color lightBlue =				new color(40,	40,		100,	0,		0,			0,			0,		false);
		public static readonly color pink =					new color(100,	60,		66,		0,		0,			0,			0,		false);
		public static readonly color red  =					new color(100,	0,		0,		0,		0,			0,			0,		false);
		public static readonly color darkRed =				new color(50,	0,		0,		0,		0,			0,			0,		false);
		public static readonly color tanColor =				new color(80,	67,		15,		0,		0,			0,			0,		false);

		// bolt colors
		public static readonly color rainbow =				new color(-70,	-70,	-70,	170,	170,		170,		0,		true);
		public static readonly color descentBoltColor =      new color(-40,   -40,    -40,    0,      0,          80,         80,     true);
		public static readonly color discordColor =			new color(25,	0,		25,		66,		0,			0,			0,		true);
		public static readonly color poisonColor =			new color(0,		0,		0,		10,		50,			10,			0,		true);
		public static readonly color beckonColor =			new color(10,	10,		10,		5,		5,			5,			50,		true);
		public static readonly color invulnerabilityColor =	new color(25,	0,		25,		0,		0,			66,			0,		true);
		public static readonly color dominationColor =		new color(0,		0,		100,	80,		25,			0,			0,		true);
		public static readonly color empowermentColor =		new color(30,    100,	40,     25,		80,			25,			0,		true);
		public static readonly color fireBoltColor =			new color(500,	150,	0,		45,		30,			0,			0,		true);
		public static readonly color yendorLightColor =      new color(50,    -100,    30,     0,      0,          0,          0,      true);
		public static readonly color dragonFireColor =		new color(500,	150,	0,      45,		30,			45,			0,		true);
		public static readonly color flamedancerCoronaColor =new color(500,	150,	100,	45,		30,			0,			0,		true);
		//public static readonly color shieldingColor =		new color(100,	50,		0,		0,		50,			100,		0,		true);
		public static readonly color shieldingColor =		new color(150,	75,		0,		0,		50,			175,		0,		true);

		// tile colors
		public static readonly color undiscoveredColor =		new color(0,		0,		0,		0,		0,			0,			0,		false);

		public static readonly color wallForeColor =			new color(7,		7,		7,		3,		3,			3,			0,		false);

		public static readonly color wallBackColor = new color() ;
		public static readonly color wallBackColorStart =	new color(45,	40,		40,		15,		0,			5,			20,		false);
		public static readonly color wallBackColorEnd =		new color(40,	30,		35,		0,		20,			30,			20,		false);

		public static readonly color mudWallForeColor =      new color(55,	45,		0,		5,		5,			5,			1,		false);
		//public static readonly color mudWallForeColor =      new color(40,	34,		7,		0,		3,			0,			3,		false);
		public static readonly color mudWallBackColor =      new color(20,	12,		3,		8,		4,			3,			0,		false);

		public static readonly color graniteBackColor =		new color(10,	10,		10,		0,		0,			0,			0,		false);

		public static readonly color floorForeColor =		new color(30,	30,		30,		0,		0,			0,			35,		false);

		public static readonly color floorBackColor = new color() ;
		public static readonly color floorBackColorStart =	new color(2,		2,		10,		2,		2,			0,			0,		false);
		public static readonly color floorBackColorEnd =		new color(5,		5,		5,		2,		2,			0,			0,		false);

		public static readonly color stairsBackColor =		new color(15,	15,		5,		0,		0,			0,			0,		false);
		public static readonly color firstStairsBackColor =	new color(10,	10,		25,		0,		0,			0,			0,		false);

		public static readonly color refuseBackColor =		new color(6,		5,		3,		2,		2,			0,			0,		false);
		public static readonly color rubbleBackColor =		new color(7,		7,		8,		2,		2,			1,			0,		false);
		public static readonly color bloodflowerForeColor =  new color(30,    5,      40,     5,      1,          3,          0,      false);
		public static readonly color bloodflowerPodForeColor = new color(50,  5,      25,     5,      1,          3,          0,      false);
		public static readonly color bloodflowerBackColor =  new color(15,    3,      10,     3,      1,          3,          0,      false);
		public static readonly color bedrollBackColor =      new color(10,	8,		5,		1,		1,			0,			0,		false);

		public static readonly color obsidianBackColor =		new color(6,		0,		8,		2,		0,			3,			0,		false);
		public static readonly color carpetForeColor =		new color(23,	30,		38,		0,		0,			0,			0,		false);
		public static readonly color carpetBackColor =		new color(15,	8,		5,		0,		0,			0,			0,		false);
		public static readonly color marbleForeColor =		new color(30,	23,		38,		0,		0,			0,			0,		false);
		public static readonly color marbleBackColor =		new color(6,     5,		13,		1,		0,			1,			0,		false);
		public static readonly color doorForeColor =			new color(70,	35,		15,		0,		0,			0,			0,		false);
		public static readonly color doorBackColor =			new color(30,	10,		5,		0,		0,			0,			0,		false);
		//public static readonly color ironDoorForeColor =		new color(40,	40,		40,		0,		0,			0,			0,		false);
		public static readonly color ironDoorForeColor =		new color(500,	500,	500,	0,		0,			0,			0,		false);
		public static readonly color ironDoorBackColor =		new color(15,	15,		30,		0,		0,			0,			0,		false);
		public static readonly color bridgeFrontColor =		new color(33,	12,		12,		12,		7,			2,			0,		false);
		public static readonly color bridgeBackColor =		new color(12,	3,		2,		3,		2,			1,			0,		false);
		public static readonly color statueBackColor =		new color(20,	20,		20,		0,		0,			0,			0,		false);
		public static readonly color glyphColor =            new color(20,    5,      5,      50,     0,          0,          0,      true);
		public static readonly color glyphLightColor =       new color(150,   0,      0,      150,    0,          0,          0,      true);
		public static readonly color sacredGlyphColor =      new color(5,     20,     5,      0,      50,         0,          0,      true);
		public static readonly color sacredGlyphLightColor = new color(45,    150,	60,     25,		80,			25,			0,		true);

		//public static readonly color deepWaterForeColor =	new color(5,		5,		40,		0,		0,			10,			10,		true);
		//color deepWaterBackColor;
		//public static readonly color deepWaterBackColorStart = new color(5,	5,		55,		5,		5,			10,			10,		true);
		//public static readonly color deepWaterBackColorEnd =	new color(5,		5,		45,		2,		2,			5,			5,		true);
		//public static readonly color shallowWaterForeColor =	new color(40,	40,		90,		0,		0,			10,			10,		true);
		//color shallowWaterBackColor;
		//public static readonly color shallowWaterBackColorStart =new color(30,30,		80,		0,		0,			10,			10,		true);
		//public static readonly color shallowWaterBackColorEnd =new color(20,	20,		60,		0,		0,			5,			5,		true);

		public static readonly color deepWaterForeColor =	new color(5,		8,		20,		0,		4,			15,			10,		true);
		public static readonly color deepWaterBackColor = new color() ;
		public static readonly color deepWaterBackColorStart = new color(5,	10,		31,		5,		5,			5,			6,		true);
		public static readonly color deepWaterBackColorEnd =	new color(5,		8,		20,		2,		3,			5,			5,		true);
		public static readonly color shallowWaterForeColor =	new color(28,	28,		60,		0,		0,			10,			10,		true);
		public static readonly color shallowWaterBackColor = new color() ;
		public static readonly color shallowWaterBackColorStart =new color(20,20,		60,		0,		0,			10,			10,		true);
		public static readonly color shallowWaterBackColorEnd =new color(12,	15,		40,		0,		0,			5,			5,		true);

		public static readonly color mudForeColor =			new color(18,	14,		5,		5,		5,			0,			0,		false);
		public static readonly color mudBackColor =			new color(23,	17,		7,		5,		5,			0,			0,		false);
		public static readonly color chasmForeColor =		new color(7,		7,		15,		4,		4,			8,			0,		false);
		public static readonly color chasmEdgeBackColor = new color() ;
		public static readonly color chasmEdgeBackColorStart =new color(5,	5,		25,		2,		2,			2,			0,		false);
		public static readonly color chasmEdgeBackColorEnd =	new color(8,		8,		20,		2,		2,			2,			0,		false);
		public static readonly color fireForeColor =			new color(70,	20,		0,		15,		10,			0,			0,		true);
		public static readonly color lavaForeColor =			new color(20,	20,		20,		100,	10,			0,			0,		true);
		public static readonly color brimstoneForeColor =	new color(100,	50,		10,		0,		50,			40,			0,		true);
		public static readonly color brimstoneBackColor =	new color(18,	12,		9,		0,		0,			5,			0,		false);

		public static readonly color lavaBackColor =			new color(70,	20,		0,		15,		10,			0,			0,		true);
		public static readonly color acidBackColor =			new color(15,	80,		25,		5,		15,			10,			0,		true);

		public static readonly color lightningColor =		new color(100,	150,	500,	50,		50,			0,			50,		true);
		public static readonly color fungusLightColor =		new color(2,		11,		11,		4,		3,			3,			0,		true);
		public static readonly color lavaLightColor =		new color(47,	13,		0,		10,		7,			0,			0,		true);
		public static readonly color deepWaterLightColor =	new color(10,	30,		100,	0,		30,			100,		0,		true);

		public static readonly color grassColor =			new color(15,	40,		15,		15,		50,			15,			10,		false);
		public static readonly color deadGrassColor =		new color(20,	13,		0,		20,		10,			5,			10,		false);
		public static readonly color fungusColor =			new color(15,	50,		50,		0,		25,			0,			30,		true);
		public static readonly color grayFungusColor =		new color(30,	30,		30,		5,		5,			5,			10,		false);
		public static readonly color foliageColor =			new color(25,	100,	25,		15,		0,			15,			0,		false);
		public static readonly color deadFoliageColor =		new color(20,	13,		0,		30,		15,			0,			20,		false);
		public static readonly color lichenColor =			new color(50,	5,		25,		10,		0,			5,			0,		true);
		public static readonly color hayColor =				new color(70,	55,		5,		0,		20,			20,			0,		false);
		public static readonly color ashForeColor =			new color(20,	20,		20,		0,		0,			0,			20,		false);
		public static readonly color bonesForeColor =		new color(80,	80,		30,		5,		5,			35,			5,		false);
		public static readonly color ectoplasmColor =		new color(45,	20,		55,		25,		0,			25,			5,		false);
		public static readonly color forceFieldColor =		new color(0,		25,		25,		0,		25,			25,			0,		true);
		public static readonly color wallCrystalColor =		new color(40,	40,		60,		20,		20,			40,			0,		true);
		public static readonly color altarForeColor =		new color(5,		7,		9,		0,		0,			0,			0,		false);
		public static readonly color altarBackColor =		new color(35,	18,		18,		0,		0,			0,			0,		false);
		public static readonly color greenAltarBackColor =   new color(18,	25,		18,		0,		0,			0,			0,		false);
		public static readonly color goldAltarBackColor =    new color(25,	24,		12,		0,		0,			0,			0,		false);
		public static readonly color pedestalBackColor =		new color(10,	5,		20,		0,		0,			0,			0,		false);

		// monster colors
		public static readonly color goblinColor =			new color(40,	30,		20,		0,		0,			0,			0,		false);
		public static readonly color jackalColor =			new color(60,	42,		27,		0,		0,			0,			0,		false);
		public static readonly color ogreColor =				new color(60,	25,		25,		0,		0,			0,			0,		false);
		public static readonly color eelColor =				new color(30,	12,		12,		0,		0,			0,			0,		false);
		public static readonly color goblinConjurerColor =	new color(67,	10,		100,	0,		0,			0,			0,		false);
		public static readonly color spectralBladeColor =	new color(15,	15,		60,		0,		0,			70,			50,		true);
		public static readonly color spectralImageColor =	new color(13,	0,		0,		25,		0,			0,			0,		true);
		public static readonly color toadColor =				new color(40,	65,		30,		0,		0,			0,			0,		false);
		public static readonly color trollColor =			new color(40,	60,		15,		0,		0,			0,			0,		false);
		public static readonly color centipedeColor =		new color(75,	25,		85,		0,		0,			0,			0,		false);
		public static readonly color dragonColor =			new color(20,	80,		15,		0,		0,			0,			0,		false);
		public static readonly color krakenColor =			new color(100,	55,		55,		0,		0,			0,			0,		false);
		public static readonly color salamanderColor =		new color(40,	10,		0,		8,		5,			0,			0,		true);
		public static readonly color pixieColor =			new color(60,	60,		60,		40,		40,			40,			0,		true);
		public static readonly color darPriestessColor =		new color(0,		50,		50,		0,		0,			0,			0,		false);
		public static readonly color darMageColor =			new color(50,	50,		0,		0,		0,			0,			0,		false);
		public static readonly color wraithColor =			new color(66,	66,		25,		0,		0,			0,			0,		false);
		public static readonly color pinkJellyColor =		new color(100,	40,		40,		5,		5,			5,			20,		true);
		public static readonly color wormColor =				new color(80,	60,		40,		0,		0,			0,			0,		false);
		public static readonly color sentinelColor =			new color(3,		3,		30,		0,		0,			10,			0,		true);
		public static readonly color goblinMysticColor =		new color(10,	67,		100,	0,		0,			0,			0,		false);
		public static readonly color ifritColor =			new color(50,	10,		100,	75,		0,			20,			0,		true);
		public static readonly color phoenixColor =			new color(100,	0,		0,		0,		100,		0,			0,		true);

		// light colors
		public static readonly color minersLightColor = new color() ;
		public static readonly color minersLightStartColor =	new color(180,	180,	180,	0,		0,			0,			0,		false);
		public static readonly color minersLightEndColor =	new color(90,	90,		120,	0,		0,			0,			0,		false);
		public static readonly color torchColor =			new color(150,	75,		30,		0,		30,			20,			0,		true);
		public static readonly color torchLightColor =		new color(75,	38,		15,		0,		15,			7,			0,		true);
		//public static readonly color hauntedTorchColor =     new color(75,	30,		150,	30,		20,			0,			0,		true);
		public static readonly color hauntedTorchColor =     new color(75,	20,		40,     30,		10,			0,			0,		true);
		//public static readonly color hauntedTorchLightColor =new color(19,     7,		37,		8,		4,			0,			0,		true);
		public static readonly color hauntedTorchLightColor =new color(67,    10,		10,		20,		4,			0,			0,		true);
		public static readonly color ifritLightColor =		new color(0,		10,		150,	100,	0,			100,		0,		true);
		//public static readonly color unicornLightColor =		new color(-50,	-50,	-50,	200,	200,		200,		0,		true);
		public static readonly color unicornLightColor =		new color(-50,	-50,	-50,	250,	250,		250,		0,		true);
		public static readonly color wispLightColor =		new color(75,	100,	250,	33,		10,			0,			0,		true);
		public static readonly color summonedImageLightColor =new color(200,	0,		75,		0,		0,			0,			0,		true);
		public static readonly color spectralBladeLightColor =new color(40,	0,		230,	0,		0,			0,			0,		true);
		public static readonly color ectoplasmLightColor =	new color(23,	10,		28,		13,		0,			13,			3,		false);
		public static readonly color explosionColor =		new color(10,	8,		2,		0,		2,			2,			0,		true);
		public static readonly color explosiveAuraColor =	new color(2000,	0,      -1000,  200,    200,		0,          0,		true);
		public static readonly color dartFlashColor =		new color(500,	500,	500,	0,		2,			2,			0,		true);
		public static readonly color lichLightColor =		new color(-50,	80,		30,		0,		0,			20,			0,		true);
		public static readonly color forceFieldLightColor =	new color(10,	10,		10,		0,		50,			50,			0,		true);
		public static readonly color crystalWallLightColor =	new color(10,	10,		10,		0,		0,			50,			0,		true);
		public static readonly color sunLightColor =			new color(100,	100,	75,		0,		0,			0,			0,		false);
		public static readonly color fungusForestLightColor =new color(30,	40,		60,		0,		0,			0,			40,		true);
		public static readonly color fungusTrampledLightColor =new color(10,	10,		10,		0,		50,			50,			0,		true);
		public static readonly color redFlashColor =			new color(100,	10,		10,		0,		0,			0,			0,		false);
		public static readonly color darknessPatchColor =	new color(-10,	-10,	-10,	0,		0,			0,			0,		false);
		public static readonly color darknessCloudColor =	new color(-20,	-20,	-20,	0,		0,			0,			0,		false);
		public static readonly color magicMapFlashColor =	new color(60,	20,		60,		0,		0,			0,			0,		false);
		public static readonly color sentinelLightColor =	new color(20,	20,		120,	10,		10,			60,			0,		true);
		public static readonly color telepathyColor =		new color(30,	30,		130,	0,		0,			0,			0,		false);
		public static readonly color confusionLightColor =	new color(10,	10,		10,		10,		10,			10,			0,		true);
		public static readonly color portalActivateLightColor =new color(300,	400,	500,	0,		0,			0,			0,		true);
		public static readonly color descentLightColor =     new color(20,    20,     70,     0,      0,          0,          0,      false);
		public static readonly color algaeBlueLightColor =   new color(20,    15,     50,     0,      0,          0,          0,      false);
		public static readonly color algaeGreenLightColor =  new color(15,    50,     20,     0,      0,          0,          0,      false);

		// flare colors
		public static readonly color scrollProtectionColor =	new color(375,	750,	0,		0,		0,			0,          0,		true);
		public static readonly color scrollEnchantmentColor =new color(250,	225,	300,	0,		0,			450,        0,		true);
		public static readonly color potionStrengthColor =   new color(1000,  0,      400,	600,	0,			0,          0,		true);
		public static readonly color empowermentFlashColor = new color(500,   1000,   600,	0,      500,		0,          0,		true);
		public static readonly color genericFlashColor =     new color(800,   800,    800,    0,      0,          0,          0,      false);
		public static readonly color summoningFlashColor =   new color(0,     0,      0,      600,    0,          1200,       0,      true);
		public static readonly color fireFlashColor =		new color(750,	225,	0,		100,	50,			0,			0,		true);
		public static readonly color explosionFlareColor =   new color(10000, 6000,   1000,   0,      0,          0,          0,      false);
		public static readonly color quietusFlashColor =     new color(0,     -1000,  -200,   0,      0,          0,          0,      true);
		public static readonly color slayingFlashColor =     new color(-1000, -200,   0,      0,      0,          0,          0,      true);

		// color multipliers
		public static readonly color colorDim25 =			new color(25,	25,		25,		25,		25,			25,			25,		false);
		public static readonly color colorMultiplier100 =	new color(100,	100,	100,	100,	100,		100,		100,	false);
		public static readonly color memoryColor =			new color(25,	25,		50,		20,		20,			20,			0,		false);
		public static readonly color memoryOverlay =			new color(25,	25,		50,		0,		0,			0,			0,		false);
		public static readonly color magicMapColor =			new color(60,	20,		60,		60,		20,			60,			0,		false);
		public static readonly color clairvoyanceColor =		new color(50,	90,		50,		50,		90,			50,			66,		false);
		public static readonly color telepathyMultiplier =	new color(30,	30,		130,	30,		30,			130,		66,		false);
		public static readonly color omniscienceColor =		new color(140,	100,	60,		140,	100,		60,			90,		false);
		public static readonly color basicLightColor =		new color(180,	180,	180,	180,	180,		180,		180,	false);

		// blood colors
		public static readonly color humanBloodColor =		new color(60,	20,		10,		15,		0,			0,			15,		false);
		public static readonly color insectBloodColor =		new color(10,	60,		20,		0,		15,			0,			15,		false);
		public static readonly color vomitColor =			new color(60,	50,		5,		0,		15,			15,			0,		false);
		public static readonly color urineColor =			new color(70,	70,		40,		0,		0,			0,			10,		false);
		public static readonly color methaneColor =			new color(45,	60,		15,		0,		0,			0,			0,		false);

		// gas colors
		public static readonly color poisonGasColor =		new color(75,	25,		85,		0,		0,			0,			0,		false);
		public static readonly color confusionGasColor =		new color(60,	60,		60,		40,		40,			40,			0,		true);

		// interface colors
		public static readonly color itemColor =				new color(100,	95,		-30,	0,		0,			0,			0,		false);
		public static readonly color blueBar =				new color(15,	10,		50,		0,		0,			0,			0,		false);
		public static readonly color redBar =				new color(45,	10,		15,		0,		0,			0,			0,		false);
		public static readonly color hiliteColor =			new color(100,	100,	0,		0,		0,			0,			0,		false);
		public static readonly color interfaceBoxColor =		new color(7,		6,		15,		0,		0,			0,			0,		false);
		public static readonly color interfaceButtonColor =	new color(18,	15,		38,		0,		0,			0,			0,		false);
		public static readonly color buttonHoverColor =		new color(100,	70,		40,		0,		0,			0,			0,		false);
		public static readonly color titleButtonColor =		new color(23,	15,		30,		0,		0,			0,			0,		false);

		public static readonly color playerInvisibleColor =  new color(20,    20,     30,     0,      0,          80,         0,      true);
		public static readonly color playerInLightColor =	new color(100,	90,     30,		0,		0,			0,			0,		false);
		public static readonly color playerInShadowColor =	new color(60,	60,		100,	0,		0,			0,			0,		false);
		public static readonly color playerInDarknessColor =	new color(30,	30,		65,		0,		0,			0,			0,		false);

		public static readonly color inLightMultiplierColor =new color(150,   150,    75,     150,    150,        75,         100,    true);
		public static readonly color inDarknessMultiplierColor=new color(66,  66,     120,    66,     66,         120,        66,     true);

		public static readonly color goodMessageColor =		new color(60,	50,		100,	0,		0,			0,			0,		false);
		public static readonly color badMessageColor =		new color(100,	50,		60,		0,		0,			0,			0,		false);
		public static readonly color advancementMessageColor =new color(50,	100,	60,		0,		0,			0,			0,		false);
		public static readonly color itemMessageColor =		new color(100,	100,	50,		0,		0,			0,			0,		false);
		public static readonly color flavorTextColor =		new color(50,	40,		90,		0,		0,			0,			0,		false);
		public static readonly color backgroundMessageColor =new color(60,	20,		70,		0,		0,			0,			0,		false);

		public static readonly color superVictoryColor =     new color(150,	100,	300,	0,		0,			0,			0,		false);

		//public static readonly color flameSourceColor = new color(0, 0, 0, 65, 40, 100, 0, true); // 1
		//public static readonly color flameSourceColor = new color(0, 0, 0, 80, 50, 100, 0, true); // 2
		//public static readonly color flameSourceColor = new color(25, 13, 25, 50, 25, 50, 0, true); // 3
		//public static readonly color flameSourceColor = new color(20, 20, 20, 60, 20, 40, 0, true); // 4
		//public static readonly color flameSourceColor = new color(30, 18, 18, 70, 36, 36, 0, true); // 7**
		public static readonly color flameSourceColor = new color(20, 7, 7, 60, 40, 40, 0, true); // 8
		public static readonly color flameSourceColorSecondary = new color(7, 2, 0, 10, 0, 0, 0, true);

		//public static readonly color flameTitleColor = new color(0, 0, 0, 17, 10, 6, 0, true); // pale orange
		//public static readonly color flameTitleColor = new color(0, 0, 0, 7, 7, 10, 0, true); // *pale blue*
		public static readonly color flameTitleColor = new color(0, 0, 0, 9, 9, 15, 0, true); // *pale blue**
		//public static readonly color flameTitleColor = new color(0, 0, 0, 11, 11, 18, 0, true); // *pale blue*
		//public static readonly color flameTitleColor = new color(0, 0, 0, 15, 15, 9, 0, true); // pale yellow
		//public static readonly color flameTitleColor = new color(0, 0, 0, 15, 9, 15, 0, true); // pale purple

		// end color definition

		//--------------------------------------------------

		// [NUMBER_DYNAMIC_COLORS][3]
		public color[, ]dynamicColors = {
			// used color			shallow color				deep color
			{minersLightColor,		minersLightStartColor,		minersLightEndColor},
			{wallBackColor,		wallBackColorStart,		wallBackColorEnd},
			{deepWaterBackColor,	deepWaterBackColorStart,	deepWaterBackColorEnd},
			{shallowWaterBackColor,shallowWaterBackColorStart,shallowWaterBackColorEnd},
			{floorBackColor,		floorBackColorStart,		floorBackColorEnd},
			{chasmEdgeBackColor,	chasmEdgeBackColorStart,	chasmEdgeBackColorEnd},
		};


		// display characters:

		#if USE_UNICODE

		public const char FLOOR_CHAR = (char)0x00b7 ;
		public const char LIQUID_CHAR = (char)'~' ;
		public const char CHASM_CHAR = (char)0x2237 ;
		public const char TRAP_CHAR = (char)0x25c7 ;
		public const char FIRE_CHAR = (char)0x22CF ;
		public const char GRASS_CHAR = (char)'"' ;
		public const char BRIDGE_CHAR = (char)'=' ;
		public const char DESCEND_CHAR = (char)'>' ;
		public const char ASCEND_CHAR = (char)'<' ;
		public const char WALL_CHAR = (char)'#' ;
		public const char DOOR_CHAR = (char)'+' ;
		public const char OPEN_DOOR_CHAR = (char)'\'' ;
		public const char ASH_CHAR = (char)'\'' ;
		public const char BONES_CHAR = (char)',' ;
		public const char MUD_CHAR = (char)',' ;
		public const char WEB_CHAR = (char)':' ;
		//public const char FOLIAGE_CHAR = (char)0x03A8 ; // lower-case psi
		public const char FOLIAGE_CHAR = (char)0x2648 ; // Aries symbol
		public const char VINE_CHAR = (char)':' ;
		public const char ALTAR_CHAR = (char)'|' ;
		public const char LEVER_CHAR = (char)'/' ;
		public const char LEVER_PULLED_CHAR = (char)'\\' ;
		public const char STATUE_CHAR = (char)0x00df ;
		public const char VENT_CHAR = (char)'=' ;
		public const char DEWAR_CHAR = (char)'&' ;

		public const char TRAMPLED_FOLIAGE_CHAR = (char)'"' ;		// 0x2034 // 0x2037

		public const char PLAYER_CHAR = (char)'@' ;

		public const char AMULET_CHAR = (char)0x2640 ;
		public const char FOOD_CHAR = (char)';' ;
		public const char SCROLL_CHAR = (char)0x266A; //'?' 		// 0x039E
		//public const char RING_CHAR = (char)0x26AA ; //0xffee
		public const char RING_CHAR = (char)0xffee ;
		public const char CHARM_CHAR = (char)0x03DE ;
		public const char POTION_CHAR = (char)'!' ;
		public const char ARMOR_CHAR = (char)'[' ;
		public const char WEAPON_CHAR = (char)0x2191 ;
		public const char STAFF_CHAR = (char)'\\' ;
		public const char WAND_CHAR = (char)'~' ;
		public const char GOLD_CHAR = (char)'*' ;
		public const char GEM_CHAR = (char)0x25cf ;
		public const char TOTEM_CHAR = (char)0x26b2 ;
		public const char TURRET_CHAR = (char)0x25cf ;
		public const char UNICORN_CHAR = (char)0x00da ;
		public const char KEY_CHAR = (char)'-' ;
		public const char ELECTRIC_CRYSTAL_CHAR = (char)164 ;

		public const char UP_ARROW_CHAR = (char)0x2191 ;
		public const char DOWN_ARROW_CHAR = (char)0x2193 ;
		public const char LEFT_ARROW_CHAR = (char)0x2190 ;
		public const char RIGHT_ARROW_CHAR = (char)0x2192 ;
		public const char UP_TRIANGLE_CHAR = (char)0x2206 ;
		public const char DOWN_TRIANGLE_CHAR = (char)0x2207 ;
		public const char OMEGA_CHAR = (char)0x03A9 ;
		public const char THETA_CHAR = (char)0x03B8 ;
		public const char LAMDA_CHAR = (char)0x03BB ;
		public const char KOPPA_CHAR = (char)0x03DF  ;//0x03DE
		public const char LOZENGE_CHAR = (char)0x29EB ;
		public const char CROSS_PRODUCT_CHAR = (char)0x2A2F ;

		public const char CHAIN_TOP_LEFT = (char)'\\' ;
		public const char CHAIN_BOTTOM_RIGHT = (char)'\\' ;
		public const char CHAIN_TOP_RIGHT = (char)'/' ;
		public const char CHAIN_BOTTOM_LEFT = (char)'/' ;
		public const char CHAIN_TOP = (char)'|' ;
		public const char CHAIN_BOTTOM = (char)'|' ;
		public const char CHAIN_LEFT = (char)'-' ;
		public const char CHAIN_RIGHT = (char)'-' ;

		public const char BAD_MAGIC_CHAR = (char)0x29F2 ;
		public const char GOOD_MAGIC_CHAR = (char)0x29F3 ;

		#else

		public const char FLOOR_CHAR = (char)'.' ;
		public const char LIQUID_CHAR = (char)'~' ;
		public const char CHASM_CHAR = (char)':' ;
		public const char TRAP_CHAR = (char)'%' ;
		public const char FIRE_CHAR = (char)'^' ;
		public const char GRASS_CHAR = (char)'"' ;
		public const char BRIDGE_CHAR = (char)'=' ;
		public const char DESCEND_CHAR = (char)'>' ;
		public const char ASCEND_CHAR = (char)'<' ;
		public const char WALL_CHAR = (char)'#' ;
		public const char DOOR_CHAR = (char)'+' ;
		public const char OPEN_DOOR_CHAR = (char)'\'' ;
		public const char ASH_CHAR = (char)'\'' ;
		public const char BONES_CHAR = (char)',' ;
		public const char MUD_CHAR = (char)',' ;
		public const char WEB_CHAR = (char)':' ;
		public const char FOLIAGE_CHAR = (char)'&' ;
		public const char VINE_CHAR = (char)':' ;
		public const char ALTAR_CHAR = (char)'|' ;
		public const char LEVER_CHAR = (char)'/' ;
		public const char LEVER_PULLED_CHAR = (char)'\\' ;
		public const char STATUE_CHAR = (char)'&' ;
		public const char VENT_CHAR = (char)'=' ;
		public const char DEWAR_CHAR = (char)'&' ;

		public const char TRAMPLED_FOLIAGE_CHAR = (char)'"' ;

		public const char PLAYER_CHAR = (char)'@' ;

		public const char AMULET_CHAR = (char)',' ;
		public const char FOOD_CHAR = (char)';' ;
		public const char SCROLL_CHAR = (char)'?' ;
		public const char RING_CHAR = (char)'=' ;
		public const char CHARM_CHAR = (char)'+' ;
		public const char POTION_CHAR = (char)'!' ;
		public const char ARMOR_CHAR = (char)'[' ;
		public const char WEAPON_CHAR = (char)'(' ;
		public const char STAFF_CHAR = (char)'\\' ;
		public const char WAND_CHAR = (char)'~' ;
		public const char GOLD_CHAR = (char)'*' ;
		public const char GEM_CHAR = (char)'+' ;
		public const char TOTEM_CHAR = (char)'0' ;
		public const char TURRET_CHAR = (char)'*' ;
		public const char UNICORN_CHAR = (char)'U' ;
		public const char KEY_CHAR = (char)'-' ;
		public const char ELECTRIC_CRYSTAL_CHAR = (char)'$' ;

		public const char UP_ARROW_CHAR = (char)'^' ;
		public const char DOWN_ARROW_CHAR = (char)'v' ;
		public const char LEFT_ARROW_CHAR = (char)'<' ;
		public const char RIGHT_ARROW_CHAR = (char)'>' ;
		public const char UP_TRIANGLE_CHAR = (char)'^' ;
		public const char DOWN_TRIANGLE_CHAR = (char)'v' ;
		public const char OMEGA_CHAR = (char)'^' ;
		public const char THETA_CHAR = (char)'0' ;
		public const char LAMDA_CHAR = (char)'\\' ;
		public const char KOPPA_CHAR = (char)'k' ;
		public const char LOZENGE_CHAR = (char)'+' ;
		public const char CROSS_PRODUCT_CHAR = (char)'x' ;

		public const char CHAIN_TOP_LEFT = (char)'\\' ;
		public const char CHAIN_BOTTOM_RIGHT = (char)'\\' ;
		public const char CHAIN_TOP_RIGHT = (char)'/' ;
		public const char CHAIN_BOTTOM_LEFT = (char)'/' ;
		public const char CHAIN_TOP = (char)'|' ;
		public const char CHAIN_BOTTOM = (char)'|' ;
		public const char CHAIN_LEFT = (char)'-' ;
		public const char CHAIN_RIGHT = (char)'-' ;

		public const char BAD_MAGIC_CHAR = (char)'+' ;
		public const char GOOD_MAGIC_CHAR = (char)'$' ;

		#endif


		//--------------------------------------------------

		// Features in the gas layer use the startprob as volume, ignore probdecr, and spawn in only a single point.
		// Intercepts and slopes are in units of 0.01.
		public dungeonFeature[] dungeonFeatureCatalog =  {
			// tileType					layer		start	decr	fl	txt  flare   fCol fRad	propTerrain	subseqDF
			new dungeonFeature(0), // nothing
			new dungeonFeature(GRANITE,					DUNGEON,	80,		70,		DFF_CLEAR_OTHER_TERRAIN),
			new dungeonFeature(CRYSTAL_WALL,				DUNGEON,	200,	50,		DFF_CLEAR_OTHER_TERRAIN),
			new dungeonFeature(LUMINESCENT_FUNGUS,		SURFACE,	60,		8,		DFF_BLOCKED_BY_OTHER_LAYERS),
			new dungeonFeature(GRASS,						SURFACE,	75,		5,		DFF_BLOCKED_BY_OTHER_LAYERS),
			new dungeonFeature(DEAD_GRASS,				SURFACE,	75,		5,		DFF_BLOCKED_BY_OTHER_LAYERS,	"", 0,	null,	0,		0,			DF_DEAD_FOLIAGE),
			new dungeonFeature(BONES,						SURFACE,	75,		23,		0),
			new dungeonFeature(RUBBLE,					SURFACE,	45,		23,		0),
			new dungeonFeature(FOLIAGE,					SURFACE,	100,	33,		(DFF_BLOCKED_BY_OTHER_LAYERS)),
			new dungeonFeature(FUNGUS_FOREST,				SURFACE,	100,	45,		(DFF_BLOCKED_BY_OTHER_LAYERS)),
			new dungeonFeature(DEAD_FOLIAGE,				SURFACE,	50,		30,		(DFF_BLOCKED_BY_OTHER_LAYERS)),

			// misc. liquids
			new dungeonFeature(SUNLIGHT_POOL,				LIQUID,		65,		6,		0),
			new dungeonFeature(DARKNESS_PATCH,			LIQUID,		65,		11,		0),

			// Dungeon features spawned during gameplay:

			// revealed secrets
			new dungeonFeature(DOOR,						DUNGEON,	0,		0,		0, "", GENERIC_FLASH_LIGHT),
			new dungeonFeature(GAS_TRAP_POISON,			DUNGEON,	0,		0,		0, "", GENERIC_FLASH_LIGHT),
			new dungeonFeature(GAS_TRAP_PARALYSIS,		DUNGEON,	0,		0,		0, "", GENERIC_FLASH_LIGHT),
			new dungeonFeature(CHASM_EDGE,				LIQUID,		100,	100,	0, "", GENERIC_FLASH_LIGHT),
			new dungeonFeature(TRAP_DOOR,					LIQUID,		0,		0,		DFF_CLEAR_OTHER_TERRAIN, "", GENERIC_FLASH_LIGHT, null, 0, 0, DF_SHOW_TRAPDOOR_HALO),
			new dungeonFeature(GAS_TRAP_CONFUSION,		DUNGEON,	0,		0,		0, "", GENERIC_FLASH_LIGHT),
			new dungeonFeature(FLAMETHROWER,				DUNGEON,	0,		0,		0, "", GENERIC_FLASH_LIGHT),
			new dungeonFeature(FLOOD_TRAP,				DUNGEON,	0,		0,		0, "", GENERIC_FLASH_LIGHT),
			new dungeonFeature(NET_TRAP,                  DUNGEON,	0,		0,		0, "", GENERIC_FLASH_LIGHT),
			new dungeonFeature(ALARM_TRAP,                DUNGEON,	0,		0,		0, "", GENERIC_FLASH_LIGHT),

			// bloods
			// Start probability is actually a percentage for bloods.
			// Base probability is 15 + (damage * 2/3), and then take the given percentage of that.
			// If it's a gas, we multiply the base by an additional 100.
			// Thus to get a starting gas volume of a poison potion (1000), with a hit for 10 damage, use a starting probability of 48.
			new dungeonFeature(RED_BLOOD,					SURFACE,	100,	25,		0),
			new dungeonFeature(GREEN_BLOOD,				SURFACE,	100,	25,		0),
			new dungeonFeature(PURPLE_BLOOD,				SURFACE,	100,	25,		0),
			new dungeonFeature(WORM_BLOOD,				SURFACE,	100,	25,		0),
			new dungeonFeature(ACID_SPLATTER,				SURFACE,	200,	25,		0),
			new dungeonFeature(ASH,						SURFACE,	50,		25,		0),
			new dungeonFeature(EMBERS,					SURFACE,	125,	25,		0),
			new dungeonFeature(ECTOPLASM,					SURFACE,	110,	25,		0),
			new dungeonFeature(RUBBLE,					SURFACE,	33,		25,		0),
			new dungeonFeature(ROT_GAS,					GAS,		12,		0,		0),

			// monster effects
			new dungeonFeature(VOMIT,						SURFACE,	30,		10,		0),
			new dungeonFeature(POISON_GAS,				GAS,		2000,	0,		0),
			new dungeonFeature(GAS_EXPLOSION,				SURFACE,	350,	100,	0,	"", EXPLOSION_FLARE_LIGHT),
			new dungeonFeature(RED_BLOOD,					SURFACE,	150,	30,		0),
			new dungeonFeature(FLAMEDANCER_FIRE,			SURFACE,	200,	75,		0),

			// mutation effects
			new dungeonFeature(GAS_EXPLOSION,				SURFACE,	350,	100,	0,	"The corpse detonates with terrifying force!", EXPLOSION_FLARE_LIGHT),
			new dungeonFeature(LICHEN,					SURFACE,	70,		60,		0,  "Poisonous spores burst from the corpse!"),

			// misc
			new dungeonFeature(NOTHING,					GAS,		0,		0,		DFF_EVACUATE_CREATURES_FIRST),
			new dungeonFeature(ROT_GAS,					GAS,		15,		0,		0),
			new dungeonFeature(STEAM,						GAS,		325,	0,		0),
			new dungeonFeature(STEAM,						GAS,		15,		0,		0),
			new dungeonFeature(METHANE_GAS,				GAS,		2,		0,		0),
			new dungeonFeature(EMBERS,					SURFACE,	0,		0,		0),
			new dungeonFeature(URINE,						SURFACE,	65,		25,		0),
			new dungeonFeature(UNICORN_POOP,				SURFACE,	65,		40,		0),
			new dungeonFeature(PUDDLE,					SURFACE,	13,		25,		0),
			new dungeonFeature(ASH,						SURFACE,	0,		0,		0),
			new dungeonFeature(ECTOPLASM,					SURFACE,	0,		0,		0),
			new dungeonFeature(FORCEFIELD,				SURFACE,	100,	50,		0),
			new dungeonFeature(FORCEFIELD_MELT,           SURFACE,    0,      0,      0),
			new dungeonFeature(SACRED_GLYPH,              LIQUID,     100,    100,    0,  "", EMPOWERMENT_LIGHT),
			new dungeonFeature(LICHEN,					SURFACE,	2,		100,	(DFF_BLOCKED_BY_OTHER_LAYERS)), // Lichen won't spread through lava.
			new dungeonFeature(RUBBLE,					SURFACE,	45,		23,		(DFF_ACTIVATE_DORMANT_MONSTER)),
			new dungeonFeature(RUBBLE,					SURFACE,	0,		0,		(DFF_ACTIVATE_DORMANT_MONSTER)),

			new dungeonFeature(SPIDERWEB,                 SURFACE,    15,     12,     0),
			new dungeonFeature(SPIDERWEB,                 SURFACE,    100,    39,     0),

			new dungeonFeature(ANCIENT_SPIRIT_VINES,      SURFACE,    75,     70,     0),
			new dungeonFeature(ANCIENT_SPIRIT_GRASS,      SURFACE,    50,     47,     0),

			// foliage
			new dungeonFeature(TRAMPLED_FOLIAGE,			SURFACE,	0,		0,		0),
			new dungeonFeature(DEAD_GRASS,				SURFACE,	75,		75,		0),
			new dungeonFeature(FOLIAGE,					SURFACE,	0,		0,		(DFF_BLOCKED_BY_OTHER_LAYERS)),
			new dungeonFeature(TRAMPLED_FUNGUS_FOREST,	SURFACE,	0,		0,		0),
			new dungeonFeature(FUNGUS_FOREST,				SURFACE,	0,		0,		(DFF_BLOCKED_BY_OTHER_LAYERS)),

			// brimstone
			new dungeonFeature(ACTIVE_BRIMSTONE,			LIQUID,		0,		0,		0),
			new dungeonFeature(INERT_BRIMSTONE,			LIQUID,		0,		0,		0,	"", 0,	null,	0,		0,			DF_BRIMSTONE_FIRE),

			// bloodwort
			new dungeonFeature(BLOODFLOWER_POD,           SURFACE,    60,     60,     DFF_EVACUATE_CREATURES_FIRST),
			new dungeonFeature(BLOODFLOWER_POD,           SURFACE,    10,     10,     DFF_EVACUATE_CREATURES_FIRST),
			new dungeonFeature(HEALING_CLOUD,				GAS,		350,	0,		0),

			// dewars
			new dungeonFeature(POISON_GAS,                GAS,        20000,  0,      0, "the dewar shatters and pressurized caustic gas explodes outward!", 0, poisonGasColor, 4, 0, DF_DEWAR_GLASS),
			new dungeonFeature(CONFUSION_GAS,             GAS,        20000,  0,      0, "the dewar shatters and pressurized confusion gas explodes outward!", 0, confusionGasColor, 4, 0, DF_DEWAR_GLASS),
			new dungeonFeature(PARALYSIS_GAS,             GAS,        20000,  0,      0, "the dewar shatters and pressurized paralytic gas explodes outward!", 0, pink, 4, 0, DF_DEWAR_GLASS),
			new dungeonFeature(METHANE_GAS,               GAS,        20000,  0,      0, "the dewar shatters and pressurized methane gas explodes outward!", 0, methaneColor, 4, 0, DF_DEWAR_GLASS),
			new dungeonFeature(BROKEN_GLASS,              SURFACE,    100,    70,     0),
			new dungeonFeature(CARPET,                    DUNGEON,    120,    20,     0),

			// algae
			new dungeonFeature(DEEP_WATER_ALGAE_WELL,     DUNGEON,    0,      0,      DFF_SUPERPRIORITY),
			new dungeonFeature(DEEP_WATER_ALGAE_1,		LIQUID,		50,		100,	0,  "", 0,  null,   0,     DEEP_WATER, DF_ALGAE_2),
			new dungeonFeature(DEEP_WATER_ALGAE_2,        LIQUID,     0,      0,      0),
			new dungeonFeature(DEEP_WATER,                LIQUID,     0,      0,      DFF_SUPERPRIORITY),

			// doors, item cages, altars, glyphs, guardians -- reusable machine components
			new dungeonFeature(OPEN_DOOR,					DUNGEON,	0,		0,		0),
			new dungeonFeature(DOOR,						DUNGEON,	0,		0,		0),
			new dungeonFeature(OPEN_IRON_DOOR_INERT,		DUNGEON,	0,		0,		0,  "", GENERIC_FLASH_LIGHT),
			new dungeonFeature(ALTAR_CAGE_OPEN,			DUNGEON,	0,		0,		0,	"the cages lift off of the altars as you approach.", GENERIC_FLASH_LIGHT),
			new dungeonFeature(ALTAR_CAGE_CLOSED,			DUNGEON,	0,		0,		(DFF_EVACUATE_CREATURES_FIRST), "the cages lower to cover the altars.", GENERIC_FLASH_LIGHT),
			new dungeonFeature(ALTAR_INERT,				DUNGEON,	0,		0,		0),
			new dungeonFeature(FLOOR_FLOODABLE,			DUNGEON,	0,		0,		0,	"the altar retracts into the ground with a grinding sound.", GENERIC_FLASH_LIGHT),
			new dungeonFeature(PORTAL_LIGHT,				SURFACE,	0,		0,		(DFF_EVACUATE_CREATURES_FIRST | DFF_ACTIVATE_DORMANT_MONSTER), "the archway flashes, and you catch a glimpse of another world!"),
			new dungeonFeature(MACHINE_GLYPH_INACTIVE,    DUNGEON,    0,      0,      0),
			new dungeonFeature(MACHINE_GLYPH,             DUNGEON,    0,      0,      0),
			new dungeonFeature(GUARDIAN_GLOW,             SURFACE,    0,      0,      0,  ""),
			new dungeonFeature(GUARDIAN_GLOW,             SURFACE,    0,      0,      0,  "the glyph beneath you glows, and the guardians take a step!"),
			new dungeonFeature(GUARDIAN_GLOW,             SURFACE,    0,      0,      0,  "the mirrored totem flashes, reflecting the red glow of the glyph beneath you."),
			new dungeonFeature(MACHINE_GLYPH,             DUNGEON,    200,    95,     DFF_BLOCKED_BY_OTHER_LAYERS),
			new dungeonFeature(WALL_LEVER,                DUNGEON,    0,      0,      0,  "you notice a lever hidden behind a loose stone in the wall.", GENERIC_FLASH_LIGHT),
			new dungeonFeature(WALL_LEVER_PULLED,         DUNGEON,    0,      0,      0),
			new dungeonFeature(WALL_LEVER_HIDDEN,         DUNGEON,    0,      0,      0),

			new dungeonFeature(BRIDGE_FALLING,            LIQUID,     200,    100,    0, "", 0, null, 0, BRIDGE),
			new dungeonFeature(CHASM,                     LIQUID,     0,      0,      0, "", GENERIC_FLASH_LIGHT, null, 0, 0, DF_BRIDGE_FALL_PREP),

			// fire
			new dungeonFeature(PLAIN_FIRE,				SURFACE,	0,		0,		0),
			new dungeonFeature(GAS_FIRE,					SURFACE,	0,		0,		0),
			new dungeonFeature(GAS_EXPLOSION,				SURFACE,	60,		17,		0),
			new dungeonFeature(DART_EXPLOSION,			SURFACE,	0,		0,		0),
			new dungeonFeature(BRIMSTONE_FIRE,			SURFACE,	0,		0,		0),
			new dungeonFeature(0,                         0,          0,		0,		0,	"the rope bridge snaps from the heat and plunges into the chasm!", FALLEN_TORCH_FLASH_LIGHT,	null,	0,		0,		DF_BRIDGE_FALL),
			new dungeonFeature(PLAIN_FIRE,				SURFACE,	100,	37,		0),
			new dungeonFeature(EMBERS,					SURFACE,	0,		0,		0),
			new dungeonFeature(EMBERS,					SURFACE,	100,	94,		0),
			new dungeonFeature(OBSIDIAN,					SURFACE,	0,		0,		0),
			new dungeonFeature(ITEM_FIRE,                 SURFACE,    0,      0,      0,  "", FALLEN_TORCH_FLASH_LIGHT),
			new dungeonFeature(CREATURE_FIRE,             SURFACE,    0,      0,      0,  "", FALLEN_TORCH_FLASH_LIGHT),

			new dungeonFeature(FLOOD_WATER_SHALLOW,		SURFACE,	225,	37,		0,	"", 0,	null,	0,		0,			DF_FLOOD_2),
			new dungeonFeature(FLOOD_WATER_DEEP,			SURFACE,	175,	37,		0,	"the area is flooded as water rises through imperceptible holes in the ground."),
			new dungeonFeature(FLOOD_WATER_SHALLOW,		SURFACE,	10,		25,		0),
			new dungeonFeature(HOLE,						SURFACE,	200,	100,	0),
			new dungeonFeature(HOLE_EDGE,					SURFACE,	0,		0,		0),

			// gas trap effects
			new dungeonFeature(POISON_GAS,				GAS,		1000,	0,		0,	"a cloud of caustic gas sprays upward from the floor!"),
			new dungeonFeature(CONFUSION_GAS,				GAS,		300,	0,		0,	"a sparkling cloud of confusion gas sprays upward from the floor!"),
			new dungeonFeature(NETTING,                   SURFACE,    300,    90,     0,  "a net falls from the ceiling!"),
			new dungeonFeature(0,                         0,          0,      0,      DFF_AGGRAVATES_MONSTERS, "a piercing shriek echoes through the nearby rooms!", 0, null, DCOLS/2),
			new dungeonFeature(METHANE_GAS,				GAS,		10000,	0,		0), // debugging toy

			// potions
			new dungeonFeature(POISON_GAS,				GAS,		1000,	0,		0,	"", 0,	poisonGasColor,4),
			new dungeonFeature(PARALYSIS_GAS,				GAS,		1000,	0,		0,	"", 0,	pink,4),
			new dungeonFeature(CONFUSION_GAS,				GAS,		1000,	0,		0,	"", 0,	confusionGasColor, 4),
			new dungeonFeature(PLAIN_FIRE,				SURFACE,	100,	37,		0,	"", EXPLOSION_FLARE_LIGHT),
			new dungeonFeature(DARKNESS_CLOUD,			GAS,		200,	0,		0),
			new dungeonFeature(HOLE_EDGE,					SURFACE,	300,	100,	0,	"", 0,	darkBlue,3,0,			DF_HOLE_2),
			new dungeonFeature(LICHEN,					SURFACE,	70,		60,		0),

			// other items
			new dungeonFeature(PLAIN_FIRE,				SURFACE,	100,	45,		0,	"", 0,	yellow,3),
			new dungeonFeature(HOLE_GLOW,					SURFACE,	200,	100,	DFF_SUBSEQ_EVERYWHERE,	"", 0,	darkBlue,3,0,			DF_STAFF_HOLE_EDGE),
			new dungeonFeature(HOLE_EDGE,					SURFACE,	100,	100,	0),

			// machine components

			// commutation altars
			new dungeonFeature(COMMUTATION_ALTAR_INERT,   DUNGEON,    0,      0,      0,  "the items on the two altars flash with a brilliant light!", SCROLL_ENCHANTMENT_LIGHT),
			new dungeonFeature(PIPE_GLOWING,              SURFACE,    90,     60,     0),
			new dungeonFeature(PIPE_INERT,                SURFACE,    0,      0,      0,  "", SCROLL_ENCHANTMENT_LIGHT),

			// resurrection altars
			new dungeonFeature(RESURRECTION_ALTAR_INERT,  DUNGEON,    0,      0,      DFF_RESURRECT_ALLY, "An old friend emerges from a bloom of sacred light!", EMPOWERMENT_LIGHT),
			new dungeonFeature(MACHINE_TRIGGER_FLOOR_REPEATING, LIQUID, 300,  100,    DFF_SUPERPRIORITY),

			// coffin bursts open to reveal vampire:
			new dungeonFeature(COFFIN_OPEN,				DUNGEON,	0,		0,		DFF_ACTIVATE_DORMANT_MONSTER,	"the coffin opens and a dark figure rises!", 0, darkGray, 3),
			new dungeonFeature(PLAIN_FIRE,				SURFACE,	0,		0,		DFF_ACTIVATE_DORMANT_MONSTER,	"as flames begin to lick the coffin, its tenant bursts forth!", 0, null, 0, 0, DF_EMBERS_PATCH),
			new dungeonFeature(MACHINE_TRIGGER_FLOOR,		DUNGEON,	200,	100,	0),

			// throwing tutorial:
			new dungeonFeature(ALTAR_INERT,				DUNGEON,	0,		0,		0,	"the cage lifts off of the altar.", GENERIC_FLASH_LIGHT),
			new dungeonFeature(TRAP_DOOR,					LIQUID,		225,	100,	(DFF_CLEAR_OTHER_TERRAIN | DFF_SUBSEQ_EVERYWHERE), "", 0, null, 0, 0, DF_SHOW_TRAPDOOR_HALO),
			new dungeonFeature(LAVA,						LIQUID,		225,	100,	(DFF_CLEAR_OTHER_TERRAIN)),
			new dungeonFeature(MACHINE_PRESSURE_PLATE_USED,DUNGEON,   0,      0,      0),

			// rat trap:
			new dungeonFeature(RAT_TRAP_WALL_CRACKING,    DUNGEON,    0,      0,      0,  "a scratching sound emanates from the nearby walls!", 0, null, 0, 0, DF_RUBBLE),

			// wooden barricade at entrance:
			new dungeonFeature(PLAIN_FIRE,				SURFACE,	0,		0,		0,	"flames quickly consume the wooden barricade."),

			// wooden barricade around altar:
			new dungeonFeature(WOODEN_BARRICADE,          DUNGEON,	220,	100,	(DFF_TREAT_AS_BLOCKING | DFF_SUBSEQ_EVERYWHERE), "", 0, null, 0, 0, DF_SMALL_DEAD_GRASS),

			// shallow water flood machine:
			new dungeonFeature(MACHINE_FLOOD_WATER_SPREADING,	LIQUID,	0,		0,		0,	"you hear a heavy click, and the nearby water begins flooding the area!"),
			new dungeonFeature(SHALLOW_WATER,				LIQUID,		0,		0,		0),
			new dungeonFeature(MACHINE_FLOOD_WATER_SPREADING,LIQUID,	100,	100,	0,	"", 0,	null,	0,		FLOOR_FLOODABLE,			DF_SHALLOW_WATER),
			new dungeonFeature(MACHINE_FLOOD_WATER_DORMANT,LIQUID,	250,	100,	(DFF_TREAT_AS_BLOCKING), "", 0, null, 0, 0,            DF_SPREADABLE_DEEP_WATER_POOL),
			new dungeonFeature(DEEP_WATER,				LIQUID,		90,		100,	(DFF_CLEAR_OTHER_TERRAIN | DFF_PERMIT_BLOCKING)),

			// unstable floor machine:
			new dungeonFeature(MACHINE_COLLAPSE_EDGE_SPREADING,LIQUID,0,		0,		0,	"you hear a deep rumbling noise as the floor begins to collapse!"),
			new dungeonFeature(CHASM,						LIQUID,		0,		0,		DFF_CLEAR_OTHER_TERRAIN, "", 0, null, 0, 0, DF_SHOW_TRAPDOOR_HALO),
			new dungeonFeature(MACHINE_COLLAPSE_EDGE_SPREADING,LIQUID,100,	100,	0,	"", 0,	null,	0,	FLOOR_FLOODABLE,	DF_COLLAPSE),
			new dungeonFeature(MACHINE_COLLAPSE_EDGE_DORMANT,LIQUID,	0,		0,		0),

			// levitation bridge machine:
			new dungeonFeature(CHASM_WITH_HIDDEN_BRIDGE_ACTIVE,LIQUID,100,    100,    0,  "", 0, null,  0,  CHASM_WITH_HIDDEN_BRIDGE,  DF_BRIDGE_APPEARS),
			new dungeonFeature(CHASM_WITH_HIDDEN_BRIDGE_ACTIVE,LIQUID,100,    100,    0,  "a stone bridge extends from the floor with a grinding sound.", 0, null,  0,  CHASM_WITH_HIDDEN_BRIDGE,  DF_BRIDGE_APPEARS),
			new dungeonFeature(STONE_BRIDGE,				LIQUID,		0,		0,		0),
			new dungeonFeature(MACHINE_CHASM_EDGE,        LIQUID,     100,	100,	0),

			// retracting lava pool:
			new dungeonFeature(LAVA_RETRACTABLE,          LIQUID,     100,    100,    0,  "", 0, null,  0,  LAVA),
			new dungeonFeature(LAVA_RETRACTING,			LIQUID,		0,		0,		0,	"hissing fills the air as the lava begins to cool."),
			new dungeonFeature(OBSIDIAN,					SURFACE,	0,		0,		0,	"", 0,	null,	0,		0,			DF_STEAM_ACCUMULATION),

			// hidden poison vent machine:
			new dungeonFeature(MACHINE_POISON_GAS_VENT_DORMANT,DUNGEON,0,		0,		0,	"you notice an inactive gas vent hidden in a crevice of the floor.", GENERIC_FLASH_LIGHT),
			new dungeonFeature(MACHINE_POISON_GAS_VENT,	DUNGEON,	0,		0,		0,	"deadly purple gas starts wafting out of hidden vents in the floor!"),
			new dungeonFeature(PORTCULLIS_CLOSED,			DUNGEON,	0,		0,		DFF_EVACUATE_CREATURES_FIRST,	"with a heavy mechanical sound, an iron portcullis falls from the ceiling!", GENERIC_FLASH_LIGHT),
			new dungeonFeature(PORTCULLIS_DORMANT,		DUNGEON,	0,		0,		0,  "the portcullis slowly rises from the ground into a slot in the ceiling.", GENERIC_FLASH_LIGHT),
			new dungeonFeature(POISON_GAS,				GAS,		25,		0,		0),

			// hidden methane vent machine:
			new dungeonFeature(MACHINE_METHANE_VENT_DORMANT,DUNGEON,0,		0,		0,	"you notice an inactive gas vent hidden in a crevice of the floor.", GENERIC_FLASH_LIGHT),
			new dungeonFeature(MACHINE_METHANE_VENT,		DUNGEON,	0,		0,		0,	"explosive methane gas starts wafting out of hidden vents in the floor!", 0, null, 0, 0, DF_VENT_SPEW_METHANE),
			new dungeonFeature(METHANE_GAS,				GAS,		60,		0,		0),
			new dungeonFeature(PILOT_LIGHT,				DUNGEON,	0,		0,		0,	"a torch falls from its mount and lies sputtering on the floor.", FALLEN_TORCH_FLASH_LIGHT),

			// paralysis trap:
			new dungeonFeature(MACHINE_PARALYSIS_VENT,    DUNGEON,    0,		0,		0,	"you notice an inactive gas vent hidden in a crevice of the floor.", GENERIC_FLASH_LIGHT),
			new dungeonFeature(PARALYSIS_GAS,				GAS,		350,	0,		0,	"paralytic gas sprays upward from hidden vents in the floor!", 0, null, 0, 0, DF_REVEAL_PARALYSIS_VENT_SILENTLY),
			new dungeonFeature(MACHINE_PARALYSIS_VENT,    DUNGEON,    0,		0,		0),

			// thematic dungeon:
			new dungeonFeature(RED_BLOOD,					SURFACE,	75,     25,		0),

			// statuary:
			new dungeonFeature(STATUE_CRACKING,			DUNGEON,	0,		0,		0,	"cracks begin snaking across the marble surface of the statue!", 0, null, 0, 0, DF_RUBBLE),
			new dungeonFeature(RUBBLE,					SURFACE,	120,	100,	DFF_ACTIVATE_DORMANT_MONSTER,	"the statue shatters!", 0, darkGray, 3, 0, DF_RUBBLE),

			// hidden turrets:
			new dungeonFeature(WALL,                      DUNGEON,	0,		0,		DFF_ACTIVATE_DORMANT_MONSTER,	"you hear a click, and the stones in the wall shift to reveal turrets!", 0, null, 0, 0, DF_RUBBLE),

			// worm tunnels:  // 
			new dungeonFeature(WORM_TUNNEL_MARKER_DORMANT,LIQUID,     5,      5,      0,  "", 0,  null, 0,  GRANITE ),  
			new dungeonFeature(WORM_TUNNEL_MARKER_ACTIVE, LIQUID,     0,      0,      0),
			new dungeonFeature(FLOOR,                     DUNGEON,    0,      0,      (DFF_SUPERPRIORITY | DFF_ACTIVATE_DORMANT_MONSTER),  "", 0, null,  0,  0,  DF_TUNNELIZE),
			new dungeonFeature(FLOOR,                     DUNGEON,    0,      0,      0,  "the nearby wall cracks and collapses in a cloud of dust!", 0, darkGray,  5,  0,  DF_TUNNELIZE),

			// haunted room:
			new dungeonFeature(DARK_FLOOR_DARKENING,		DUNGEON,	0,		0,		0,	"the light in the room flickers and you feel a chill in the air."),
			new dungeonFeature(DARK_FLOOR,				DUNGEON,	0,		0,		DFF_ACTIVATE_DORMANT_MONSTER,	"", 0, null, 0, 0, DF_ECTOPLASM_DROPLET),
			new dungeonFeature(HAUNTED_TORCH_TRANSITIONING,DUNGEON,   0,      0,      0),
			new dungeonFeature(HAUNTED_TORCH,             DUNGEON,    0,      0,      0),

			// mud pit:
			new dungeonFeature(MACHINE_MUD_DORMANT,		LIQUID,		100,	100,	0),
			new dungeonFeature(MUD,						LIQUID,		0,		0,		DFF_ACTIVATE_DORMANT_MONSTER,	"across the bog, bubbles rise ominously from the mud."),

			// electric crystals:
			new dungeonFeature(ELECTRIC_CRYSTAL_ON,       DUNGEON,    0,      0,      0, "the crystal absorbs the electricity and begins to glow.", CHARGE_FLASH_LIGHT),
			new dungeonFeature(WALL,                      DUNGEON,	0,		0,		DFF_ACTIVATE_DORMANT_MONSTER,	"the wall above the lever shifts to reveal a spark turret!"),

			// idyll:
			new dungeonFeature(SHALLOW_WATER,				LIQUID,		150,	100,	(DFF_PERMIT_BLOCKING)),
			new dungeonFeature(DEEP_WATER,				LIQUID,		90,		100,	(DFF_TREAT_AS_BLOCKING | DFF_CLEAR_OTHER_TERRAIN | DFF_SUBSEQ_EVERYWHERE), "", 0, null, 0, 0, DF_SHALLOW_WATER_POOL),

			// swamp:
			new dungeonFeature(SHALLOW_WATER,				LIQUID,		30,		100,	0),
			new dungeonFeature(GRAY_FUNGUS,				SURFACE,	80,		50,		0,	"", 0, null, 0, 0, DF_SWAMP_MUD),
			new dungeonFeature(MUD,						LIQUID,		75,		5,		0,	"", 0, null, 0, 0, DF_SWAMP_WATER),

			// camp:
			new dungeonFeature(HAY,						SURFACE,	90,		87,		0),
			new dungeonFeature(JUNK,						SURFACE,	20,		20,		0),

			// remnants:
			new dungeonFeature(CARPET,					DUNGEON,	110,	20,		DFF_SUBSEQ_EVERYWHERE,	"", 0, null, 0, 0, DF_REMNANT_ASH),
			new dungeonFeature(BURNED_CARPET,				SURFACE,	120,	100,	0),

			// chasm catwalk:
			new dungeonFeature(CHASM,						LIQUID,		0,		0,		DFF_CLEAR_OTHER_TERRAIN, "", 0, null, 0, 0, DF_SHOW_TRAPDOOR_HALO),
			new dungeonFeature(STONE_BRIDGE,				LIQUID,		0,		0,		DFF_CLEAR_OTHER_TERRAIN),

			// lake catwalk:
			new dungeonFeature(DEEP_WATER,				LIQUID,		0,		0,		DFF_CLEAR_OTHER_TERRAIN, "", 0, null, 0, 0, DF_LAKE_HALO),
			new dungeonFeature(SHALLOW_WATER,				LIQUID,		160,	100,	0),

			// worms pop out of walls:
			new dungeonFeature(RUBBLE,					SURFACE,	120,	100,	DFF_ACTIVATE_DORMANT_MONSTER,	"the nearby wall explodes in a shower of stone fragments!", 0, darkGray, 3, 0, DF_RUBBLE),

			// monster cages open:
			new dungeonFeature(MONSTER_CAGE_OPEN,			DUNGEON,	0,		0,		0),

			// goblin warren:
			new dungeonFeature(STENCH_SMOKE_GAS,          GAS,		50,		0,		0, "", 0, null, 0, 0, DF_PLAIN_FIRE),
			new dungeonFeature(STENCH_SMOKE_GAS,          GAS,		50,		0,		0, "", 0, null, 0, 0, DF_EMBERS),

		};


		// Defines all creatures, which include monsters and the player:
		public creatureType[] monsterCatalog  = {
			//*
			//	name			ch		color			HP		def		acc		damage			reg	move	attack	blood			light	DFChance DFType         bolts       behaviorF, abilityF
			new creatureType(0,	"you",	PLAYER_CHAR,	playerInLightColor,30,	0,		100,	new randomRange(1, 2, 1),		20,	100,	100,	DF_RED_BLOOD,	0,		0,		0,              new boltType[]{0},
				(MONST_MALE | MONST_FEMALE)),

			new creatureType(0, "rat",			'r',	gray,			6,		0,		80,		new randomRange(1, 3, 1),		20,	100,	100,	DF_RED_BLOOD,	0,		1,		DF_URINE,       new boltType[]{0}),
			new creatureType(0, "kobold",		'k',	goblinColor,	7,		0,		80,		new randomRange(1, 4, 1),		20,	100,	100,	DF_RED_BLOOD,	0,		0,		0,              new boltType[]{0}),
			new creatureType(0,	"jackal",		'j',	jackalColor,	8,		0,		70,		new randomRange(2, 4, 1),		20,	50,		100,	DF_RED_BLOOD,	0,		1,		DF_URINE,              new boltType[]{0}),
			new creatureType(0,	"eel",			'e',	eelColor,		18,		27,		100,	new randomRange(3, 7, 2),		5,	50,		100,	0,              0,		0,		0,              new boltType[]{0},
				(MONST_RESTRICTED_TO_LIQUID | MONST_IMMUNE_TO_WATER | MONST_SUBMERGES | MONST_FLITS | MONST_NEVER_SLEEPS)),
			new creatureType(0,	"monkey",		'm',	ogreColor,		12,		17,		100,	new randomRange(1, 3, 1),		20,	100,	100,	DF_RED_BLOOD,	0,		1,		DF_URINE,       new boltType[]{0},
				(0), (MA_HIT_STEAL_FLEE)),
			new creatureType(0, "bloat",		'b',	poisonGasColor,4,		0,		100,	new randomRange(0, 0, 0),		5,	100,	100,	DF_PURPLE_BLOOD,0,		0,		DF_BLOAT_DEATH, new boltType[]{0},
				(MONST_FLIES | MONST_FLITS), (MA_KAMIKAZE | MA_DF_ON_DEATH)),
			new creatureType(0, "pit bloat",	'b',	lightBlue,     4,		0,		100,	new randomRange(0, 0, 0),		5,	100,	100,	DF_PURPLE_BLOOD,0,		0,		DF_HOLE_POTION, new boltType[]{0},
				(MONST_FLIES | MONST_FLITS), (MA_KAMIKAZE | MA_DF_ON_DEATH)),
			new creatureType(0, "goblin",		'g',	goblinColor,	15,		10,		70,		new randomRange(2, 5, 1),		20,	100,	100,	DF_RED_BLOOD,	0,		0,		0,              new boltType[]{0},
				(0),  (MA_ATTACKS_PENETRATE | MA_AVOID_CORRIDORS)),
			new creatureType(0, "goblin conjurer",'g',	goblinConjurerColor, 10,10,	70,		new randomRange(2, 4, 1),		20,	100,	100,	DF_RED_BLOOD,	0,		0,		0,              new boltType[]{0},
				(MONST_MAINTAINS_DISTANCE | MONST_CAST_SPELLS_SLOWLY | MONST_CARRY_ITEM_25), (MA_CAST_SUMMON | MA_ATTACKS_PENETRATE | MA_AVOID_CORRIDORS)),
			new creatureType(0, "goblin mystic",'g',	goblinMysticColor, 10,	10,		70,		new randomRange(2, 4, 1),		20,	100,	100,	DF_RED_BLOOD,	0,		0,		0,              new boltType[]{BOLT_SHIELDING},
				(MONST_MAINTAINS_DISTANCE | MONST_CARRY_ITEM_25), (MA_AVOID_CORRIDORS)),
			new creatureType(0, "goblin totem",	TOTEM_CHAR,	orange,	30,		0,		0,		new randomRange(0, 0, 0),		0,	100,	300,	DF_RUBBLE_BLOOD,IMP_LIGHT,0,	0,              new boltType[]{BOLT_HASTE, BOLT_SPARK},
				(MONST_IMMUNE_TO_WEBS | MONST_NEVER_SLEEPS | MONST_IMMOBILE | MONST_INANIMATE | MONST_WILL_NOT_USE_STAIRS), (0)),
			new creatureType(0, "pink jelly",	'J',	pinkJellyColor,50,		0,		85,     new randomRange(1, 3, 1),		0,	100,	100,	DF_PURPLE_BLOOD,0,		0,		0,              new boltType[]{0},
				(MONST_NEVER_SLEEPS), (MA_CLONE_SELF_ON_DEFEND)),
			new creatureType(0, "toad",			't',	toadColor,		18,		0,		90,		new randomRange(1, 4, 1),		10,	100,	100,	DF_GREEN_BLOOD,	0,		0,		0,              new boltType[]{0},
				(0), (MA_HIT_HALLUCINATE)),
			new creatureType(0, "vampire bat",	'v',	gray,			18,		25,		100,	new randomRange(2, 6, 1),		20,	50,		100,	DF_RED_BLOOD,	0,		0,		0,              new boltType[]{0},
				(MONST_FLIES | MONST_FLITS), (MA_TRANSFERENCE)),
			new creatureType(0, "arrow turret", TURRET_CHAR,black,		30,		0,		90,		new randomRange(2, 6, 1),		0,	100,	250,	0,              0,		0,		0,              new boltType[]{BOLT_DISTANCE_ATTACK},
				(MONST_TURRET), (0)),
			new creatureType(0, "acid mound",	'a',	acidBackColor,	15,		10,		70,		new randomRange(1, 3, 1),		5,	100,	100,	DF_ACID_BLOOD,	0,		0,		0,              new boltType[]{0},
				(MONST_DEFEND_DEGRADE_WEAPON), (MA_HIT_DEGRADE_ARMOR)),
			new creatureType(0, "centipede",	'c',	centipedeColor,20,		20,		80,		new randomRange(4, 12, 1),		20,	100,	100,	DF_GREEN_BLOOD,	0,		0,		0,              new boltType[]{0},
				(0), (MA_CAUSES_WEAKNESS)),
			new creatureType(0,	"ogre",			'O',	ogreColor,		55,		60,		125,	new randomRange(9, 13, 2),		20,	100,	200,	DF_RED_BLOOD,	0,		0,		0,              new boltType[]{0},
				(MONST_MALE | MONST_FEMALE), (MA_AVOID_CORRIDORS)),
			new creatureType(0,	"bog monster",	'B',	krakenColor,	55,		60,		5000,	new randomRange(3, 4, 1),		3,	200,	100,	0,              0,		0,		0,              new boltType[]{0},
				(MONST_RESTRICTED_TO_LIQUID | MONST_SUBMERGES | MONST_FLITS | MONST_FLEES_NEAR_DEATH), (MA_SEIZES)),
			new creatureType(0, "ogre totem",	TOTEM_CHAR,	green,		70,		0,		0,		new randomRange(0, 0, 0),		0,	100,	400,	DF_RUBBLE_BLOOD,LICH_LIGHT,0,	0,              new boltType[]{BOLT_HEALING, BOLT_SLOW_2},
				(MONST_IMMUNE_TO_WEBS | MONST_NEVER_SLEEPS | MONST_IMMOBILE | MONST_INANIMATE | MONST_WILL_NOT_USE_STAIRS), (0)),
			new creatureType(0, "spider",		's',	white,			20,		70,		90,		new randomRange(3, 4, 2),		20,	100,	200,	DF_GREEN_BLOOD,	0,		0,		0,              new boltType[]{BOLT_SPIDERWEB},
				(MONST_IMMUNE_TO_WEBS | MONST_CAST_SPELLS_SLOWLY | MONST_ALWAYS_USE_ABILITY), (MA_POISONS)),
			new creatureType(0, "spark turret", TURRET_CHAR, lightningColor,80,0,		100,	new randomRange(0, 0, 0),		0,	100,	150,	0,              SPARK_TURRET_LIGHT,	0,	0,      new boltType[]{BOLT_SPARK},
				(MONST_TURRET), (0)),
			new creatureType(0,	"will-o-the-wisp",'w',	wispLightColor,10,		90,     100,	new randomRange(5,	8, 2),		5,	100,	100,	DF_ASH_BLOOD,	WISP_LIGHT,	0,	0,              new boltType[]{0},
				(MONST_IMMUNE_TO_FIRE | MONST_FLIES | MONST_FLITS | MONST_NEVER_SLEEPS | MONST_FIERY | MONST_DIES_IF_NEGATED)),
			new creatureType(0, "wraith",		'W',	wraithColor,	50,		60,		120,	new randomRange(6, 13, 2),		5,	50,		100,	DF_GREEN_BLOOD,	0,		0,		0,              new boltType[]{0},
				(MONST_FLEES_NEAR_DEATH)),
			new creatureType(0, "zombie",		'Z',	vomitColor,	80,		0,		120,	new randomRange(7, 12, 1),		0,	100,	100,	DF_ROT_GAS_BLOOD,0,		100,	DF_ROT_GAS_PUFF, new boltType[]{0}),
			new creatureType(0, "troll",		'T',	trollColor,	65,		70,		125,	new randomRange(10, 15, 3),	1,	100,	100,	DF_RED_BLOOD,	0,		0,		0,              new boltType[]{0},
				(MONST_MALE | MONST_FEMALE)),
			new creatureType(0,	"ogre shaman",	'O',	green,			45,		40,		100,	new randomRange(5, 9, 1),		20,	100,	200,	DF_RED_BLOOD,	0,		0,		0,              new boltType[]{BOLT_HASTE, BOLT_SPARK},
				(MONST_MAINTAINS_DISTANCE | MONST_CAST_SPELLS_SLOWLY | MONST_MALE | MONST_FEMALE), (MA_CAST_SUMMON | MA_AVOID_CORRIDORS)),
			new creatureType(0, "naga",			'N',	trollColor,	75,		70,     150,	new randomRange(7, 11, 4),		10,	100,	100,	DF_GREEN_BLOOD,	0,		100,	DF_PUDDLE,      new boltType[]{0},
				(MONST_IMMUNE_TO_WATER | MONST_SUBMERGES | MONST_NEVER_SLEEPS | MONST_FEMALE), (MA_ATTACKS_ALL_ADJACENT)),
			new creatureType(0, "salamander",	'S',	salamanderColor,60,	70,     150,	new randomRange(5, 11, 3),		10,	100,	100,	DF_ASH_BLOOD,	SALAMANDER_LIGHT, 100, DF_SALAMANDER_FLAME, new boltType[]{0},
				(MONST_IMMUNE_TO_FIRE | MONST_SUBMERGES | MONST_NEVER_SLEEPS | MONST_FIERY | MONST_MALE), (MA_ATTACKS_EXTEND)),
			new creatureType(0, "explosive bloat",'b',	orange,		10,		0,		100,	new randomRange(0, 0, 0),		5,	100,	100,	DF_RED_BLOOD,	EXPLOSIVE_BLOAT_LIGHT,0, DF_BLOAT_EXPLOSION, new boltType[]{0},
				(MONST_FLIES | MONST_FLITS), (MA_KAMIKAZE | MA_DF_ON_DEATH)),
			new creatureType(0, "dar blademaster",'d',	purple,		35,		70,     160,	new randomRange(5, 9, 2),		20,	100,	100,	DF_RED_BLOOD,	0,		0,		0,              new boltType[]{BOLT_BLINKING},
				(MONST_CARRY_ITEM_25 | MONST_MALE | MONST_FEMALE), (MA_AVOID_CORRIDORS)),
			new creatureType(0, "dar priestess", 'd',	darPriestessColor,20,	60,		100,	new randomRange(2, 5, 1),		20,	100,	100,	DF_RED_BLOOD,   0,		0,		0,              new boltType[]{BOLT_NEGATION, BOLT_HEALING, BOLT_HASTE, BOLT_SPARK},
				(MONST_MAINTAINS_DISTANCE | MONST_CARRY_ITEM_25 | MONST_FEMALE), (MA_AVOID_CORRIDORS)),
			new creatureType(0, "dar battlemage",'d',	darMageColor,	20,		60,		100,	new randomRange(1, 3, 1),		20,	100,	100,	DF_RED_BLOOD,	0,		0,		0,              new boltType[]{BOLT_FIRE, BOLT_SLOW_2, BOLT_DISCORD},
				(MONST_MAINTAINS_DISTANCE | MONST_CARRY_ITEM_25 | MONST_MALE | MONST_FEMALE), (MA_AVOID_CORRIDORS)),
			new creatureType(0, "acidic jelly",	'J',	acidBackColor,	60,		0,		115,	new randomRange(2, 6, 1),		0,	100,	100,	DF_ACID_BLOOD,	0,		0,		0,              new boltType[]{0},
				(MONST_DEFEND_DEGRADE_WEAPON), (MA_HIT_DEGRADE_ARMOR | MA_CLONE_SELF_ON_DEFEND)),
			new creatureType(0,	"centaur",		'C',	tanColor,		35,		50,		175,	new randomRange(4, 8, 2),		20,	50,		100,	DF_RED_BLOOD,	0,		0,		0,              new boltType[]{BOLT_DISTANCE_ATTACK},
				(MONST_MAINTAINS_DISTANCE | MONST_MALE), (0)),
			new creatureType(0, "underworm",	'U',	wormColor,		80,		40,		160,	new randomRange(18, 22, 2),	3,	150,	200,	DF_WORM_BLOOD,	0,		0,		0,              new boltType[]{0},
				(MONST_NEVER_SLEEPS)),
			new creatureType(0, "sentinel",		STATUE_CHAR, sentinelColor, 50,0,		0,		new randomRange(0, 0, 0),		0,	100,	175,	DF_RUBBLE_BLOOD,SENTINEL_LIGHT,0,0,             new boltType[]{BOLT_HEALING, BOLT_SPARK},
				(MONST_TURRET | MONST_CAST_SPELLS_SLOWLY | MONST_DIES_IF_NEGATED), (0)),
			new creatureType(0, "acid turret", TURRET_CHAR,	acidBackColor,35,	0,		250,	new randomRange(1, 2, 1),      0,	100,	250,	0,              0,		0,		0,              new boltType[]{BOLT_ACID_TURRET_ATTACK},
				(MONST_TURRET), (MA_HIT_DEGRADE_ARMOR)),
			new creatureType(0, "dart turret", TURRET_CHAR,	centipedeColor,20,	0,		140,	new randomRange(1, 2, 1),      0,	100,	250,	0,              0,		0,		0,              new boltType[]{BOLT_POISON_DART},
				(MONST_TURRET), (MA_CAUSES_WEAKNESS)),
			new creatureType(0,	"kraken",		'K',	krakenColor,	120,	0,		150,	new randomRange(15, 20, 3),	1,	50,		100,	0,              0,		0,		0,              new boltType[]{0},
				(MONST_RESTRICTED_TO_LIQUID | MONST_IMMUNE_TO_WATER | MONST_SUBMERGES | MONST_FLITS | MONST_NEVER_SLEEPS | MONST_FLEES_NEAR_DEATH), (MA_SEIZES)),
			new creatureType(0,	"lich",			'L',	white,			35,		80,     175,	new randomRange(2, 6, 1),		0,	100,	100,	DF_ASH_BLOOD,	LICH_LIGHT,	0,	0,              new boltType[]{BOLT_FIRE},
				(MONST_MAINTAINS_DISTANCE | MONST_CARRY_ITEM_25 | MONST_NO_POLYMORPH), (MA_CAST_SUMMON)),
			new creatureType(0, "phylactery",	GEM_CHAR,lichLightColor,30,	0,		0,		new randomRange(0, 0, 0),		0,	100,	150,	DF_RUBBLE_BLOOD,LICH_LIGHT,	0,	0,              new boltType[]{0},
				(MONST_IMMUNE_TO_WEBS | MONST_NEVER_SLEEPS | MONST_IMMOBILE | MONST_INANIMATE | MONST_ALWAYS_HUNTING | MONST_WILL_NOT_USE_STAIRS | MONST_DIES_IF_NEGATED), (MA_CAST_SUMMON | MA_ENTER_SUMMONS)),
			new creatureType(0, "pixie",		'p',	pixieColor,	10,		90,     100,	new randomRange(1, 3, 1),		20,	50,		100,	DF_GREEN_BLOOD,	PIXIE_LIGHT, 0,	0,              new boltType[]{BOLT_NEGATION, BOLT_SLOW_2, BOLT_DISCORD, BOLT_SPARK},
				(MONST_MAINTAINS_DISTANCE | MONST_FLIES | MONST_FLITS | MONST_MALE | MONST_FEMALE), (0)),
			new creatureType(0,	"phantom",		'P',	ectoplasmColor,35,		70,     160,	new randomRange(12, 18, 4),    0,	50,		200,	DF_ECTOPLASM_BLOOD,	0,	2,		DF_ECTOPLASM_DROPLET, new boltType[]{0},
				(MONST_INVISIBLE | MONST_FLITS | MONST_FLIES | MONST_IMMUNE_TO_WEBS)),
			new creatureType(0, "flame turret", TURRET_CHAR, lavaForeColor,40,	0,		150,	new randomRange(1, 2, 1),		0,	100,	250,	0,              LAVA_LIGHT,	0,	0,              new boltType[]{BOLT_FIRE},
				(MONST_TURRET), (0)),
			new creatureType(0, "imp",			'i',	pink,			35,		90,     225,	new randomRange(4, 9, 2),		10,	100,	100,	DF_GREEN_BLOOD,	IMP_LIGHT,	0,	0,              new boltType[]{BOLT_BLINKING},
				(0), (MA_HIT_STEAL_FLEE)),
			new creatureType(0,	"fury",			'f',	darkRed,		19,		90,     200,	new randomRange(6, 11, 4),		20,	50,		100,	DF_RED_BLOOD,	0,		0,		0,              new boltType[]{0},
				(MONST_NEVER_SLEEPS | MONST_FLIES)),
			new creatureType(0, "revenant",		'R',	ectoplasmColor,30,		0,		200,	new randomRange(15, 20, 5),	0,	100,	100,	DF_ECTOPLASM_BLOOD,	0,	0,		0,              new boltType[]{0},
				(MONST_IMMUNE_TO_WEAPONS)),
			new creatureType(0, "tentacle horror",'H',	centipedeColor,120,	95,     225,	new randomRange(25, 35, 3),	1,	100,	100,	DF_PURPLE_BLOOD,0,		0,		0,              new boltType[]{0}),
			new creatureType(0, "golem",		'G',	gray,			400,	70,     225,	new randomRange(4, 8, 1),		0,	100,	100,	DF_RUBBLE_BLOOD,0,		0,		0,              new boltType[]{0},
				(MONST_REFLECT_4 | MONST_DIES_IF_NEGATED)),
			new creatureType(0, "dragon",		'D',	dragonColor,	150,	90,     250,	new randomRange(25, 50, 4),	20,	50,		200,	DF_GREEN_BLOOD,	0,		0,		0,              new boltType[]{BOLT_DRAGONFIRE},
				(MONST_IMMUNE_TO_FIRE | MONST_CARRY_ITEM_100), (MA_ATTACKS_ALL_ADJACENT)),

			// bosses
			new creatureType(0, "goblin warlord",'g',	blue,			30,		17,		100,	new randomRange(3, 6, 1),		20,	100,	100,	DF_RED_BLOOD,	0,		0,		0,              new boltType[]{0},
				(MONST_MAINTAINS_DISTANCE | MONST_CARRY_ITEM_25), (MA_CAST_SUMMON | MA_ATTACKS_PENETRATE | MA_AVOID_CORRIDORS)),
			new creatureType(0,	"black jelly",	'J',	black,			120,	0,		130,	new randomRange(3, 8, 1),		0,	100,	100,	DF_PURPLE_BLOOD,0,		0,		0,              new boltType[]{0},
				(0), (MA_CLONE_SELF_ON_DEFEND)),
			new creatureType(0, "vampire",		'V',	white,			75,		60,     120,	new randomRange(4, 15, 2),		6,	50,		100,	DF_RED_BLOOD,	0,		0,		DF_BLOOD_EXPLOSION, new boltType[]{BOLT_BLINKING, BOLT_DISCORD},
				(MONST_FLEES_NEAR_DEATH | MONST_MALE), (MA_TRANSFERENCE | MA_DF_ON_DEATH | MA_CAST_SUMMON | MA_ENTER_SUMMONS)),
			new creatureType(0, "flamedancer",	'F',	white,			65,		80,     120,	new randomRange(3, 8, 2),		0,	100,	100,	DF_EMBER_BLOOD,	FLAMEDANCER_LIGHT,100,DF_FLAMEDANCER_CORONA, new boltType[]{BOLT_FIRE},
				(MONST_MAINTAINS_DISTANCE | MONST_IMMUNE_TO_FIRE | MONST_FIERY), (0)),

			// special effect monsters
			new creatureType(0, "spectral blade",WEAPON_CHAR, spectralBladeColor,1, 0,	150,	new randomRange(1, 1, 1),		0,	50,		100,	0,              SPECTRAL_BLADE_LIGHT,0,0,       new boltType[]{0},
				(MONST_INANIMATE | MONST_NEVER_SLEEPS | MONST_FLIES | MONST_WILL_NOT_USE_STAIRS | MB_DOES_NOT_TRACK_LEADER | MONST_DIES_IF_NEGATED | MONST_IMMUNE_TO_WEBS | MONST_NOT_LISTED_IN_SIDEBAR)),
			new creatureType(0, "spectral sword",WEAPON_CHAR, spectralImageColor, 1,0,	150,	new randomRange(1, 1, 1),		0,	50,		100,	0,              SPECTRAL_IMAGE_LIGHT,0,0,       new boltType[]{0},
				(MONST_INANIMATE | MONST_NEVER_SLEEPS | MONST_FLIES | MONST_WILL_NOT_USE_STAIRS | MB_DOES_NOT_TRACK_LEADER | MONST_DIES_IF_NEGATED | MONST_IMMUNE_TO_WEBS)),
			new creatureType(0, "stone guardian",STATUE_CHAR, white,   1000,   0,		200,	new randomRange(12, 17, 2),	0,	100,	100,	DF_RUBBLE,      0,      100,      DF_GUARDIAN_STEP, new boltType[]{0},
				(MONST_INANIMATE | MONST_NEVER_SLEEPS | MONST_ALWAYS_HUNTING | MONST_IMMUNE_TO_FIRE | MONST_IMMUNE_TO_WEAPONS | MONST_WILL_NOT_USE_STAIRS | MONST_DIES_IF_NEGATED | MONST_REFLECT_4 | MONST_ALWAYS_USE_ABILITY | MONST_GETS_TURN_ON_ACTIVATION)),
			new creatureType(0, "winged guardian",STATUE_CHAR, blue,   1000,   0,		200,	new randomRange(12, 17, 2),	0,	100,	100,	DF_RUBBLE,      0,      100,      DF_SILENT_GLYPH_GLOW, new boltType[]{BOLT_BLINKING},
				(MONST_INANIMATE | MONST_NEVER_SLEEPS | MONST_ALWAYS_HUNTING | MONST_IMMUNE_TO_FIRE | MONST_IMMUNE_TO_WEAPONS | MONST_WILL_NOT_USE_STAIRS | MONST_DIES_IF_NEGATED | MONST_REFLECT_4 | MONST_GETS_TURN_ON_ACTIVATION | MONST_ALWAYS_USE_ABILITY), (0)),
			new creatureType(0, "guardian spirit",STATUE_CHAR, spectralImageColor,1000,0,200,	new randomRange(5, 12, 2),     0,	100,	100,	0,              SPECTRAL_IMAGE_LIGHT,100,0,     new boltType[]{0},
				(MONST_INANIMATE | MONST_NEVER_SLEEPS | MONST_IMMUNE_TO_FIRE | MONST_IMMUNE_TO_WEAPONS | MONST_DIES_IF_NEGATED | MONST_REFLECT_4 | MONST_ALWAYS_USE_ABILITY)),
			new creatureType(0, "Warden of Yendor",'Y', yendorLightColor,1000,   0,	300,	new randomRange(12, 17, 2),	0,	200,	200,	DF_RUBBLE,      YENDOR_LIGHT, 100, 0,           new boltType[]{0},
				(MONST_NEVER_SLEEPS | MONST_ALWAYS_HUNTING | MONST_INVULNERABLE | MONST_NO_POLYMORPH)),
			new creatureType(0, "eldritch totem",TOTEM_CHAR, glyphColor,80,    0,		0,		new randomRange(0, 0, 0),		0,	100,	100,	DF_RUBBLE_BLOOD,0,      0,      0,              new boltType[]{0},
				(MONST_IMMUNE_TO_WEBS | MONST_NEVER_SLEEPS | MONST_IMMOBILE | MONST_INANIMATE | MONST_ALWAYS_HUNTING | MONST_WILL_NOT_USE_STAIRS | MONST_GETS_TURN_ON_ACTIVATION | MONST_ALWAYS_USE_ABILITY), (MA_CAST_SUMMON)),
			new creatureType(0, "mirrored totem",TOTEM_CHAR, beckonColor,80,	0,		0,		new randomRange(0, 0, 0),		0,	100,	100,	DF_RUBBLE_BLOOD,0,      100,	DF_MIRROR_TOTEM_STEP, new boltType[]{BOLT_BECKONING},
				(MONST_IMMUNE_TO_WEBS | MONST_NEVER_SLEEPS | MONST_IMMOBILE | MONST_INANIMATE | MONST_ALWAYS_HUNTING | MONST_WILL_NOT_USE_STAIRS | MONST_GETS_TURN_ON_ACTIVATION | MONST_ALWAYS_USE_ABILITY | MONST_REFLECT_4 | MONST_IMMUNE_TO_WEAPONS | MONST_IMMUNE_TO_FIRE), (0)),

			// legendary allies
			new creatureType(0,	"unicorn",		UNICORN_CHAR, white,   40,		60,		175,	new randomRange(2, 10, 2),		20,	50,		100,	DF_RED_BLOOD,	UNICORN_LIGHT,1,DF_UNICORN_POOP, new boltType[]{BOLT_HEALING, BOLT_SHIELDING},
				(MONST_MAINTAINS_DISTANCE | MONST_MALE | MONST_FEMALE), (0)),
			new creatureType(0,	"ifrit",		'I',	ifritColor,	40,		75,     175,	new randomRange(5, 13, 2),		1,	50,		100,	DF_ASH_BLOOD,	IFRIT_LIGHT,0,	0,              new boltType[]{BOLT_DISCORD},
				(MONST_IMMUNE_TO_FIRE | MONST_FLIES | MONST_MALE), (0)),
			new creatureType(0,	"phoenix",		'P',	phoenixColor,	30,		70,     175,	new randomRange(4, 10, 2),		0,	50,		100,	DF_ASH_BLOOD,	PHOENIX_LIGHT,0,0,              new boltType[]{0},
				(MONST_IMMUNE_TO_FIRE| MONST_FLIES)),
			new creatureType(0, "phoenix egg",	GEM_CHAR,phoenixColor,	150,	0,		0,		new randomRange(0, 0, 0),		0,	100,	150,	DF_ASH_BLOOD,	PHOENIX_EGG_LIGHT,	0,	0,      new boltType[]{0},
				(MONST_IMMUNE_TO_FIRE| MONST_IMMUNE_TO_WEBS | MONST_NEVER_SLEEPS | MONST_IMMOBILE | MONST_INANIMATE | MONST_WILL_NOT_USE_STAIRS | MONST_NO_POLYMORPH | MONST_ALWAYS_HUNTING), (MA_CAST_SUMMON | MA_ENTER_SUMMONS)),
			new creatureType(0,	"mangrove dryad",'M',	tanColor,      70,		60,     175,	new randomRange(2, 8, 2),		6,	100,	100,	DF_ASH_BLOOD,	0,      0,      0,              new boltType[]{BOLT_ANCIENT_SPIRIT_VINES},
				(MONST_IMMUNE_TO_WEBS | MONST_ALWAYS_USE_ABILITY | MONST_MAINTAINS_DISTANCE | MONST_MALE | MONST_FEMALE), (0) ),
			//*/
		};


		public monsterClass[] monsterClassCatalog  = {
			// name             frequency   maxDepth    member list
			new monsterClass("abomination",     10,         -1,         new monsterTypes[]{MK_BOG_MONSTER, MK_UNDERWORM, MK_KRAKEN, MK_TENTACLE_HORROR}),
			new monsterClass("dar",             10,         22,         new monsterTypes[]{MK_DAR_BLADEMASTER, MK_DAR_PRIESTESS, MK_DAR_BATTLEMAGE}),
			new monsterClass("animal",          10,         10,         new monsterTypes[]{MK_RAT, MK_MONKEY, MK_JACKAL, MK_EEL, MK_TOAD, MK_CENTIPEDE, MK_SPIDER}),
			new monsterClass("goblin",          10,         10,         new monsterTypes[]{MK_GOBLIN, MK_GOBLIN_CONJURER, MK_GOBLIN_MYSTIC, MK_GOBLIN_TOTEM, MK_GOBLIN_CHIEFTAN}),
			new monsterClass("ogre",            10,         16,         new monsterTypes[]{MK_OGRE, MK_OGRE_SHAMAN, MK_OGRE_TOTEM}),
			new monsterClass("dragon",          10,         -1,         new monsterTypes[]{MK_DRAGON}),
			new monsterClass("undead",          10,         -1,         new monsterTypes[]{MK_ZOMBIE, MK_WRAITH, MK_VAMPIRE, MK_PHANTOM, MK_LICH, MK_REVENANT}),
			new monsterClass("jelly",           10,         15,         new monsterTypes[]{MK_PINK_JELLY, MK_BLACK_JELLY, MK_ACID_JELLY}),
			new monsterClass("turret",          5,          18,         new monsterTypes[]{MK_ARROW_TURRET, MK_SPARK_TURRET, MK_DART_TURRET, MK_FLAME_TURRET}),
			new monsterClass("infernal",        10,         -1,         new monsterTypes[]{MK_FLAMEDANCER, MK_IMP, MK_REVENANT, MK_FURY, MK_PHANTOM}),
			new monsterClass("waterborne",      10,         17,         new monsterTypes[]{MK_EEL, MK_NAGA, MK_KRAKEN}),
			new monsterClass("fireborne",       10,         12,         new monsterTypes[]{MK_WILL_O_THE_WISP, MK_SALAMANDER, MK_FLAMEDANCER}),
			new monsterClass("troll",           10,         15,         new monsterTypes[]{MK_TROLL}),
		};

		public readonly static char [][] itemTitles = new char[NUMBER_SCROLL_KINDS][]; // 30
		public readonly static char [][] itemColors = new char[NUMBER_ITEM_COLORS][];  // 30
		public readonly static char [][] itemMetals = new char[NUMBER_ITEM_METALS][];  // 30
		public readonly static char [][] itemWoods  = new char[NUMBER_ITEM_WOODS][];
		public readonly static char [][] itemGems   = new char[NUMBER_ITEM_GEMS][];

		public readonly static tcell[,] tmap = new tcell[DCOLS,DROWS];						// grids with info about the map
		public readonly static pcell[,] pmap = new pcell[DCOLS,DROWS];

		public readonly static cellDisplayBuffer[,] displayBuffer = new cellDisplayBuffer[RogueH.COLS,RogueH.ROWS];


		public static void preInitData() {
			for (int i = 0; i < itemTitles.Length; i++) {
				itemTitles[i] = new char[ 30 ] ;
			}
			for (int i = 0; i < itemColors.Length; i++) {
				itemColors[i] = new char[ 30 ] ;
			}		
			for (int i = 0; i < itemMetals.Length; i++) {
				itemMetals[i] = new char[ 30 ] ;
			}			
			for (int i = 0; i < itemWoods.Length; i++) {
				itemWoods[i] = new char[ 30 ] ;
			}					
			for (int i = 0; i < itemGems.Length; i++) {
				itemGems[i] = new char[ 30 ] ;
			}

			for (int i = 0; i < DCOLS; i++) { 
				for (int j = 0; j < DROWS; j++) { 
					tmap [i,j]= new tcell() ; 
					pmap [i,j]= new pcell() ;
					displayBuffer [i, j] = new cellDisplayBuffer ();
				} 
			} 

		}

		// -------------- item table -------------------

		public itemTable [] scrollTable  = {
			new itemTable("enchanting",			itemTitles[0], "",	0,	550,	0,new randomRange(0,0,0), false, false, "This indispensable scroll will imbue a single item with a powerful and permanent magical charge. A staff will increase in power and in number of charges; a weapon will inflict more damage or find its mark more frequently; a suit of armor will deflect additional blows; the effect of a ring on its wearer will intensify; and a wand will gain expendable charges in the least amount that such a wand can be found with. Weapons and armor will also require less strength to use, and any curses on the item will be lifted."),// frequency is dynamically adjusted
			new itemTable("identify",			itemTitles[1], "",	30,	300,	0,new randomRange(0,0,0), false, false, "The scrying magic on this parchment will permanently reveal all of the secrets of a single item."),
			new itemTable("teleportation",		itemTitles[2], "",	10,	500,	0,new randomRange(0,0,0), false, false, "The spell on this parchment instantly transports the reader to a random location on the dungeon level. It can be used to escape a dangerous situation, but the unlucky reader might find himself in an even more dangerous place."),
			new itemTable("remove curse",		itemTitles[3], "",	15,	150,	0,new randomRange(0,0,0), false, false, "The incantation on this scroll will instantly strip from the reader's weapon, armor, rings and carried items any evil enchantments that might prevent the wearer from removing them."),
			new itemTable("recharging",			itemTitles[4], "",	12,	375,	0,new randomRange(0,0,0), false, false, "The power bound up in this parchment will instantly recharge all of your staffs and charms."),
			new itemTable("protect armor",		itemTitles[5], "",	10,	400,	0,new randomRange(0,0,0), false, false, "The armor worn by the reader of this scroll will be permanently proofed against degradation from acid."),
			new itemTable("protect weapon",		itemTitles[6], "",	10,	400,	0,new randomRange(0,0,0), false, false, "The weapon held by the reader of this scroll will be permanently proofed against degradation from acid."),
			new itemTable("sanctuary",           itemTitles[7], "",  10, 500,    0,new randomRange(0,0,0), false, false, "When recited over plain ground, the sacred rite of protection memorialized on this scroll will imbue the area with powerful warding glyphs. Monsters will not willingly set foot on the affected area."),
			new itemTable("magic mapping",		itemTitles[8], "",	12,	500,	0,new randomRange(0,0,0), false, false, "When this scroll is read, a purple-hued image of crystal clarity will be etched into your memory, alerting you to the precise layout of the level and revealing all hidden secrets. The locations of items and creatures will remain unknown."),
			new itemTable("negation",			itemTitles[9], "",	8,	400,	0,new randomRange(0,0,0), false, false, "This scroll contains a powerful anti-magic. When it is released, all creatures (including yourself) and all items lying on the ground within your field of view will be exposed to its blast and stripped of magic -- and creatures animated purely by magic will die. Potions, scrolls, items being held by other creatures and items in your inventory will not be affected."),
			new itemTable("shattering",			itemTitles[10],"",	8,	500,	0,new randomRange(0,0,0), false, false, "The blast of sorcery unleashed by this scroll will alter the physical structure of nearby stone, causing it to dissolve away over the ensuing minutes."),
			new itemTable("discord",             itemTitles[11], "",	8,	400,	0,new randomRange(0,0,0), false, false, "Reading this scroll will unleash a powerful blast of mind magic. Any creatures within line of sight will turn against their companions and attack indiscriminately for 30 turns."),
			new itemTable("aggravate monsters",	itemTitles[12], "",	15,	50,		0,new randomRange(0,0,0), false, false, "When read aloud, this scroll will unleash a piercing shriek that will awaken all monsters and alert them to the reader's location."),
			new itemTable("summon monsters",		itemTitles[13], "",	10,	50,		0,new randomRange(0,0,0), false, false, "The incantation on this scroll will call out to creatures in other planes of existence, drawing them through the fabric of reality to confront the reader."),
		};

		public itemTable[] potionTable  = {
			new itemTable("life",				itemColors[1], "",	0,	500,	0,new randomRange(0,0,0), false, false, "A swirling elixir that will instantly heal you, cure you of ailments, and permanently increase your maximum health."),// frequency is dynamically adjusted
			new itemTable("strength",			itemColors[2], "",	0,	400,	0,new randomRange(0,0,0), false, false, "This powerful medicine will course through your muscles, permanently increasing your strength by one point."),// frequency is dynamically adjusted
			new itemTable("telepathy",			itemColors[3], "",	20,	350,	0,new randomRange(0,0,0), false, false, "After drinking this, your mind will become attuned to the psychic signature of distant creatures, enabling you to sense biological presences through walls. Its effects will not reveal inanimate objects, such as totems, turrets and traps."),
			new itemTable("levitation",			itemColors[4], "",	15,	250,	0,new randomRange(0,0,0), false, false, "Drinking this curious liquid will cause you to hover in the air, able to drift effortlessly over lava, water, chasms and traps. Flames, gases and spiderwebs fill the air, however, and cannot be bypassed while airborne. Creatures that dwell in water or mud will be unable to attack you while you levitate."),
			new itemTable("detect magic",		itemColors[5], "",	20,	500,	0,new randomRange(0,0,0), false, false, "This drink will sensitize your mind to the radiance of magic. Items imbued with helpful enchantments will be marked on the map with a full magical sigil; items corrupted by curses or intended to inflict harm on the bearer will be marked on the map with a hollow sigil. The Amulet of Yendor, if in the vicinity, will be revealed by its unique aura."),
			new itemTable("speed",				itemColors[6], "",	10,	500,	0,new randomRange(0,0,0), false, false, "Quaffing the contents of this flask will enable you to move at blinding speed for several minutes."),
			new itemTable("fire immunity",		itemColors[7], "",	15,	500,	0,new randomRange(0,0,0), false, false, "This potion will render you impervious to heat and permit you to wander through fire and lava and ignore otherwise deadly bolts of flame. It will not guard against the concussive impact of an explosion, however."),
			new itemTable("invisibility",		itemColors[8], "",	15,	400,	0,new randomRange(0,0,0), false, false, "Drinking this potion will render you temporarily invisible. Enemies more than two spaces away will be unable to track you."),
			new itemTable("caustic gas",         itemColors[9], "",	15,	200,	0,new randomRange(0,0,0), false, false, "Uncorking or shattering this pressurized glass will cause its contents to explode into a deadly cloud of caustic purple gas. You might choose to fling this potion at distant enemies instead of uncorking it by hand."),
			new itemTable("paralysis",			itemColors[10], "",	10, 250,	0,new randomRange(0,0,0), false, false, "Upon exposure to open air, the liquid in this flask will vaporize into a numbing pink haze. Anyone who inhales the cloud will be paralyzed instantly, unable to move for some time after the cloud dissipates. This item can be thrown at distant enemies to catch them within the effect of the gas."),
			new itemTable("hallucination",		itemColors[11], "",	10,	500,	0,new randomRange(0,0,0), false, false, "This flask contains a vicious and long-lasting hallucinogen. Under its dazzling effect, you will wander through a rainbow wonderland, unable to discern the form of any creatures or items you see."),
			new itemTable("confusion",			itemColors[12], "",	15,	450,	0,new randomRange(0,0,0), false, false, "This unstable chemical will quickly vaporize into a glittering cloud upon contact with open air, causing any creature that inhales it to lose control of the direction of its movements until the effect wears off (although its ability to aim projectile attacks will not be affected). Its vertiginous intoxication can cause creatures and adventurers to careen into one another or into chasms or lava pits, so extreme care should be taken when under its effect. Its contents can be weaponized by throwing the flask at distant enemies."),
			new itemTable("incineration",		itemColors[13], "",	15,	500,	0,new randomRange(0,0,0), false, false, "This flask contains an unstable compound which will burst violently into flame upon exposure to open air. You might throw the flask at distant enemies -- or into a deep lake, to cleanse the cavern with scalding steam."),
			new itemTable("darkness",			itemColors[14], "",	7,	150,	0,new randomRange(0,0,0), false, false, "Drinking this potion will plunge you into darkness. At first, you will be completely blind to anything not illuminated by an independent light source, but over time your vision will regain its former strength. Throwing the potion will create a cloud of supernatural darkness, and enemies will have difficulty seeing or following you if you take refuge under its cover."),
			new itemTable("descent",				itemColors[15], "",	15,	500,	0,new randomRange(0,0,0), false, false, "When this flask is uncorked by hand or shattered by being thrown, the fog that seeps out will temporarily cause the ground in the vicinity to vanish."),
			new itemTable("creeping death",		itemColors[16], "",	7,	450,	0,new randomRange(0,0,0), false, false, "When the cork is popped or the flask is thrown, tiny spores will spill across the ground and begin to grow a deadly lichen. Anything that touches the lichen will be poisoned by its clinging tendrils, and the lichen will slowly grow to fill the area. Fire will purge the infestation."),
		};

		public itemTable[] wandTable  = {
			new itemTable("teleportation",	itemMetals[0], "",	3,	800,	(short)BOLT_TELEPORT,new randomRange(3,5,1), false, false, "A blast from this wand will teleport a creature to a random place on the level. This can be particularly effective against aquatic or mud-bound creatures, which are helpless on dry land."),
			new itemTable("slowness",		itemMetals[1], "",	3,	800,	(short)BOLT_SLOW,new randomRange(2,5,1), false, false, "This wand will cause a creature to move at half its ordinary speed for 30 turns."),
			new itemTable("polymorphism",	itemMetals[2], "",	3,	700,	(short)BOLT_POLYMORPH,new randomRange(3,5,1), false, false, "This mischievous magic can transform any creature into another creature at random. Beware: the tamest of creatures might turn into the most fearsome. The horror of the transformation will turn any affected allies against you."),
			new itemTable("negation",		itemMetals[3], "",	3,	550,	(short)BOLT_NEGATION,new randomRange(4,6,1), false, false, "This powerful anti-magic will strip a creature of a host of magical traits, including flight, invisibility, acidic corrosiveness, telepathy, magical speed or slowness, hypnosis, magical fear, immunity to physical attack, fire resistance and the ability to blink. Spellcasters will lose their magical abilities and magical totems will be rendered inert. Creatures animated purely by magic will die."),
			new itemTable("domination",		itemMetals[4], "",	1,	1000,	(short)BOLT_DOMINATION,new randomRange(1,2,1), false, false, "This wand can forever bind an enemy to the caster's will, turning it into a steadfast ally. However, the magic works only against enemies that are near death."),
			new itemTable("beckoning",		itemMetals[5], "",	3,	500,	(short)BOLT_BECKONING,new randomRange(2,4,1), false, false, "The force of this wand will yank the targeted creature into direct proximity."),
			new itemTable("plenty",			itemMetals[6], "",	2,	700,	(short)BOLT_PLENTY,new randomRange(1,2,1), false, false, "The creature at the other end of this mischievous bit of metal will be beside itself -- literally! Cloning an enemy is ill-advised, but the effect can be invaluable on a powerful ally."),
			new itemTable("invisibility",	itemMetals[7], "",	3,	100,	(short)BOLT_INVISIBILITY,new randomRange(3,5,1), false, false, "A charge from this wand will render a creature temporarily invisible to the naked eye. Only with telepathy or in the silhouette of a thick gas will an observer discern the creature's hazy outline."),
			new itemTable("empowerment",     itemMetals[8], "",	2,	100,	(short)BOLT_EMPOWERMENT,new randomRange(1,1,1), false, false, "This sacred magic will permanently improve the mind and body of any monster it hits. A wise adventurer will use it on allies, making them stronger in combat and able to learn a new talent from a fallen foe. If the bolt is reflected back at you, it will have no effect."),
		};

		public itemTable[] staffTable  = {
			new itemTable("lightning",		itemWoods[0], "",	15,	1300,	(short)BOLT_LIGHTNING,new randomRange(2,4,1), false, false, "This staff conjures forth deadly arcs of electricity, which deal damage to any number of creatures in a straight line."),
			new itemTable("firebolt",		itemWoods[1], "",	15,	1300,	(short)BOLT_FIRE,new randomRange(2,4,1), false, false, "This staff unleashes bursts of magical fire. It will ignite flammable terrain, and will damage and burn a creature that it hits. Creatures with an immunity to fire will be unaffected by the bolt."),
			new itemTable("poison",			itemWoods[2], "",	10,	1200,	(short)BOLT_POISON,new randomRange(2,4,1), false, false, "The vile blast of this twisted bit of wood will imbue its target with a deadly venom. Each turn, a creature that is poisoned will suffer one point of damage per dose of poison it has received, and poisoned creatures will not regenerate lost health until the poison clears."),
			new itemTable("tunneling",		itemWoods[3], "",	10,	1000,	(short)BOLT_TUNNELING,new randomRange(2,4,1), false, false, "Bursts of magic from this staff will pass harmlessly through creatures but will reduce walls and other inanimate obstructions to rubble."),
			new itemTable("blinking",		itemWoods[4], "",	11,	1200,	(short)BOLT_BLINKING,new randomRange(2,4,1), false, false, "This staff will allow you to teleport in the chosen direction. Creatures and inanimate obstructions will block the teleportation. Be careful around dangerous terrain, as nothing will prevent you from teleporting to a fiery death in a lake of lava."),
			new itemTable("entrancement",	itemWoods[5], "",	6,	1000,	(short)BOLT_ENTRANCEMENT,new randomRange(2,4,1), false, false, "This curious staff will send creatures into a deep but temporary trance, in which they will mindlessly mirror your movements. You can use the effect to cause one creature to attack another or to step into hazardous terrain, but the spell will be broken if you attack the creature under the effect."),
			new itemTable("obstruction",		itemWoods[6], "",	10,	1000,	(short)BOLT_OBSTRUCTION,new randomRange(2,4,1), false, false, "A mass of impenetrable green crystal will spring forth from the point at which this staff is aimed, obstructing any who wish to move through the affected area and temporarily entombing any who are already there. The crystal will dissolve into the air as time passes. Higher level staffs will create larger obstructions."),
			new itemTable("discord",			itemWoods[7], "",	10,	1000,	(short)BOLT_DISCORD,new randomRange(2,4,1), false, false, "The purple light from this staff will alter the perception of a creature to lash out indiscriminately. Strangers and allies alike will turn on the victim."),
			new itemTable("conjuration",		itemWoods[8], "",	8,	1000,	(short)BOLT_CONJURATION,new randomRange(2,4,1), false, false, "A flick of this staff summons a number of phantom blades to fight on your behalf."),
			new itemTable("healing",			itemWoods[9], "",	5,	1100,	(short)BOLT_HEALING,new randomRange(2,4,1), false, false, "The crimson bolt from this staff will heal the injuries of any creature it touches. This can be counterproductive against enemies but can prove useful when aimed at your allies. Unfortunately, you cannot use this or any staff on yourself."),
			new itemTable("haste",			itemWoods[10], "",	5,	900,	(short)BOLT_HASTE,new randomRange(2,4,1), false, false, "The magical bolt from this staff will temporarily double the speed of any monster it hits. This can be counterproductive against enemies but can prove useful when aimed at your allies. Unfortunately, you cannot use this or any staff on yourself."),
			new itemTable("protection",		itemWoods[11], "",	5,	900,	(short)BOLT_SHIELDING,new randomRange(2,4,1), false, false, "A charge from this staff will bathe a creature in protective light, absorbing all damage until depleted. This can be counterproductive against enemies but can prove useful when aimed at your allies. Unfortunately, you cannot use this or any staff on yourself."),
		};

		public itemTable[] ringTable  = {
			new itemTable("clairvoyance",	itemGems[0], "",	1,	900,	0,new randomRange(1,3,1), false, false, "Wearing this ring will permit you to see through nearby walls and doors, within a radius determined by the level of the ring. A cursed ring of clairvoyance will blind you to your immediate surroundings."),
			new itemTable("stealth",			itemGems[1], "",	1,	800,	0,new randomRange(1,3,1), false, false, "This ring will reduce your stealth range, making enemies less likely to notice you and more likely to lose your trail. Staying motionless and lurking in the shadows will make you even harder to spot. Cursed rings of stealth will increase your stealth range, making you easier to spot and to track."),
			new itemTable("regeneration",	itemGems[2], "",	1,	750,	0,new randomRange(1,3,1), false, false, "This ring increases the body's regenerative properties, allowing one to recover lost health at an accelerated rate. Cursed rings will decrease or even halt one's natural regeneration."),
			new itemTable("transference",	itemGems[3], "",	1,	750,	0,new randomRange(1,3,1), false, false, "Landing a melee attack while wearing this ring will heal you in proportion to the damage inflicted. Cursed rings will cause you to lose health with each attack you land."),
			new itemTable("light",			itemGems[4], "",	1,	600,	0,new randomRange(1,3,1), false, false, "This ring subtly enhances your vision, enabling you to see farther in the dimming light of the deeper dungeon levels. It will not make you more visible to enemies."),
			new itemTable("awareness",		itemGems[5], "",	1,	700,	0,new randomRange(1,3,1), false, false, "Wearing this ring will enable you to notice hidden secrets (traps, secret doors and hidden levers) more often and from a greater distance. Cursed rings of awareness will dull your senses, making it harder to notice secrets even when actively searching for them."),
			new itemTable("wisdom",			itemGems[6], "",	1,	700,	0,new randomRange(1,3,1), false, false, "Your staffs will recharge at an accelerated rate in the energy field that radiates from this ring. Cursed rings of wisdom will instead cause your staffs to recharge more slowly."),
			new itemTable("reaping",         itemGems[7], "",	1,	700,	0,new randomRange(1,3,1), false, false, "The blood magic in this ring will recharge your staffs and charms in proportion to the damage you inflict directly. Cursed rings of reaping will drain your staffs and charms when you inflict damage directly."),
		};

		public itemTable[] charmTable = {
			new itemTable("health",          "", "",	5,	900,	0,new randomRange(1,2,1), true, false, "This handful of dried bloodwort and mandrake root has been bound together with leather cord and imbued with a powerful healing magic."),
			new itemTable("protection",		"", "",	5,	800,	0,new randomRange(1,2,1), true, false, "Four copper rings have been joined into a tetrahedron. The construct is oddly warm to the touch."),
			new itemTable("haste",           "", "",	5,	750,	0,new randomRange(1,2,1), true, false, "Various animals have been etched into the surface of this brass bangle. It emits a barely audible hum."),
			new itemTable("fire immunity",	"", "",	3,	750,	0,new randomRange(1,2,1), true, false, "Eldritch flames flicker within this polished crystal bauble."),
			new itemTable("invisibility",	"", "",	5,	700,	0,new randomRange(1,2,1), true, false, "This intricate figurine depicts a strange humanoid creature. It has a face on both sides of its head, but all four eyes are closed."),
			new itemTable("telepathy",		"", "",	3,	700,	0,new randomRange(1,2,1), true, false, "Seven tiny glass eyes roll freely within this glass sphere. Somehow, they always come to rest facing outward."),
			new itemTable("levitation",      "", "",	1,	700,	0,new randomRange(1,2,1), true, false, "Sparkling dust and fragments of feather waft and swirl endlessly inside this small glass sphere."),
			new itemTable("shattering",      "", "",	1,	700,	0,new randomRange(1,2,1), true, false, "This turquoise crystal, fixed to a leather lanyard, hums with an arcane energy that sets your teeth on edge."),
			new itemTable("guardian",        "", "",	5,	700,	0,new randomRange(1,2,1), true, false, "When you touch this tiny granite statue, a rhythmic booming sound echoes in your head."),//    {"fear",            "", "",	3,	700,	0,new randomRange(1,2,1), true, false, "When you gaze into the murky interior of this obsidian cube, you feel as though something predatory is watching you."),
			new itemTable("teleportation",   "", "",	4,	700,	0,new randomRange(1,2,1), true, false, "The surface of this nickel sphere has been etched with a perfect grid pattern. Somehow, the squares of the grid are all exactly the same size."),
			new itemTable("recharging",      "", "",	5,	700,	0,new randomRange(1,2,1), true, false, "A strip of bronze has been wound around a rough wooden sphere. Each time you touch it, you feel a tiny electric shock."),
			new itemTable("negation",        "", "",	5,	700,	0,new randomRange(1,2,1), true, false, "A featureless gray disc hangs from a leather lanyard. When you touch it, your hand briefly goes numb."),
		};

		public static readonly string[] itemColorsRef = new string[] {
			"crimson",
			"scarlet",
			"orange",
			"yellow",
			"green",
			"blue",
			"indigo",
			"violet",
			"puce",
			"mauve",
			"burgundy",
			"turquoise",
			"aquamarine",
			"gray",
			"pink",
			"white",
			"lavender",
			"tan",
			"brown",
			"cyan",
			"black"
		};


		public static readonly string[] itemWoodsRef = new string[] {
			"teak",
			"oak",
			"redwood",
			"rowan",
			"willow",
			"mahogany",
			"pinewood",
			"maple",
			"bamboo",
			"ironwood",
			"pearwood",
			"birch",
			"cherry",
			"eucalyptus",
			"walnut",
			"cedar",
			"rosewood",
			"yew",
			"sandalwood",
			"hickory",
			"hemlock",
		};

		public static readonly string[] itemGemsRef = new string[] {
			"diamond",
			"opal",
			"garnet",
			"ruby",
			"amethyst",
			"topaz",
			"onyx",
			"tourmaline",
			"sapphire",
			"obsidian",
			"malachite",
			"aquamarine",
			"emerald",
			"jade",
			"alexandrite",
			"agate",
			"bloodstone",
			"jasper"
		};

		public static readonly string[] itemMetalsRef = new string[] {
			"bronze",
			"steel",
			"brass",
			"pewter",
			"nickel",
			"copper",
			"aluminum",
			"tungsten",
			"titanium",
			"cobalt",
			"chromium",
			"silver",
		};

		public static readonly string[] titlePhonemes = new string[] {
			"glorp",
			"snarg",
			"gana",
			"flin",
			"herba",
			"pora",
			"nuglo",
			"greep",
			"nur",
			"lofa",
			"poder",
			"nidge",
			"pus",
			"wooz",
			"flem",
			"bloto",
			"porta",
			"ermah",
			"gerd",
			"nurt",
			"flurx",
		};

		public feat[] featTable =  {
			new feat("Pure Mage",       "Ascend without using fists or a weapon.", true),
			new feat("Pure Warrior",    "Ascend without using a staff, wand or charm.", true),
			new feat("Pacifist",        "Ascend without attacking a creature.", true),
			new feat("Archivist",       "Ascend without drinking a potion or reading a scroll.", true),
			new feat("Companion",       "Journey with an ally through 20 depths.", false),
			new feat("Specialist",      "Enchant an item up to or above +16.", false),
			new feat("Jellymancer",     "Obtain at least 90 jelly allies simultaneously.", false),
			new feat("Indomitable",     "Ascend without taking damage.", true),
			new feat("Mystic",          "Ascend without eating.", true),
			new feat("Dragonslayer",    "Kill a dragon with a melee attack.", false),
			new feat("Paladin",         "Ascend without attacking an unaware or fleeing creature.", true),
		};


		public itemTable[] keyTable  = {
			new itemTable("door key",            "", "", 1, 0,   0, new randomRange(0,0,0), true, false, "The notches on this ancient iron key are well worn; its leather lanyard is battered by age. What door might it open?"),
			new itemTable("cage key",            "", "", 1, 0,   0, new randomRange(0,0,0), true, false, "The rust accreted on this iron key has been stained with flecks of blood; it must have been used recently. What cage might it open?"),
			new itemTable("crystal orb",         "", "", 1, 0,   0, new randomRange(0,0,0), true, false, "A faceted orb, seemingly cut from a single crystal, sparkling and perpetually warm to the touch. What manner of device might such an object activate?"),
		};

		public itemTable[] foodTable  = {
			new itemTable("ration of food",      "", "", 3, 25,  1800, new randomRange(0,0,0), true, false, "A ration of food. Was it left by former adventurers? Is it a curious byproduct of the subterranean ecosystem?"),
			new itemTable("mango",               "", "", 1, 15,  1550, new randomRange(0,0,0), true, false, "An odd fruit to be found so deep beneath the surface of the earth, but only slightly less filling than a ration of food."),
		};

		public itemTable[] weaponTable  = {
			new itemTable("dagger",              "", "", 10, 190,        12, new randomRange(3, 4,  1),     true, false, "A simple iron dagger with a well-worn wooden handle. Daggers will deal quintuple damage upon a succesful sneak attack instead of triple damage."),
			new itemTable("sword",               "", "", 10, 440,        14, new randomRange(7, 9,  1),     true, false, "The razor-sharp length of steel blade shines reassuringly."),
			new itemTable("broadsword",          "", "", 10, 990,        19, new randomRange(14, 22, 1),    true, false, "This towering blade inflicts heavy damage by investing its heft into every cut."),

			new itemTable("whip",                "", "", 10, 440,        14, new randomRange(3, 5,  1),     true, false, "This lash from this coil of braided leather can tear bark from trees, and it will reach opponents up to five spaces away."),
			new itemTable("rapier",              "", "", 10, 440,        15, new randomRange(3, 5,  1),     true, false, "This blade is thin and flexible, designed for deft and rapid maneuvers. It inflicts less damage than comparable weapons, but permits you to attack twice as quickly. If there is one space between you and an enemy and you step directly toward it, you will perform a devastating lunge attack, which deals treble damage and never misses."),
			new itemTable("flail",               "", "", 10, 440,        17, new randomRange(10,13, 1),     true, false, "The spiked iron ball can be whirled at the end of its chain in synchronicity with your movement, allowing you a free attack whenever moving between two spaces that are adjacent to an enemy."),

			new itemTable("mace",                "", "", 10, 660,        16, new randomRange(16, 20, 1),    true, false, "The iron flanges at the head of this weapon inflict substantial damage with every weighty blow. Because of its heft, it takes two turns when it hits."),
			new itemTable("war hammer",          "", "", 10, 1100,       20, new randomRange(25, 35, 1),    true, false, "Few creatures can withstand the crushing blow of this towering mass of lead and steel, but only the strongest of adventurers can effectively wield it. Because of its heft, it takes two turns when it hits."),

			new itemTable("spear",               "", "", 10, 330,        13, new randomRange(4, 5, 1),      true, false, "A slender wooden rod tipped with sharpened iron. The reach of the spear permits you to simultaneously attack an adjacent enemy and the enemy directly behind it."),
			new itemTable("war pike",            "", "", 10, 880,        18, new randomRange(11, 15, 1),    true, false, "A long steel pole ending in a razor-sharp point. The reach of the pike permits you to simultaneously attack an adjacent enemy and the enemy directly behind it."),

			new itemTable("axe",                 "", "", 10, 550,        15, new randomRange(7, 9, 1),      true, false, "The blunt iron edge on this axe glints in the darkness. The arc of its swing permits you to attack all adjacent enemies simultaneously."),
			new itemTable("war axe",             "", "", 10, 990,        19, new randomRange(12, 17, 1),    true, false, "The enormous steel head of this war axe puts considerable heft behind each stroke. The arc of its swing permits you to attack all adjacent enemies simultaneously."),

			new itemTable("dart",                "", "", 0,  15,         10, new randomRange(2, 4,  1),     true, false, "These simple metal spikes are weighted to fly true and sting their prey with a flick of the wrist."),
			new itemTable("incendiary dart",     "", "", 10, 25,         12, new randomRange(1, 2,  1),     true, false, "The barbed spike on each of these darts is designed to stick to its target while the compounds strapped to its length explode into flame."),
			new itemTable("javelin",             "", "", 10, 40,         15, new randomRange(3, 11, 3),     true, false, "This length of metal is weighted to keep the spike at its tip foremost as it sails through the air."),
		};

		public  itemTable[] armorTable  = {
			new itemTable("leather armor",   "", "", 10, 250,        10, new randomRange(30,30,0),      true, false, "This lightweight armor offers basic protection."),
			new itemTable("scale mail",      "", "", 10, 350,        12, new randomRange(40,40,0),      true, false, "Bronze scales cover the surface of treated leather, offering greater protection than plain leather with minimal additional weight."),
			new itemTable("chain mail",      "", "", 10, 500,        13, new randomRange(50,50,0),      true, false, "Interlocking metal links make for a tough but flexible suit of armor."),
			new itemTable("banded mail",     "", "", 10, 800,        15, new randomRange(70,70,0),      true, false, "Overlapping strips of metal horizontally encircle a chain mail base, offering an additional layer of protection at the cost of greater weight."),
			new itemTable("splint mail",     "", "", 10, 1000,       17, new randomRange(90,90,0),      true, false, "Thick plates of metal are embedded into a chain mail base, providing the wearer with substantial protection."),
			new itemTable("plate armor",     "", "", 10, 1300,       19, new randomRange(110,110,0),    true, false, "Enormous plates of metal are joined together into a suit that provides unmatched protection to any adventurer strong enough to bear its staggering weight."),
		};


		// radius is in units of 0.01
		public lightSource[] lightCatalog  = {
			//color                                 radius range                    fade%   passThroughCreatures
			new lightSource(),                                                                                                                            // NO_LIGHT
			new lightSource(minersLightColor,             new randomRange(0, 0, 1),                              35,             true),          // miners light
			new lightSource(fireBoltColor,                new randomRange(300, 400, 1),                  0,              false),         // burning creature light
			new lightSource(wispLightColor,               new randomRange(400, 800, 1),                  0,              false),         // will-o'-the-wisp light
			new lightSource(fireBoltColor,                new randomRange(300, 400, 1),                  0,              false),         // salamander glow
			new lightSource(pink,                                 new randomRange(600, 600, 1),                  0,              true),          // imp light
			new lightSource(pixieColor,                   new randomRange(400, 600, 1),                  50,             false),         // pixie light
			new lightSource(lichLightColor,               new randomRange(1500, 1500, 1),                0,              false),         // lich light
			new lightSource(flamedancerCoronaColor,new randomRange(1000, 2000, 1),               0,              false),         // flamedancer light
			new lightSource(sentinelLightColor,   new randomRange(300, 500, 1),                  0,              false),         // sentinel light
			new lightSource(unicornLightColor,    new randomRange(300, 400, 1),                  0,              false),         // unicorn light
			new lightSource(ifritLightColor,              new randomRange(300, 600, 1),                  0,              false),         // ifrit light
			new lightSource(fireBoltColor,                new randomRange(400, 600, 1),                  0,              false),         // phoenix light
			new lightSource(fireBoltColor,                new randomRange(150, 300, 1),                  0,              false),         // phoenix egg light
			new lightSource(yendorLightColor,             new randomRange(1500, 1500, 1),        0,              false),         // Yendorian light
			new lightSource(spectralBladeLightColor,new randomRange(350, 350, 1),                0,              false),         // spectral blades
			new lightSource(summonedImageLightColor,new randomRange(350, 350, 1),                0,              false),         // weapon images
			new lightSource(lightningColor,               new randomRange(250, 250, 1),                  35,             false),         // lightning turret light
			new lightSource(explosiveAuraColor,   new randomRange(150, 200, 1),          0,      true),      // explosive bloat light
			new lightSource(lightningColor,               new randomRange(300, 300, 1),                  0,              false),         // bolt glow
			new lightSource(telepathyColor,               new randomRange(200, 200, 1),                  0,              true),          // telepathy light

			// flares:
			new lightSource(scrollProtectionColor,new randomRange(600, 600, 1),                  0,              true),          // scroll of protection flare
			new lightSource(scrollEnchantmentColor,new randomRange(600, 600, 1),                     0,              true),          // scroll of enchantment flare
			new lightSource(potionStrengthColor,  new randomRange(600, 600, 1),                      0,              true),          // potion of strength flare
			new lightSource(empowermentFlashColor,new randomRange(600, 600, 1),                      0,              true),          // empowerment flare
			new lightSource(genericFlashColor,    new randomRange(300, 300, 1),                      0,              true),          // generic flash flare
			new lightSource(fireFlashColor,               new randomRange(800, 800, 1),                  0,              false),         // fallen torch flare
			new lightSource(summoningFlashColor,  new randomRange(600, 600, 1),                      0,              true),          // summoning flare
			new lightSource(explosionFlareColor,  new randomRange(5000, 5000, 1),        0,      true),      // explosion (explosive bloat or incineration potion)
			new lightSource(quietusFlashColor,    new randomRange(300, 300, 1),                  0,              true),          // quietus activation flare
			new lightSource(slayingFlashColor,    new randomRange(300, 300, 1),                  0,              true),          // slaying activation flare
			new lightSource(lightningColor,       new randomRange(800, 800, 1),          0,      false),     // electric crystal activates

			// glowing terrain:
			new lightSource(torchLightColor,              new randomRange(1000, 1000, 1),                50,             false),         // torch
			new lightSource(lavaLightColor,               new randomRange(300, 300, 1),                  50,             false),         // lava
			new lightSource(sunLightColor,                new randomRange(200, 200, 1),                  25,             true),          // sunlight
			new lightSource(darknessPatchColor,   new randomRange(400, 400, 1),                  0,              true),          // darkness patch
			new lightSource(fungusLightColor,             new randomRange(300, 300, 1),                  50,             false),         // luminescent fungus
			new lightSource(fungusForestLightColor,new randomRange(500, 500, 1),                 0,              false),         // luminescent forest
			new lightSource(algaeBlueLightColor,  new randomRange(300, 300, 1),                  0,              false),         // luminescent algae blue
			new lightSource(algaeGreenLightColor, new randomRange(300, 300, 1),                  0,              false),         // luminescent algae green
			new lightSource(ectoplasmColor,               new randomRange(200, 200, 1),                  50,             false),         // ectoplasm
			new lightSource(unicornLightColor,    new randomRange(200, 200, 1),                  0,              false),         // unicorn poop light
			new lightSource(lavaLightColor,               new randomRange(200, 200, 1),                  50,             false),         // embers
			new lightSource(lavaLightColor,               new randomRange(500, 1000, 1),                 0,              false),         // fire
			new lightSource(lavaLightColor,               new randomRange(200, 300, 1),                  0,              false),         // brimstone fire
			new lightSource(explosionColor,               new randomRange(DCOLS*100,DCOLS*100,1),100,    false),         // explosions
			new lightSource(dartFlashColor,               new randomRange(15*100,15*100,1),              0,              false),         // incendiary darts
			new lightSource(portalActivateLightColor,     new randomRange(DCOLS*100,DCOLS*100,1),0,      false),         // portal activation
			new lightSource(confusionLightColor,  new randomRange(300, 300, 1),                  100,    false),         // confusion gas
			new lightSource(darknessCloudColor,   new randomRange(500, 500, 1),                  0,              true),          // darkness cloud
			new lightSource(forceFieldLightColor, new randomRange(200, 200, 1),                  50,             false),         // forcefield
			new lightSource(crystalWallLightColor,new randomRange(300, 500, 1),                  50,             false),         // crystal wall
			new lightSource(torchLightColor,              new randomRange(200, 400, 1),                  0,              false),         // candle light
			new lightSource(hauntedTorchColor,        new randomRange(400, 600, 1),          0,              false),         // haunted torch
			new lightSource(glyphLightColor,      new randomRange(100, 100, 1),          0,      false),     // glyph dim light
			new lightSource(glyphLightColor,      new randomRange(300, 300, 1),          0,      false),     // glyph bright light
			new lightSource(sacredGlyphColor,     new randomRange(300, 300, 1),          0,      false),     // sacred glyph light
			new lightSource(descentLightColor,    new randomRange(600, 600, 1),          0,      false),     // magical pit light
		};

		public floorTileType[] tileCatalog = {

			// promoteChance is in hundredths of a percent per turn

			//  char        fore color              back color      priority    ignit   fireType    discovType  promoteType     promoteChance   glowLight       flags                                                                                               description         flavorText

			// dungeon layer (this layer must have all of fore color, back color and char)
			new floorTileType(   ' ',        black,                 black,                 100,0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       0, 0,                                                                                               "a chilly void",        ""),
			new floorTileType(WALL_CHAR,     wallBackColor,         graniteBackColor,      0,  0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE),                                                       "a rough granite wall", "The granite is split open with splinters of rock jutting out at odd angles."),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       0, 0,                                                                                               "the ground",           ""),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       0, 0,                                                                                               "the ground",           ""),
			new floorTileType(FLOOR_CHAR,    carpetForeColor,       carpetBackColor,       85, 0,  DF_EMBERS,      0,          0,              0,              NO_LIGHT,       (T_IS_FLAMMABLE), (TM_VANISHES_UPON_PROMOTION),                                                     "the carpet",           "Ornate carpeting fills this room, a relic of ages past."),
			new floorTileType(FLOOR_CHAR,    marbleForeColor,       marbleBackColor,       85, 0,  DF_EMBERS,      0,          0,              0,              NO_LIGHT,       0, 0,                                                                                               "the marble ground",    "Light from the nearby crystals catches the grain of the lavish marble floor."),
			new floorTileType(WALL_CHAR,     wallForeColor,         wallBackColor,         0,  0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE),                                                       "a stone wall",         "The rough stone wall is firm and unyielding."),
			new floorTileType(DOOR_CHAR,     doorForeColor,         doorBackColor,         25, 50, DF_EMBERS,      0,          DF_OPEN_DOOR,   0,              NO_LIGHT,       (T_OBSTRUCTS_VISION | T_OBSTRUCTS_GAS | T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_PROMOTES_ON_STEP | TM_VISUALLY_DISTINCT), "a wooden door", "you pass through the doorway."),
			new floorTileType(OPEN_DOOR_CHAR,doorForeColor,         doorBackColor,         25, 50, DF_EMBERS,      0,          DF_CLOSED_DOOR, 10000,          NO_LIGHT,       (T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT),           "an open door",         "you pass through the doorway."),
			new floorTileType(WALL_CHAR,     wallForeColor,         wallBackColor,         0,  50, DF_EMBERS,      DF_SHOW_DOOR,0,             0,              NO_LIGHT,       (T_OBSTRUCTS_EVERYTHING | T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_IS_SECRET),  "a stone wall",     "The rough stone wall is firm and unyielding."),
			new floorTileType(DOOR_CHAR,     ironDoorForeColor,     ironDoorBackColor,     15, 50, DF_EMBERS,      0,          DF_OPEN_IRON_DOOR_INERT,0,      NO_LIGHT,       (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_PROMOTES_WITH_KEY | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT | TM_BRIGHT_MEMORY | TM_INTERRUPT_EXPLORATION_WHEN_SEEN | TM_INVERT_WHEN_HIGHLIGHTED),  "a locked iron door",   "you search your pack but do not have a matching key."),
			new floorTileType(OPEN_DOOR_CHAR,white,                 ironDoorBackColor,     90, 50, DF_EMBERS,      0,          0,              0,              NO_LIGHT,       (T_OBSTRUCTS_SURFACE_EFFECTS), (TM_STAND_IN_TILE | TM_VISUALLY_DISTINCT),                           "an open iron door",    "you pass through the doorway."),
			new floorTileType(DESCEND_CHAR,  itemColor,             stairsBackColor,       30, 0,  DF_PLAIN_FIRE,  0,          DF_REPEL_CREATURES, 0,          NO_LIGHT,       (T_OBSTRUCTS_ITEMS | T_OBSTRUCTS_SURFACE_EFFECTS), (TM_PROMOTES_ON_STEP | TM_STAND_IN_TILE | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT | TM_BRIGHT_MEMORY | TM_INTERRUPT_EXPLORATION_WHEN_SEEN | TM_INVERT_WHEN_HIGHLIGHTED), "a downward staircase",   "stairs spiral downward into the depths."),
			new floorTileType(ASCEND_CHAR,   itemColor,             stairsBackColor,       30, 0,  DF_PLAIN_FIRE,  0,          DF_REPEL_CREATURES, 0,          NO_LIGHT,       (T_OBSTRUCTS_ITEMS | T_OBSTRUCTS_SURFACE_EFFECTS), (TM_PROMOTES_ON_STEP | TM_STAND_IN_TILE | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT | TM_BRIGHT_MEMORY | TM_INTERRUPT_EXPLORATION_WHEN_SEEN | TM_INVERT_WHEN_HIGHLIGHTED), "an upward staircase",    "stairs spiral upward."),
			new floorTileType(OMEGA_CHAR,    lightBlue,             firstStairsBackColor,  30, 0,  DF_PLAIN_FIRE,  0,          DF_REPEL_CREATURES, 0,          NO_LIGHT,       (T_OBSTRUCTS_ITEMS | T_OBSTRUCTS_SURFACE_EFFECTS), (TM_PROMOTES_ON_STEP | TM_STAND_IN_TILE | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT | TM_BRIGHT_MEMORY | TM_INTERRUPT_EXPLORATION_WHEN_SEEN | TM_INVERT_WHEN_HIGHLIGHTED), "the dungeon exit",       "the gilded doors leading out of the dungeon are sealed by an invisible force."),
			new floorTileType(OMEGA_CHAR,    wallCrystalColor,      firstStairsBackColor,  30, 0,  DF_PLAIN_FIRE,  0,          DF_REPEL_CREATURES, 0,          INCENDIARY_DART_LIGHT,      (T_OBSTRUCTS_ITEMS | T_OBSTRUCTS_SURFACE_EFFECTS), (TM_PROMOTES_ON_STEP | TM_STAND_IN_TILE | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT | TM_BRIGHT_MEMORY | TM_INTERRUPT_EXPLORATION_WHEN_SEEN | TM_INVERT_WHEN_HIGHLIGHTED), "a crystal portal",       "dancing lights play across the plane of this sparkling crystal portal."),
			new floorTileType(WALL_CHAR,     torchColor,            wallBackColor,         0,  0,  DF_PLAIN_FIRE,  0,          0,              0,              TORCH_LIGHT,    (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE),                                                       "a wall-mounted torch", "The torch is anchored firmly to the wall and sputters quietly in the gloom."),
			new floorTileType(WALL_CHAR,     wallCrystalColor,      wallCrystalColor,      0,  0,  DF_PLAIN_FIRE,  0,          0,              0,              CRYSTAL_WALL_LIGHT,(T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_ITEMS | T_OBSTRUCTS_GAS | T_OBSTRUCTS_SURFACE_EFFECTS | T_OBSTRUCTS_DIAGONAL_MOVEMENT), (TM_STAND_IN_TILE | TM_REFLECTS_BOLTS),"a crystal formation", "You feel the crystal's glossy surface and admire the dancing lights beneath."),
			new floorTileType(WALL_CHAR,     gray,                  floorBackColor,        10, 0,  DF_PLAIN_FIRE,  0,          DF_OPEN_PORTCULLIS, 0,          NO_LIGHT,       (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_ITEMS), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT | TM_CONNECTS_LEVEL), "a heavy portcullis", "The iron bars rattle but will not budge; they are firmly locked in place."),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_PLAIN_FIRE,  0,          DF_ACTIVATE_PORTCULLIS,0,       NO_LIGHT,       (0), (TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED),                                                    "the ground",           ""),
			new floorTileType(WALL_CHAR,     doorForeColor,         floorBackColor,        10, 100,DF_WOODEN_BARRICADE_BURN,0, 0,              0,              NO_LIGHT,       (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_ITEMS | T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT | TM_CONNECTS_LEVEL),"a dry wooden barricade","The wooden barricade is firmly set but has dried over the years. Might it burn?"),
			new floorTileType(WALL_CHAR,     torchLightColor,       wallBackColor,         0,  0,  DF_PLAIN_FIRE,  0,          DF_PILOT_LIGHT, 0,              TORCH_LIGHT,    (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED),            "a wall-mounted torch", "The torch is anchored firmly to the wall, and sputters quietly in the gloom."),
			new floorTileType(FIRE_CHAR,     fireForeColor,         wallBackColor,         0,  0,  DF_PLAIN_FIRE,  0,          0,              0,              TORCH_LIGHT,    (T_OBSTRUCTS_EVERYTHING | T_IS_FIRE), (TM_STAND_IN_TILE | TM_LIST_IN_SIDEBAR),                      "a fallen torch",       "The torch lies at the foot of the wall, spouting gouts of flame haphazardly."),
			new floorTileType(WALL_CHAR,     torchColor,            wallBackColor,         0,  0,  DF_PLAIN_FIRE,  0,          DF_HAUNTED_TORCH_TRANSITION,0,  TORCH_LIGHT,    (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED),            "a wall-mounted torch", "The torch is anchored firmly to the wall and sputters quietly in the gloom."),
			new floorTileType(WALL_CHAR,     torchColor,            wallBackColor,         0,  0,  DF_PLAIN_FIRE,  0,          DF_HAUNTED_TORCH,2000,          TORCH_LIGHT,    (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION),                          "a wall-mounted torch", "The torch is anchored firmly to the wall and sputters quietly in the gloom."),
			new floorTileType(WALL_CHAR,     hauntedTorchColor,     wallBackColor,         0,  0,  DF_PLAIN_FIRE,  0,          0,              0,              HAUNTED_TORCH_LIGHT,(T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE),                                                   "a sputtering torch",   "A dim purple flame sputters and spits atop this wall-mounted torch."),
			new floorTileType(WALL_CHAR,     wallForeColor,         wallBackColor,         0,  0,  DF_PLAIN_FIRE,  DF_REVEAL_LEVER,0,          0,              NO_LIGHT,       (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_IS_SECRET),           "a stone wall",         "The rough stone wall is firm and unyielding."),
			new floorTileType(LEVER_CHAR,    wallForeColor,         wallBackColor,         0,  0,  DF_PLAIN_FIRE,  0,          DF_PULL_LEVER,  0,              NO_LIGHT,       (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED | TM_PROMOTES_ON_PLAYER_ENTRY | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT | TM_INVERT_WHEN_HIGHLIGHTED),"a lever", "The lever moves."),
			new floorTileType(LEVER_PULLED_CHAR,wallForeColor,      wallBackColor,         0,  0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE),                                                       "an inactive lever",    "The lever won't budge."),
			new floorTileType(WALL_CHAR,     wallForeColor,         wallBackColor,         0,  0,  DF_PLAIN_FIRE,  0,          DF_CREATE_LEVER,0,              NO_LIGHT,       (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE | TM_IS_WIRED),                                         "a stone wall",         "The rough stone wall is firm and unyielding."),
			new floorTileType(STATUE_CHAR,   wallBackColor,         statueBackColor,       0,  0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_ITEMS | T_OBSTRUCTS_GAS | T_OBSTRUCTS_SURFACE_EFFECTS), (TM_STAND_IN_TILE),  "a marble statue",  "The cold marble statue has weathered the years with grace."),
			new floorTileType(STATUE_CHAR,   wallBackColor,         statueBackColor,       0,  0,  DF_PLAIN_FIRE,  0,          DF_CRACKING_STATUE,0,           NO_LIGHT,       (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_ITEMS | T_OBSTRUCTS_GAS | T_OBSTRUCTS_SURFACE_EFFECTS), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED),"a marble statue", "The cold marble statue has weathered the years with grace."),
			new floorTileType(STATUE_CHAR,   wallBackColor,         statueBackColor,       0,  0,  DF_PLAIN_FIRE,  0,          DF_STATUE_SHATTER,3500,         NO_LIGHT,       (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_ITEMS | T_OBSTRUCTS_GAS | T_OBSTRUCTS_SURFACE_EFFECTS), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_LIST_IN_SIDEBAR),"a cracking statue",    "Deep cracks ramble down the side of the statue even as you watch."),
			new floorTileType(STATUE_CHAR,   wallBackColor,         statueBackColor,       0,  0,  DF_PLAIN_FIRE,  0,          DF_STATUE_SHATTER,0,            NO_LIGHT,       (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_ITEMS | T_OBSTRUCTS_GAS | T_OBSTRUCTS_SURFACE_EFFECTS), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED),"a marble statue", "The cold marble statue has weathered the years with grace."),
			new floorTileType(OMEGA_CHAR,    wallBackColor,         floorBackColor,        17, 0,  DF_PLAIN_FIRE,  0,          DF_PORTAL_ACTIVATE,0,           NO_LIGHT,       (T_OBSTRUCTS_ITEMS), (TM_STAND_IN_TILE | TM_IS_WIRED | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),  "a stone archway",      "This ancient moss-covered stone archway radiates a strange, alien energy."),
			new floorTileType(WALL_CHAR,     wallForeColor,         wallBackColor,         0,  0,  DF_PLAIN_FIRE,  0,          DF_TURRET_EMERGE,0,             NO_LIGHT,       (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED),            "a stone wall",         "The rough stone wall is firm and unyielding."),
			new floorTileType(WALL_CHAR,     wallForeColor,         wallBackColor,         0,  0,  DF_PLAIN_FIRE,  0,          DF_WALL_SHATTER,0,              NO_LIGHT,       (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED),            "a stone wall",         "The rough stone wall is firm and unyielding."),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_PLAIN_FIRE,  0,          DF_DARKENING_FLOOR, 0,          NO_LIGHT,       (0), (TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED),                                                    "the ground",           ""),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_PLAIN_FIRE,  0,          DF_DARK_FLOOR,  1500,           NO_LIGHT,       (0), (TM_VANISHES_UPON_PROMOTION),                                                                  "the ground",           ""),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_PLAIN_FIRE,  0,          0,              0,              DARKNESS_CLOUD_LIGHT, 0, 0,                                                                                         "the ground",           ""),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (0), (TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED | TM_PROMOTES_ON_PLAYER_ENTRY),                      "the ground",           ""),
			new floorTileType(ALTAR_CHAR,    altarForeColor,        altarBackColor,        17, 0,  0,              0,          0,              0,              CANDLE_LIGHT,   (T_OBSTRUCTS_SURFACE_EFFECTS), (TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),                         "a candle-lit altar",   "a gilded altar is adorned with candles that flicker in the breeze."),
			new floorTileType(GEM_CHAR,      altarForeColor,        altarBackColor,        17, 0,  0,              0,          0,              0,              CANDLE_LIGHT,   (T_OBSTRUCTS_SURFACE_EFFECTS), (TM_PROMOTES_WITH_KEY | TM_IS_WIRED | TM_LIST_IN_SIDEBAR),           "a candle-lit altar",   "ornate gilding spirals around a spherical depression in the top of the altar."),
			new floorTileType(ALTAR_CHAR,    altarForeColor,        altarBackColor,        17, 0,  0,              0,          DF_ITEM_CAGE_CLOSE, 0,          CANDLE_LIGHT,   (T_OBSTRUCTS_SURFACE_EFFECTS), (TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED | TM_PROMOTES_WITHOUT_KEY | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),"a candle-lit altar",   "a cage, open on the bottom, hangs over this altar on a retractable chain."),
			new floorTileType(WALL_CHAR,     altarBackColor,        veryDarkGray,          17, 0,  0,              0,          DF_ITEM_CAGE_OPEN,  0,          CANDLE_LIGHT,   (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_SURFACE_EFFECTS), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_PROMOTES_WITH_KEY | TM_IS_WIRED | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),"an iron cage","the missing item must be replaced before you can access the remaining items."),
			new floorTileType(ALTAR_CHAR,    altarForeColor,        altarBackColor,        17, 0,  0,              0,          DF_ALTAR_INERT, 0,              CANDLE_LIGHT,   (T_OBSTRUCTS_SURFACE_EFFECTS), (TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED | TM_PROMOTES_ON_ITEM_PICKUP | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT), "a candle-lit altar",   "a weathered stone altar is adorned with candles that flicker in the breeze."),
			new floorTileType(ALTAR_CHAR,    altarForeColor,        altarBackColor,        17, 0,  0,              0,          DF_ALTAR_RETRACT,0,             CANDLE_LIGHT,   (T_OBSTRUCTS_SURFACE_EFFECTS), (TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED | TM_PROMOTES_ON_ITEM_PICKUP | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT), "a candle-lit altar",   "a weathered stone altar is adorned with candles that flicker in the breeze."),
			new floorTileType(WALL_CHAR,     altarBackColor,        veryDarkGray,          17, 0,  0,              0,          DF_CAGE_DISAPPEARS, 0,          CANDLE_LIGHT,   (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_SURFACE_EFFECTS), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),"an iron cage","the cage won't budge. Perhaps there is a way to raise it nearby..."),
			new floorTileType(ALTAR_CHAR,    altarForeColor,        pedestalBackColor,     17, 0,  0,              0,          0,              0,              CANDLE_LIGHT,   (T_OBSTRUCTS_SURFACE_EFFECTS), 0,                                                                   "a stone pedestal",     "elaborate carvings wind around this ancient pedestal."),
			new floorTileType(ALTAR_CHAR,    floorBackColor,        veryDarkGray,          17, 0,  0,              0,          0,              0,              NO_LIGHT,       (0), (TM_STAND_IN_TILE),                                                                            "an open cage",         "the interior of the cage is filthy and reeks of decay."),
			new floorTileType(WALL_CHAR,     gray,                  darkGray,              17, 0,  0,              0,          DF_MONSTER_CAGE_OPENS,  0,      NO_LIGHT,       (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_SURFACE_EFFECTS | T_OBSTRUCTS_GAS), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_PROMOTES_WITH_KEY | TM_LIST_IN_SIDEBAR | TM_INTERRUPT_EXPLORATION_WHEN_SEEN),"a locked iron cage","the bars of the cage are firmly set and will not budge."),
			new floorTileType(ALTAR_CHAR,    bridgeFrontColor,      bridgeBackColor,       17, 20, DF_COFFIN_BURNS,0,          DF_COFFIN_BURSTS,0,             NO_LIGHT,       (T_IS_FLAMMABLE), (TM_IS_WIRED | TM_VANISHES_UPON_PROMOTION | TM_LIST_IN_SIDEBAR),                  "a sealed coffin",      "a coffin made from thick wooden planks rests in a bed of moss."),
			new floorTileType(ALTAR_CHAR,    black,                 bridgeBackColor,       17, 20, DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_LIST_IN_SIDEBAR),             "an empty coffin",      "an open wooden coffin rests in a bed of moss."),

			// traps (part of dungeon layer):
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_POISON_GAS_CLOUD, DF_SHOW_POISON_GAS_TRAP, 0, 0,         NO_LIGHT,       (T_IS_DF_TRAP), (TM_IS_SECRET),                                                                     "the ground",           ""),
			new floorTileType(TRAP_CHAR,     poisonGasColor,        0,                      30, 0,  DF_POISON_GAS_CLOUD, 0,     0,              0,              NO_LIGHT,       (T_IS_DF_TRAP), (TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),                                        "a caustic gas trap",   "there is a hidden pressure plate in the floor above a reserve of caustic gas."),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_POISON_GAS_CLOUD, DF_SHOW_TRAPDOOR,0,    0,              NO_LIGHT,       (T_AUTO_DESCENT), (TM_IS_SECRET),                                                                   "the ground",           "you plunge through a hidden trap door!"),
			new floorTileType(CHASM_CHAR,    chasmForeColor,        black,                 30, 0,  DF_POISON_GAS_CLOUD,0,      0,              0,              NO_LIGHT,       (T_AUTO_DESCENT), 0,                                                                                "a hole",               "you plunge through a hole in the ground!"),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  0,              DF_SHOW_PARALYSIS_GAS_TRAP, 0, 0,           NO_LIGHT,       (T_IS_DF_TRAP), (TM_IS_SECRET | TM_IS_WIRED),                                                       "the ground",           ""),
			new floorTileType(TRAP_CHAR,     pink,                  0,                      30, 0,  0,              0,          0,              0,              NO_LIGHT,       (T_IS_DF_TRAP), (TM_IS_WIRED | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),                          "a paralysis trigger",  "there is a hidden pressure plate in the floor."),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_PLAIN_FIRE,  DF_DISCOVER_PARALYSIS_VENT, DF_PARALYSIS_VENT_SPEW,0,NO_LIGHT,  (0), (TM_VANISHES_UPON_PROMOTION | TM_IS_SECRET | TM_IS_WIRED),                                 "the ground",           ""),
			new floorTileType(VENT_CHAR,     pink,                  0,                      30, 0,  DF_PLAIN_FIRE,  0,          DF_PARALYSIS_VENT_SPEW,0,       NO_LIGHT,       (0), (TM_IS_WIRED | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),                                     "an inactive gas vent", "A dormant gas vent is connected to a reserve of paralytic gas."),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_CONFUSION_GAS_TRAP_CLOUD,DF_SHOW_CONFUSION_GAS_TRAP, 0,0,NO_LIGHT,       (T_IS_DF_TRAP), (TM_IS_SECRET),                                                                     "the ground",           ""),
			new floorTileType(TRAP_CHAR,     confusionGasColor,     0,                      30, 0,  DF_CONFUSION_GAS_TRAP_CLOUD,0,  0,          0,              NO_LIGHT,       (T_IS_DF_TRAP), (TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),                                        "a confusion trap",     "A hidden pressure plate accompanies a reserve of psychotropic gas."),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_FLAMETHROWER,    DF_SHOW_FLAMETHROWER_TRAP, 0,   0,      NO_LIGHT,       (T_IS_DF_TRAP), (TM_IS_SECRET),                                                                     "the ground",           ""),
			new floorTileType(TRAP_CHAR,     red,                   0,                      30, 0,  DF_FLAMETHROWER,    0,      0,              0,              NO_LIGHT,       (T_IS_DF_TRAP), (TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),                                        "a fire trap",          "A hidden pressure plate is connected to a crude flamethrower mechanism."),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_FLOOD,       DF_SHOW_FLOOD_TRAP, 0,      0,              NO_LIGHT,       (T_IS_DF_TRAP), (TM_IS_SECRET),                                                                     "the ground",           ""),
			new floorTileType(TRAP_CHAR,     blue,                  0,                      58, 0,  DF_FLOOD,       0,          0,              0,              NO_LIGHT,       (T_IS_DF_TRAP), (TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),                                        "a flood trap",         "A hidden pressure plate is connected to floodgates in the walls and ceiling."),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_NET,         DF_SHOW_NET_TRAP, 0,        0,              NO_LIGHT,       (T_IS_DF_TRAP), (TM_IS_SECRET),                                                                     "the ground",           ""),
			new floorTileType(TRAP_CHAR,     tanColor,              0,                      30, 0,  DF_NET,         0,          0,              0,              NO_LIGHT,       (T_IS_DF_TRAP), (TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),                                        "a net trap",           "you see netting subtly concealed in the ceiling over a hidden pressure plate."),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_AGGRAVATE_TRAP, DF_SHOW_ALARM_TRAP, 0,   0,              NO_LIGHT,       (T_IS_DF_TRAP), (TM_IS_SECRET),                                                                     "the ground",           ""),
			new floorTileType(TRAP_CHAR,     gray,                  0,                      30, 0,  DF_AGGRAVATE_TRAP, 0,       0,              0,              NO_LIGHT,       (T_IS_DF_TRAP), (TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),                                        "an alarm trap",        "a hidden pressure plate is connected to a loud alarm mechanism."),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_PLAIN_FIRE,  DF_SHOW_POISON_GAS_VENT, DF_POISON_GAS_VENT_OPEN, 0, NO_LIGHT, (0), (TM_VANISHES_UPON_PROMOTION | TM_IS_SECRET | TM_IS_WIRED),                                  "the ground",           ""),
			new floorTileType(VENT_CHAR,     floorForeColor,        0,                      30, 0,  DF_PLAIN_FIRE,  0,          DF_POISON_GAS_VENT_OPEN,0,      NO_LIGHT,       (0), (TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),        "an inactive gas vent", "An inactive gas vent is hidden in a crevice in the ground."),
			new floorTileType(VENT_CHAR,     floorForeColor,        0,                      30, 0,  DF_PLAIN_FIRE,  0,          DF_VENT_SPEW_POISON_GAS,10000,  NO_LIGHT,       0, (TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),                                                     "a gas vent",           "Clouds of caustic gas are wafting out of a hidden vent in the floor."),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_PLAIN_FIRE,  DF_SHOW_METHANE_VENT, DF_METHANE_VENT_OPEN,0,NO_LIGHT,      (0), (TM_VANISHES_UPON_PROMOTION | TM_IS_SECRET | TM_IS_WIRED),                                     "the ground",           ""),
			new floorTileType(VENT_CHAR,     floorForeColor,        0,                      30, 0,  DF_PLAIN_FIRE,  0,          DF_METHANE_VENT_OPEN,0,         NO_LIGHT,       (0), (TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),        "an inactive gas vent", "An inactive gas vent is hidden in a crevice in the ground."),
			new floorTileType(VENT_CHAR,     floorForeColor,        0,                      30, 15, DF_EMBERS,      0,          DF_VENT_SPEW_METHANE,5000,      NO_LIGHT,       (T_IS_FLAMMABLE), (TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),                                      "a gas vent",           "Clouds of explosive gas are wafting out of a hidden vent in the floor."),
			new floorTileType(VENT_CHAR,     gray,                  0,                      15, 15, DF_EMBERS,      0,          DF_STEAM_PUFF,  250,            NO_LIGHT,       T_OBSTRUCTS_ITEMS, (TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),                                     "a steam vent",         "A natural crevice in the floor periodically vents scalding gouts of steam."),
			new floorTileType(TRAP_CHAR,     white,                 chasmEdgeBackColor,    15, 0,  0,              0,          DF_MACHINE_PRESSURE_PLATE_USED,0,NO_LIGHT,      (T_IS_DF_TRAP), (TM_VANISHES_UPON_PROMOTION | TM_PROMOTES_ON_STEP | TM_IS_WIRED | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),"a pressure plate",        "There is an exposed pressure plate here. A thrown item might trigger it."),
			new floorTileType(TRAP_CHAR,     darkGray,              chasmEdgeBackColor,    15, 0,  0,              0,          0,              0,              NO_LIGHT,       0, (TM_LIST_IN_SIDEBAR),                                                                            "an inactive pressure plate", "This pressure plate has already been depressed."),
			new floorTileType(CHASM_CHAR,    glyphColor,            0,                      42, 0,  0,              0,          DF_INACTIVE_GLYPH,0,            GLYPH_LIGHT_DIM,(0), (TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED | TM_PROMOTES_ON_PLAYER_ENTRY | TM_VISUALLY_DISTINCT),"a magical glyph",      "A strange glyph, engraved into the floor, flickers with magical light."),
			new floorTileType(CHASM_CHAR,    glyphColor,            0,                      42, 0,  0,              0,          DF_ACTIVE_GLYPH,10000,          GLYPH_LIGHT_BRIGHT,(0), (TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT),                                        "a glowing glyph",      "A strange glyph, engraved into the floor, radiates magical light."),
			new floorTileType(DEWAR_CHAR,    poisonGasColor,        darkGray,              10, 20, DF_DEWAR_CAUSTIC,0,         DF_DEWAR_CAUSTIC,0,             NO_LIGHT,       (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_SURFACE_EFFECTS | T_OBSTRUCTS_GAS | T_IS_FLAMMABLE), (TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT | TM_LIST_IN_SIDEBAR | TM_PROMOTES_ON_PLAYER_ENTRY | TM_INVERT_WHEN_HIGHLIGHTED),"a glass dewar of caustic gas", ""),
			new floorTileType(DEWAR_CHAR,    confusionGasColor,     darkGray,              10, 20, DF_DEWAR_CONFUSION,0,       DF_DEWAR_CONFUSION,0,           NO_LIGHT,       (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_SURFACE_EFFECTS | T_OBSTRUCTS_GAS | T_IS_FLAMMABLE), (TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT | TM_LIST_IN_SIDEBAR | TM_PROMOTES_ON_PLAYER_ENTRY | TM_INVERT_WHEN_HIGHLIGHTED),"a glass dewar of confusion gas", ""),
			new floorTileType(DEWAR_CHAR,    pink,                  darkGray,              10, 20, DF_DEWAR_PARALYSIS,0,       DF_DEWAR_PARALYSIS,0,           NO_LIGHT,       (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_SURFACE_EFFECTS | T_OBSTRUCTS_GAS | T_IS_FLAMMABLE), (TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT | TM_LIST_IN_SIDEBAR | TM_PROMOTES_ON_PLAYER_ENTRY | TM_INVERT_WHEN_HIGHLIGHTED),"a glass dewar of paralytic gas", ""),
			new floorTileType(DEWAR_CHAR,    methaneColor,          darkGray,              10, 20, DF_DEWAR_METHANE,0,         DF_DEWAR_METHANE,0,             NO_LIGHT,       (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_SURFACE_EFFECTS | T_OBSTRUCTS_GAS | T_IS_FLAMMABLE), (TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT | TM_LIST_IN_SIDEBAR | TM_PROMOTES_ON_PLAYER_ENTRY | TM_INVERT_WHEN_HIGHLIGHTED),"a glass dewar of methane gas", ""),

			// liquid layer
			new floorTileType(LIQUID_CHAR,   deepWaterForeColor,    deepWaterBackColor,    40, 100,DF_STEAM_ACCUMULATION,  0,  0,              0,              NO_LIGHT,       (T_IS_FLAMMABLE | T_IS_DEEP_WATER), (TM_ALLOWS_SUBMERGING | TM_STAND_IN_TILE | TM_EXTINGUISHES_FIRE),"the murky waters",    "the current tugs you in all directions."),
			new floorTileType(0,             shallowWaterForeColor, shallowWaterBackColor, 55, 0,  DF_STEAM_ACCUMULATION,  0,  0,              0,              NO_LIGHT,       (0), (TM_STAND_IN_TILE | TM_EXTINGUISHES_FIRE | TM_ALLOWS_SUBMERGING),                              "shallow water",        "the water is cold and reaches your knees."),
			new floorTileType(MUD_CHAR,      mudForeColor,          mudBackColor,          55, 0,  DF_PLAIN_FIRE,  0,          DF_METHANE_GAS_PUFF, 100,       NO_LIGHT,       (0), (TM_STAND_IN_TILE | TM_ALLOWS_SUBMERGING),                                                     "a bog",                "you are knee-deep in thick, foul-smelling mud."),
			new floorTileType(CHASM_CHAR,    chasmForeColor,        black,                 40, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (T_AUTO_DESCENT), (TM_STAND_IN_TILE),                                                               "a chasm",              "you plunge downward into the chasm!"),
			new floorTileType(FLOOR_CHAR,    white,                 chasmEdgeBackColor,    80, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       0, 0,                                                                                               "the brink of a chasm", "chilly winds blow upward from the stygian depths."),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_PLAIN_FIRE,  0,          DF_SPREADABLE_COLLAPSE,0,       NO_LIGHT,       (0), (TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED),                                                    "the ground",           ""),
			new floorTileType(FLOOR_CHAR,    white,                 chasmEdgeBackColor,    45, 0,  DF_PLAIN_FIRE,  0,          DF_COLLAPSE_SPREADS,2500,       NO_LIGHT,       (0), (TM_VANISHES_UPON_PROMOTION),                                                                  "the crumbling ground", "cracks are appearing in the ground beneath your feet!"),
			new floorTileType(LIQUID_CHAR,   fireForeColor,         lavaBackColor,         40, 0,  DF_OBSIDIAN,    0,          0,              0,              LAVA_LIGHT,     (T_LAVA_INSTA_DEATH), (TM_STAND_IN_TILE | TM_ALLOWS_SUBMERGING),                                    "lava",                 "searing heat rises from the lava."),
			new floorTileType(LIQUID_CHAR,   fireForeColor,         lavaBackColor,         40, 0,  DF_OBSIDIAN,    0,          DF_RETRACTING_LAVA, 0,          LAVA_LIGHT,     (T_LAVA_INSTA_DEATH), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED | TM_ALLOWS_SUBMERGING),"lava","searing heat rises from the lava."),
			new floorTileType(LIQUID_CHAR,   fireForeColor,         lavaBackColor,         40, 0,  DF_OBSIDIAN,    0,          DF_OBSIDIAN_WITH_STEAM, -1500,  LAVA_LIGHT,     (T_LAVA_INSTA_DEATH), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_ALLOWS_SUBMERGING),       "cooling lava",         "searing heat rises from the lava."),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        90, 0,  DF_PLAIN_FIRE,  0,          0,              0,              SUN_LIGHT,      (0), (TM_STAND_IN_TILE),                                                                            "a patch of sunlight",  "sunlight streams through cracks in the ceiling."),
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        90, 0,  DF_PLAIN_FIRE,  0,          0,              0,              DARKNESS_PATCH_LIGHT,   (0), 0,                                                                                     "a patch of shadows",   "this area happens to be cloaked in shadows -- perhaps a safe place to hide."),
			new floorTileType(ASH_CHAR,      brimstoneForeColor,    brimstoneBackColor,    40, 100,DF_INERT_BRIMSTONE, 0,      DF_INERT_BRIMSTONE, 10,         NO_LIGHT,       (T_IS_FLAMMABLE | T_SPONTANEOUSLY_IGNITES), 0,                                                      "hissing brimstone",    "the jagged brimstone hisses and spits ominously as it crunches under your feet."),
			new floorTileType(ASH_CHAR,      brimstoneForeColor,    brimstoneBackColor,    40, 0,  DF_INERT_BRIMSTONE, 0,      DF_ACTIVE_BRIMSTONE, 800,       NO_LIGHT,       (T_SPONTANEOUSLY_IGNITES), 0,                                                                       "hissing brimstone",    "the jagged brimstone hisses and spits ominously as it crunches under your feet."),
			new floorTileType(FLOOR_CHAR,    darkGray,              obsidianBackColor,     50, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       0, 0,                                                                                               "the obsidian ground",  "the ground has fused into obsidian."),
			new floorTileType(BRIDGE_CHAR,   bridgeFrontColor,      bridgeBackColor,       45, 50, DF_BRIDGE_FIRE, 0,          0,              0,              NO_LIGHT,       (T_IS_FLAMMABLE), (TM_VANISHES_UPON_PROMOTION),                                                     "a rickety rope bridge","the rickety rope bridge creaks underfoot."),
			new floorTileType(BRIDGE_CHAR,   bridgeFrontColor,      bridgeBackColor,       45, 50, DF_BRIDGE_FALL, 0,          DF_BRIDGE_FALL, 10000,          NO_LIGHT,       (T_IS_FLAMMABLE), (TM_VANISHES_UPON_PROMOTION),                                                     "a plummeting bridge",  "the bridge is plunging into the chasm before your eyes!"),
			new floorTileType(BRIDGE_CHAR,   bridgeFrontColor,      bridgeBackColor,       45, 50, DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (T_IS_FLAMMABLE), (TM_VANISHES_UPON_PROMOTION),                                                     "a rickety rope bridge","the rickety rope bridge is staked to the edge of the chasm."),
			new floorTileType(FLOOR_CHAR,    white,                 chasmEdgeBackColor,    20, 50, DF_BRIDGE_FIRE, 0,          0,              0,              NO_LIGHT,       0, 0,                                                                                               "a stone bridge",       "the narrow stone bridge winds precariously across the chasm."),
			new floorTileType(0,             shallowWaterForeColor, shallowWaterBackColor, 60, 0,  DF_STEAM_ACCUMULATION,  0,  DF_SPREADABLE_WATER,0,          NO_LIGHT,       (0), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED | TM_EXTINGUISHES_FIRE | TM_ALLOWS_SUBMERGING),   "shallow water",    "the water is cold and reaches your knees."),
			new floorTileType(0,             shallowWaterForeColor, shallowWaterBackColor, 60, 0,  DF_STEAM_ACCUMULATION,  0,  DF_WATER_SPREADS,2500,          NO_LIGHT,       (0), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_EXTINGUISHES_FIRE | TM_ALLOWS_SUBMERGING), "shallow water",        "the water is cold and reaches your knees."),
			new floorTileType(MUD_CHAR,      mudForeColor,          mudBackColor,          55, 0,  DF_PLAIN_FIRE,  0,          DF_MUD_ACTIVATE,0,              NO_LIGHT,       (0), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED | TM_ALLOWS_SUBMERGING),          "a bog",                "you are knee-deep in thick, foul-smelling mud."),

			// surface layer
			new floorTileType(CHASM_CHAR,    chasmForeColor,        black,                 9,  0,  DF_PLAIN_FIRE,  0,          DF_HOLE_DRAIN,  -1000,          NO_LIGHT,       (T_AUTO_DESCENT), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION),                                  "a hole",               "you plunge downward into the hole!"),
			new floorTileType(CHASM_CHAR,    chasmForeColor,        black,                 9,  0,  DF_PLAIN_FIRE,  0,          DF_HOLE_DRAIN,  -1000,          DESCENT_LIGHT,  (T_AUTO_DESCENT), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION),                                  "a hole",               "you plunge downward into the hole!"),
			new floorTileType(FLOOR_CHAR,    white,                 chasmEdgeBackColor,    50, 0,  DF_PLAIN_FIRE,  0,          0,              -500,           NO_LIGHT,       (0), (TM_VANISHES_UPON_PROMOTION),                                                                  "translucent ground",   "chilly gusts of air blow upward through the translucent floor."),
			new floorTileType(LIQUID_CHAR,   deepWaterForeColor,    deepWaterBackColor,    41, 100,DF_STEAM_ACCUMULATION,  0,  DF_FLOOD_DRAIN, -200,           NO_LIGHT,       (T_IS_FLAMMABLE | T_IS_DEEP_WATER), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_EXTINGUISHES_FIRE | TM_ALLOWS_SUBMERGING), "sloshing water", "roiling water floods the room."),
			new floorTileType(0,             shallowWaterForeColor, shallowWaterBackColor, 50, 0,  DF_STEAM_ACCUMULATION,  0,  DF_PUDDLE,      -100,           NO_LIGHT,       (0), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_EXTINGUISHES_FIRE | TM_ALLOWS_SUBMERGING), "shallow water",        "knee-deep water drains slowly into holes in the floor."),
			new floorTileType(GRASS_CHAR,    grassColor,            0,                      60, 15, DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION),                                  "grass-like fungus",    "grass-like fungus crunches underfoot."),
			new floorTileType(GRASS_CHAR,    deadGrassColor,        0,                      60, 40, DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION),                                  "withered fungus",      "dead fungus covers the ground."),
			new floorTileType(GRASS_CHAR,    grayFungusColor,       0,                      51, 10, DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION),                                  "withered fungus",      "groping tendrils of pale fungus rise from the muck."),
			new floorTileType(GRASS_CHAR,    fungusColor,           0,                      60, 10, DF_PLAIN_FIRE,  0,          0,              0,              FUNGUS_LIGHT,   (T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION),                                  "luminescent fungus",   "luminescent fungus casts a pale, eerie glow."),
			new floorTileType(GRASS_CHAR,    lichenColor,           0,                      60, 50, DF_PLAIN_FIRE,  0,          DF_LICHEN_GROW, 10000,          NO_LIGHT,       (T_CAUSES_POISON | T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION),                "deadly lichen",        "venomous barbs cover the quivering tendrils of this fast-growing lichen."),
			new floorTileType(GRASS_CHAR,    hayColor,              refuseBackColor,       57, 50, DF_STENCH_BURN, 0,          0,              0,              NO_LIGHT,       (T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION),                                  "filthy hay",           "a pile of hay, matted with filth, has been arranged here as a makeshift bed."),
			new floorTileType(FLOOR_CHAR,    humanBloodColor,       0,                      80, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (0), (TM_STAND_IN_TILE),                                                                            "a pool of blood",      "the floor is splattered with blood."),
			new floorTileType(FLOOR_CHAR,    insectBloodColor,      0,                      80, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (0), (TM_STAND_IN_TILE),                                                                            "a pool of green blood", "the floor is splattered with green blood."),
			new floorTileType(FLOOR_CHAR,    poisonGasColor,        0,                      80, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (0), (TM_STAND_IN_TILE),                                                                            "a pool of purple blood", "the floor is splattered with purple blood."),
			new floorTileType(FLOOR_CHAR,    acidBackColor,         0,                      80, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       0, 0,                                                                                               "the acid-flecked ground", "the floor is splattered with acid."),
			new floorTileType(FLOOR_CHAR,    vomitColor,            0,                      80, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (0), (TM_STAND_IN_TILE),                                                                            "a puddle of vomit",    "the floor is caked with vomit."),
			new floorTileType(FLOOR_CHAR,    urineColor,            0,                      80, 0,  DF_PLAIN_FIRE,  0,          0,              100,            NO_LIGHT,       (0), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION),                                               "a puddle of urine",    "a puddle of urine covers the ground."),
			new floorTileType(FLOOR_CHAR,    white,                 0,                      80, 0,  DF_PLAIN_FIRE,  0,          0,              0,              UNICORN_POOP_LIGHT,(0), (TM_STAND_IN_TILE),                                                                         "unicorn poop",         "a pile of lavender-scented unicorn poop sparkles with rainbow light."),
			new floorTileType(FLOOR_CHAR,    wormColor,             0,                      80, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (0), (TM_STAND_IN_TILE),                                                                            "a pool of worm entrails", "worm viscera cover the ground."),
			new floorTileType(ASH_CHAR,      ashForeColor,          0,                      80, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (0), (TM_STAND_IN_TILE),                                                                            "a pile of ashes",      "charcoal and ash crunch underfoot."),
			new floorTileType(ASH_CHAR,      ashForeColor,          0,                      87, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (0), (TM_STAND_IN_TILE),                                                                            "burned carpet",        "the carpet has been scorched by an ancient fire."),
			new floorTileType(FLOOR_CHAR,    shallowWaterBackColor, 0,                      80, 20, 0,              0,          0,              100,            NO_LIGHT,       (T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION),                                  "a puddle of water",    "a puddle of water covers the ground."),
			new floorTileType(BONES_CHAR,    bonesForeColor,        0,                      70, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (0), (TM_STAND_IN_TILE),                                                                            "a pile of bones",      "unidentifiable bones, yellowed with age, litter the ground."),
			new floorTileType(BONES_CHAR,    gray,                  0,                      70, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (0), (TM_STAND_IN_TILE),                                                                            "a pile of rubble",     "rocky rubble covers the ground."),
			new floorTileType(BONES_CHAR,    mudBackColor,          refuseBackColor,       50, 20, DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (0), (TM_STAND_IN_TILE),                                                                            "a pile of filthy effects","primitive tools, carvings and trinkets are strewn about the area."),
			new floorTileType(BONES_CHAR,    white,                 0,                      70, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (0), (TM_STAND_IN_TILE),                                                                            "shattered glass",      "jagged chunks of glass from the broken dewar litter the ground."),
			new floorTileType(FLOOR_CHAR,    ectoplasmColor,        0,                      70, 0,  DF_PLAIN_FIRE,  0,          0,              0,              ECTOPLASM_LIGHT,(0), (TM_STAND_IN_TILE),                                                                            "ectoplasmic residue",  "a thick, glowing substance has congealed on the ground."),
			new floorTileType(ASH_CHAR,      fireForeColor,         0,                      70, 0,  DF_PLAIN_FIRE,  0,          DF_ASH,         300,            EMBER_LIGHT,    (0), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION),                                               "sputtering embers",    "sputtering embers cover the ground."),
			new floorTileType(WEB_CHAR,      white,                 0,                      19, 100,DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (T_ENTANGLES | T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT),"a spiderweb",       "thick, sticky spiderwebs fill the area."),
			new floorTileType(WEB_CHAR,      brown,                 0,                      19, 40, DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (T_ENTANGLES | T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT),"a net",             "a dense tangle of netting fills the area."),
			new floorTileType(FOLIAGE_CHAR,  foliageColor,          0,                      45, 15, DF_PLAIN_FIRE,  0,          DF_TRAMPLED_FOLIAGE, 0,         NO_LIGHT,       (T_OBSTRUCTS_VISION | T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_PROMOTES_ON_STEP), "dense foliage",   "dense foliage fills the area, thriving on what sunlight trickles in."),
			new floorTileType(FOLIAGE_CHAR,  deadFoliageColor,      0,                      45, 80, DF_PLAIN_FIRE,  0,          DF_SMALL_DEAD_GRASS, 0,         NO_LIGHT,       (T_OBSTRUCTS_VISION | T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_PROMOTES_ON_STEP), "dead foliage",    "the decaying husk of a fungal growth fills the area."),
			new floorTileType(TRAMPLED_FOLIAGE_CHAR,foliageColor,   0,                      60, 15, DF_PLAIN_FIRE,  0,          DF_FOLIAGE_REGROW, 100,         NO_LIGHT,       (T_IS_FLAMMABLE), (TM_VANISHES_UPON_PROMOTION),                                                     "trampled foliage",     "dense foliage fills the area, thriving on what sunlight trickles in."),
			new floorTileType(FOLIAGE_CHAR,  fungusForestLightColor,0,                      45, 15, DF_PLAIN_FIRE,  0,          DF_TRAMPLED_FUNGUS_FOREST, 0,   FUNGUS_FOREST_LIGHT,(T_OBSTRUCTS_VISION | T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_PROMOTES_ON_STEP),"a luminescent fungal forest", "luminescent fungal growth fills the area, groping upward from the rich soil."),
			new floorTileType(TRAMPLED_FOLIAGE_CHAR,fungusForestLightColor,0,               60, 15, DF_PLAIN_FIRE,  0,          DF_FUNGUS_FOREST_REGROW, 100,   FUNGUS_LIGHT,   (T_IS_FLAMMABLE), (TM_VANISHES_UPON_PROMOTION),                                                     "trampled fungal foliage", "luminescent fungal growth fills the area, groping upward from the rich soil."),
			new floorTileType(WALL_CHAR,     forceFieldColor,       forceFieldColor,       0,  0,  0,              0,          DF_FORCEFIELD_MELT, -200,       FORCEFIELD_LIGHT, (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_GAS | T_OBSTRUCTS_DIAGONAL_MOVEMENT), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_PROMOTES_ON_STEP),       "a green crystal",      "The translucent green crystal is melting away in front of your eyes."),
			new floorTileType(WALL_CHAR,     black,                 forceFieldColor,       0,  0,  0,              0,          0,              -10000,         FORCEFIELD_LIGHT, (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_GAS | T_OBSTRUCTS_DIAGONAL_MOVEMENT), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION),     "a dissolving crystal",     "The translucent green crystal is melting away in front of your eyes."),
			new floorTileType(CHASM_CHAR,    sacredGlyphColor,      0,                      57, 0,  0,              0,          0,              0,              SACRED_GLYPH_LIGHT, (T_SACRED), 0,                                                                                  "a sacred glyph",       "a sacred glyph adorns the floor, glowing with a powerful warding enchantment."),
			new floorTileType(CHAIN_TOP_LEFT,gray,                  0,                      20, 0,  0,              0,          0,              0,              NO_LIGHT,       0, 0,                                                                                               "an iron manacle",      "a thick iron manacle is anchored to the ceiling."),
			new floorTileType(CHAIN_BOTTOM_RIGHT, gray,             0,                      20, 0,  0,              0,          0,              0,              NO_LIGHT,       0, 0,                                                                                               "an iron manacle",      "a thick iron manacle is anchored to the floor."),
			new floorTileType(CHAIN_TOP_RIGHT, gray,                0,                      20, 0,  0,              0,          0,              0,              NO_LIGHT,       0, 0,                                                                                               "an iron manacle",      "a thick iron manacle is anchored to the ceiling."),
			new floorTileType(CHAIN_BOTTOM_LEFT, gray,              0,                      20, 0,  0,              0,          0,              0,              NO_LIGHT,       0, 0,                                                                                               "an iron manacle",      "a thick iron manacle is anchored to the floor."),
			new floorTileType(CHAIN_TOP,     gray,                  0,                      20, 0,  0,              0,          0,              0,              NO_LIGHT,       0, 0,                                                                                               "an iron manacle",      "a thick iron manacle is anchored to the wall."),
			new floorTileType(CHAIN_BOTTOM,  gray,                  0,                      20, 0,  0,              0,          0,              0,              NO_LIGHT,       0, 0,                                                                                               "an iron manacle",      "a thick iron manacle is anchored to the wall."),
			new floorTileType(CHAIN_LEFT,    gray,                  0,                      20, 0,  0,              0,          0,              0,              NO_LIGHT,       0, 0,                                                                                               "an iron manacle",      "a thick iron manacle is anchored to the wall."),
			new floorTileType(CHAIN_RIGHT,   gray,                  0,                      20, 0,  0,              0,          0,              0,              NO_LIGHT,       0, 0,                                                                                               "an iron manacle",      "a thick iron manacle is anchored to the wall."),
			new floorTileType(0,             0,                      0,                      1,  0,  0,              0,          0,              10000,          PORTAL_ACTIVATE_LIGHT,(0), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION),                                         "blinding light",       "blinding light streams out of the archway."),
			new floorTileType(0,             0,                      0,                      100,0,  0,              0,          0,              10000,          GLYPH_LIGHT_BRIGHT,(0), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION),                                            "a red glow",           "a red glow fills the area."),

			// fire tiles
			new floorTileType(FIRE_CHAR,     fireForeColor,         0,                      10, 0,  0,              0,          DF_EMBERS,      500,            FIRE_LIGHT,     (T_IS_FIRE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT),                "billowing flames",     "flames billow upward."),
			new floorTileType(FIRE_CHAR,     fireForeColor,         0,                      10, 0,  0,              0,          0,              2500,           BRIMSTONE_FIRE_LIGHT,(T_IS_FIRE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT),           "sulfurous flames",     "sulfurous flames leap from the unstable bed of brimstone."),
			new floorTileType(FIRE_CHAR,     fireForeColor,         0,                      10, 0,  0,              0,          DF_OBSIDIAN,    5000,           FIRE_LIGHT,     (T_IS_FIRE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT),                "clouds of infernal flame", "billowing infernal flames eat at the floor."),
			new floorTileType(FIRE_CHAR,     fireForeColor,         0,                      10, 0,  0,              0,          0,              8000,           FIRE_LIGHT,     (T_IS_FIRE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT),                "a cloud of burning gas", "burning gas fills the air with flame."),
			new floorTileType(FIRE_CHAR,     yellow,                0,                      10, 0,  0,              0,          0,              10000,          EXPLOSION_LIGHT,(T_IS_FIRE | T_CAUSES_EXPLOSIVE_DAMAGE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT), "a violent explosion", "the force of the explosion slams into you."),
			new floorTileType(FIRE_CHAR,     white,                 0,                      10, 0,  0,              0,          0,              10000,          INCENDIARY_DART_LIGHT ,(T_IS_FIRE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT),         "a flash of fire",      "flames burst out of the incendiary dart."),
			new floorTileType(FIRE_CHAR,     white,                 0,                      10, 0,  0,              0,          DF_EMBERS,      3000,           FIRE_LIGHT,     (T_IS_FIRE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT),                "crackling flames",     "crackling flames rise from the blackened item."),
			new floorTileType(FIRE_CHAR,     white,                 0,                      10, 0,  0,              0,          DF_EMBERS,      3000,           FIRE_LIGHT,     (T_IS_FIRE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT),                "greasy flames",        "greasy flames rise from the corpse."),

			// gas layer
			new floorTileType(   ' ',        0,                      poisonGasColor,        35, 100,DF_GAS_FIRE,    0,          0,              0,              NO_LIGHT,       (T_IS_FLAMMABLE | T_CAUSES_DAMAGE), (TM_STAND_IN_TILE | TM_GAS_DISSIPATES),                         "a cloud of caustic gas", "you can feel the purple gas eating at your flesh."),
			new floorTileType(   ' ',        0,                      confusionGasColor,     35, 100,DF_GAS_FIRE,    0,          0,              0,              CONFUSION_GAS_LIGHT,(T_IS_FLAMMABLE | T_CAUSES_CONFUSION), (TM_STAND_IN_TILE | TM_GAS_DISSIPATES_QUICKLY),          "a cloud of confusion gas", "the rainbow-colored gas tickles your brain."),
			new floorTileType(   ' ',        0,                      vomitColor,            35, 100,DF_GAS_FIRE,    0,          0,              0,              NO_LIGHT,       (T_IS_FLAMMABLE | T_CAUSES_NAUSEA), (TM_STAND_IN_TILE | TM_GAS_DISSIPATES_QUICKLY),                 "a cloud of putrescence", "the stench of rotting flesh is overpowering."),
			new floorTileType(   ' ',        0,                      vomitColor,            35, 0,  DF_GAS_FIRE,    0,          0,              0,              NO_LIGHT,       (T_CAUSES_NAUSEA), (TM_STAND_IN_TILE | TM_GAS_DISSIPATES_QUICKLY),                                  "a cloud of putrid smoke", "you retch violently at the smell of the greasy smoke."),
			new floorTileType(   ' ',        0,                      pink,                  35, 100,DF_GAS_FIRE,    0,          0,              0,              NO_LIGHT,       (T_IS_FLAMMABLE | T_CAUSES_PARALYSIS), (TM_STAND_IN_TILE | TM_GAS_DISSIPATES_QUICKLY),              "a cloud of paralytic gas", "the pale gas causes your muscles to stiffen."),
			new floorTileType(   ' ',        0,                      methaneColor,          35, 100,DF_GAS_FIRE,    0,          DF_EXPLOSION_FIRE, 0,           NO_LIGHT,       (T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_EXPLOSIVE_PROMOTE),                                        "a cloud of explosive gas", "the smell of explosive swamp gas fills the air."),
			new floorTileType(   ' ',        0,                      white,                 35, 0,  DF_GAS_FIRE,    0,          0,              0,              NO_LIGHT,       (T_CAUSES_DAMAGE), (TM_STAND_IN_TILE | TM_GAS_DISSIPATES_QUICKLY),                                  "a cloud of scalding steam", "scalding steam fills the air!"),
			new floorTileType(   ' ',        0,                      0,                      35, 0,  DF_GAS_FIRE,    0,          0,              0,              DARKNESS_CLOUD_LIGHT,   (0), (TM_STAND_IN_TILE),                                                                    "a cloud of supernatural darkness", "everything is obscured by an aura of supernatural darkness."),
			new floorTileType(   ' ',        0,                      darkRed,               35, 0,  DF_GAS_FIRE,    0,          0,              0,              NO_LIGHT,       (T_CAUSES_HEALING), (TM_STAND_IN_TILE | TM_GAS_DISSIPATES_QUICKLY),                                 "a cloud of healing spores", "bloodwort spores, renowned for their healing properties, fill the air."),

			// bloodwort pods
			new floorTileType(FOLIAGE_CHAR,  bloodflowerForeColor,  bloodflowerBackColor,  10, 20, DF_PLAIN_FIRE,  0,          DF_BLOODFLOWER_PODS_GROW, 100,  NO_LIGHT,       (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_ITEMS | T_IS_FLAMMABLE), (TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT), "a bloodwort stalk", "this spindly plant grows seed pods famous for their healing properties."),
			new floorTileType(GOLD_CHAR,     bloodflowerPodForeColor, 0,                    11, 20, DF_BLOODFLOWER_POD_BURST,0, DF_BLOODFLOWER_POD_BURST, 0,    NO_LIGHT,       (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_ITEMS | T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_PROMOTES_ON_PLAYER_ENTRY | TM_VISUALLY_DISTINCT | TM_INVERT_WHEN_HIGHLIGHTED), "a bloodwort pod", "the bloodwort seed pod bursts, releasing a cloud of healing spores."),

			// shrine accoutrements
			new floorTileType(BRIDGE_CHAR,   black,                 bedrollBackColor,      57, 50, DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (T_IS_FLAMMABLE), (TM_VANISHES_UPON_PROMOTION),                                                     "an abandoned bedroll", "a bedroll lies in the corner, disintegrating with age."),

			// algae
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_PLAIN_FIRE,  0,          DF_ALGAE_1,     100,            NO_LIGHT,       0, 0,                                                                                               "the ground",           ""),
			new floorTileType(LIQUID_CHAR,   deepWaterForeColor,    deepWaterBackColor,    40, 100,DF_STEAM_ACCUMULATION,  0,  DF_ALGAE_1,     500,            LUMINESCENT_ALGAE_BLUE_LIGHT,(T_IS_FLAMMABLE | T_IS_DEEP_WATER), (TM_STAND_IN_TILE | TM_EXTINGUISHES_FIRE | TM_ALLOWS_SUBMERGING),  "luminescent waters",   "blooming algae fills the waters with a swirling luminescence."),
			new floorTileType(LIQUID_CHAR,   deepWaterForeColor,    deepWaterBackColor,    39, 100,DF_STEAM_ACCUMULATION,  0,  DF_ALGAE_REVERT,300,            LUMINESCENT_ALGAE_GREEN_LIGHT,(T_IS_FLAMMABLE | T_IS_DEEP_WATER), (TM_STAND_IN_TILE | TM_EXTINGUISHES_FIRE | TM_ALLOWS_SUBMERGING), "luminescent waters",   "blooming algae fills the waters with a swirling luminescence."),

			// ancient spirit terrain
			new floorTileType(VINE_CHAR,     lichenColor,           0,                      19, 100,DF_PLAIN_FIRE,  0,          DF_ANCIENT_SPIRIT_GRASS,1000,   NO_LIGHT,       (T_ENTANGLES | T_CAUSES_DAMAGE | T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_VISUALLY_DISTINCT | TM_PROMOTES_ON_PLAYER_ENTRY),"thorned vines",       "thorned vines make a rustling noise as they quiver restlessly."),
			new floorTileType(GRASS_CHAR,    grassColor,            0,                      60, 15, DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (T_IS_FLAMMABLE), (TM_STAND_IN_TILE),                                                               "a tuft of grass",      "tufts of lush grass have improbably pushed upward through the stone ground."),

			// Yendor amulet floor tile
			new floorTileType(FLOOR_CHAR,    floorForeColor,        floorBackColor,        95, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       0, (TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED | TM_PROMOTES_ON_ITEM_PICKUP),                         "the ground",           ""),

			// commutation device
			new floorTileType(ALTAR_CHAR,    altarForeColor,        greenAltarBackColor,   17, 0,  0,              0,          DF_ALTAR_COMMUTE,0,             NO_LIGHT,       (T_OBSTRUCTS_SURFACE_EFFECTS), (TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED | TM_SWAP_ENCHANTS_ACTIVATION | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),    "a commutation altar",  "crude diagrams on this altar and its twin invite you to place items upon them."),
			new floorTileType(ALTAR_CHAR,    black,                 greenAltarBackColor,   17, 0,  0,              0,          0,              0,              NO_LIGHT,       (T_OBSTRUCTS_SURFACE_EFFECTS), (TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),                         "a scorched altar",     "scorch marks cover the surface of the altar, but it is cold to the touch."),
			new floorTileType('+',           veryDarkGray,          0,                      45, 0,  DF_PLAIN_FIRE,  0,          DF_INERT_PIPE,  0,              CONFUSION_GAS_LIGHT, (0), (TM_IS_WIRED | TM_VANISHES_UPON_PROMOTION),                                               "glowing glass pipes",  "glass pipes are set into the floor and emit a soft glow of shifting color."),
			new floorTileType('+',           black,                 0,                      45, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (0), (0),                                                                                           "charred glass pipes",  "the inside of the glass pipes are charred."),

			// resurrection altar
			new floorTileType(ALTAR_CHAR,    altarForeColor,        goldAltarBackColor,    17, 0,  0,              0,          DF_ALTAR_RESURRECT,0,           CANDLE_LIGHT,   (T_OBSTRUCTS_SURFACE_EFFECTS), (TM_IS_WIRED | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),           "a resurrection altar", "the souls of the dead surround you. A deceased ally might be called back."),
			new floorTileType(ALTAR_CHAR,    black,                 goldAltarBackColor,    16, 0,  0,              0,          0,              0,              NO_LIGHT,       (T_OBSTRUCTS_SURFACE_EFFECTS), (TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT),                         "a scorched altar",     "scorch marks cover the surface of the altar, but it is cold to the touch."),
			new floorTileType(0,             0,                      0,                      95, 0,  0,              0,          0,              0,              NO_LIGHT,       (0), (TM_IS_WIRED | TM_PROMOTES_ON_PLAYER_ENTRY),                                                   "the ground",           ""),

			// doorway statues
			new floorTileType(STATUE_CHAR,   wallBackColor,         statueBackColor,       0,  0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_ITEMS | T_OBSTRUCTS_GAS | T_OBSTRUCTS_SURFACE_EFFECTS), (TM_STAND_IN_TILE | TM_CONNECTS_LEVEL),  "a marble statue",  "The cold marble statue has weathered the years with grace."),
			new floorTileType(STATUE_CHAR,   wallBackColor,         statueBackColor,       0,  0,  DF_PLAIN_FIRE,  0,          DF_CRACKING_STATUE,0,           NO_LIGHT,       (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_ITEMS | T_OBSTRUCTS_GAS | T_OBSTRUCTS_SURFACE_EFFECTS), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED | TM_CONNECTS_LEVEL),"a marble statue", "The cold marble statue has weathered the years with grace."),

			// extensible stone bridge    
			new floorTileType(CHASM_CHAR,    chasmForeColor,        black,                 40, 0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (T_AUTO_DESCENT), (TM_STAND_IN_TILE),                                                               "a chasm",              "you plunge downward into the chasm!"),
			new floorTileType(FLOOR_CHAR,    white,                 chasmEdgeBackColor,    40, 0,  DF_PLAIN_FIRE,  0,          DF_BRIDGE_ACTIVATE,6000,        NO_LIGHT,       (0), (TM_VANISHES_UPON_PROMOTION),                                                                  "a stone bridge",       "the narrow stone bridge is extending across the chasm."),
			new floorTileType(FLOOR_CHAR,    white,                 chasmEdgeBackColor,    80, 0,  DF_PLAIN_FIRE,  0,          DF_BRIDGE_ACTIVATE_ANNOUNCE,0,  NO_LIGHT,       (0), (TM_IS_WIRED),                                                                                 "the brink of a chasm", "chilly winds blow upward from the stygian depths."),

			// rat trap
			new floorTileType(WALL_CHAR,     wallForeColor,         wallBackColor,         0,  0,  DF_PLAIN_FIRE,  0,          DF_WALL_CRACK,  0,              NO_LIGHT,       (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED),            "a stone wall",         "The rough stone wall is firm and unyielding."),
			new floorTileType(WALL_CHAR,     wallForeColor,         wallBackColor,         0,  0,  DF_PLAIN_FIRE,  0,          DF_WALL_SHATTER,500,            NO_LIGHT,       (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_LIST_IN_SIDEBAR),     "a cracking wall",      "Cracks are running ominously across the base of this rough stone wall."),

			// electric crystals
			new floorTileType(ELECTRIC_CRYSTAL_CHAR, wallCrystalColor, graniteBackColor,   0,  0,  DF_PLAIN_FIRE,  0,          DF_ELECTRIC_CRYSTAL_ON, 0,      NO_LIGHT,       (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_ITEMS | T_OBSTRUCTS_GAS | T_OBSTRUCTS_SURFACE_EFFECTS), (TM_STAND_IN_TILE | TM_PROMOTES_ON_ELECTRICITY | TM_IS_CIRCUIT_BREAKER | TM_IS_WIRED | TM_LIST_IN_SIDEBAR), "a darkened crystal globe", "A slight electric shock startles you when you touch the inert crystal globe."),
			new floorTileType(ELECTRIC_CRYSTAL_CHAR, white,         wallCrystalColor,      0,  0,  DF_PLAIN_FIRE,  0,          0,              0,              CRYSTAL_WALL_LIGHT,(T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_ITEMS | T_OBSTRUCTS_GAS | T_OBSTRUCTS_SURFACE_EFFECTS), (TM_STAND_IN_TILE | TM_LIST_IN_SIDEBAR), "a shining crystal globe", "Crackling light streams out of the crystal globe."),
			new floorTileType(LEVER_CHAR,    wallForeColor,         wallBackColor,         0,  0,  DF_PLAIN_FIRE,  0,          DF_TURRET_LEVER,0,              NO_LIGHT,       (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_PROMOTES_ON_PLAYER_ENTRY | TM_LIST_IN_SIDEBAR | TM_VISUALLY_DISTINCT | TM_INVERT_WHEN_HIGHLIGHTED),"a lever", "The lever moves."),

			// worm tunnels
			new floorTileType(0,             0,                      0,                      100,0,  0,              0,          DF_WORM_TUNNEL_MARKER_ACTIVE,0, NO_LIGHT,       (0), (TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED),                                                    "",                     ""),
			new floorTileType(0,             0,                      0,                      100,0,  0,              0,          DF_GRANITE_CRUMBLES,-2000,      NO_LIGHT,       (0), (TM_VANISHES_UPON_PROMOTION),                                                                  "a rough granite wall", "The granite is split open with splinters of rock jutting out at odd angles."),
			new floorTileType(WALL_CHAR,     wallForeColor,         wallBackColor,         0,  0,  DF_PLAIN_FIRE,  0,          DF_WALL_SHATTER,0,              NO_LIGHT,       (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE | TM_VANISHES_UPON_PROMOTION | TM_IS_WIRED | TM_CONNECTS_LEVEL),"a stone wall", "The rough stone wall is firm and unyielding."),

			// zombie crypt
			new floorTileType(FIRE_CHAR,     fireForeColor,         statueBackColor,       0,  0,  DF_PLAIN_FIRE,  0,          0,              0,              BURNING_CREATURE_LIGHT, (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_ITEMS | T_IS_FIRE), (TM_STAND_IN_TILE | TM_LIST_IN_SIDEBAR),"a ceremonial brazier",      "The ancient brazier smolders with a deep crimson flame."),

			// goblin warren
			new floorTileType(FLOOR_CHAR,    mudBackColor,          refuseBackColor,       85, 0,  DF_STENCH_SMOLDER,0,        0,              0,              NO_LIGHT,       (T_IS_FLAMMABLE), (TM_VANISHES_UPON_PROMOTION),                                                     "the mud floor",        "Rotting animal matter has been ground into the mud floor; the stench is awful."),
			new floorTileType(WALL_CHAR,     mudWallForeColor,      mudWallBackColor,      0,  0,  DF_PLAIN_FIRE,  0,          0,              0,              NO_LIGHT,       (T_OBSTRUCTS_EVERYTHING), (TM_STAND_IN_TILE),                                                       "a mud-covered wall",   "A malodorous layer of clay and fecal matter coats the wall."),
			new floorTileType(OMEGA_CHAR,    mudWallForeColor,      refuseBackColor,       25, 50, DF_EMBERS,      0,          0,              0,              NO_LIGHT,       (T_OBSTRUCTS_VISION | T_OBSTRUCTS_GAS | T_IS_FLAMMABLE), (TM_STAND_IN_TILE | TM_VISUALLY_DISTINCT), "hanging animal skins", "you push through the animal skins that hang across the threshold."),
		};

		public dungeonProfile[] dungeonProfileCatalog  = {
			// Room frequencies:
			//      0. Cross room
			//      1. Small symmetrical cross room
			//      2. Small room
			//      3. Circular room
			//      4. Chunky room
			//      5. Cave
			//      6. Cavern (the kind that fills a level)
			//      7. Entrance room (the big upside-down T room at the start of depth 1)

			// Room frequencies
			// 0    1   2   3   4   5   6   7   Corridor chance
			new dungeonProfile( new short[]{2,    1,  1,  1,  7,  1,  0,  0}, 10),    // Basic dungeon generation (further adjusted by depth)
			new dungeonProfile( new short[]{10,   0,  0,  3,  7,  10, 10, 0}, 0),     // First room for basic dungeon generation (further adjusted by depth)

			new dungeonProfile( new short[]{0,    0,  1,  0,  0,  0,  0,  0}, 0),     // Goblin warrens
			new dungeonProfile( new short[]{0,    5,  0,  1,  0,  0,  0,  0}, 0),     // Sentinel sanctuaries
		};

		public static short[,] nbDirs  =  {{0,-1}, {0,1}, {-1,0}, {1,0}, {-1,-1}, {-1,1}, {1,-1}, {1,1}};
		public static short[,] cDirs   =  {{0, 1}, {1, 1}, {1, 0}, {1, -1}, {0, -1}, {-1, -1}, {-1, 0}, {-1, 1}};

	} // end Global class
}

