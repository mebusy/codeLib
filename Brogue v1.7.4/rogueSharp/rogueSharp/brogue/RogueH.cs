using System.Collections;
using System.Collections.Generic;

namespace rogueSharp
{
	public enum dungeonLayers {
		NO_LAYER = -1,
		DUNGEON = 0,		// dungeon-level tile	(e.g. walls)
		LIQUID,				// liquid-level tile	(e.g. lava)
		GAS,				// gas-level tile		(e.g. fire, smoke, swamp gas)
		SURFACE,			// surface-level tile	(e.g. grass)
		NUMBER_TERRAIN_LAYERS
	};

	public enum statusEffects {
		STATUS_DONNING = 0,
		STATUS_WEAKENED,
		STATUS_TELEPATHIC,
		STATUS_HALLUCINATING,
		STATUS_LEVITATING,
		STATUS_SLOWED,
		STATUS_HASTED,
		STATUS_CONFUSED,
		STATUS_BURNING,
		STATUS_PARALYZED,
		STATUS_POISONED,
		STATUS_STUCK,
		STATUS_NAUSEOUS,
		STATUS_DISCORDANT,
		STATUS_IMMUNE_TO_FIRE,
		STATUS_EXPLOSION_IMMUNITY,
		STATUS_NUTRITION,
		STATUS_ENTERS_LEVEL_IN,
		STATUS_MAGICAL_FEAR,
		STATUS_ENTRANCED,
		STATUS_DARKNESS,
		STATUS_LIFESPAN_REMAINING,
		STATUS_SHIELDED,
		STATUS_INVISIBLE,
		STATUS_AGGRAVATING,
		NUMBER_OF_STATUS_EFFECTS,
	};

	public enum tileType {
		NOTHING = 0,
		GRANITE,
		FLOOR,
		FLOOR_FLOODABLE,
		CARPET,
		MARBLE_FLOOR,
		WALL,
		DOOR,
		OPEN_DOOR,
		SECRET_DOOR,
		LOCKED_DOOR,
		OPEN_IRON_DOOR_INERT,
		DOWN_STAIRS,
		UP_STAIRS,
		DUNGEON_EXIT,
		DUNGEON_PORTAL,
		TORCH_WALL, // wall lit with a torch
		CRYSTAL_WALL,
		PORTCULLIS_CLOSED,
		PORTCULLIS_DORMANT,
		WOODEN_BARRICADE,
		PILOT_LIGHT_DORMANT,
		PILOT_LIGHT,
		HAUNTED_TORCH_DORMANT,
		HAUNTED_TORCH_TRANSITIONING,
		HAUNTED_TORCH,
		WALL_LEVER_HIDDEN,
		WALL_LEVER,
		WALL_LEVER_PULLED,
		WALL_LEVER_HIDDEN_DORMANT,
		STATUE_INERT,
		STATUE_DORMANT,
		STATUE_CRACKING,
		STATUE_INSTACRACK,
		PORTAL,
		TURRET_DORMANT,
		WALL_MONSTER_DORMANT,
		DARK_FLOOR_DORMANT,
		DARK_FLOOR_DARKENING,
		DARK_FLOOR,
		MACHINE_TRIGGER_FLOOR,
		ALTAR_INERT,
		ALTAR_KEYHOLE,
		ALTAR_CAGE_OPEN,
		ALTAR_CAGE_CLOSED,
		ALTAR_SWITCH,
		ALTAR_SWITCH_RETRACTING,
		ALTAR_CAGE_RETRACTABLE,
		PEDESTAL,
		MONSTER_CAGE_OPEN,
		MONSTER_CAGE_CLOSED,
		COFFIN_CLOSED,
		COFFIN_OPEN,

		GAS_TRAP_POISON_HIDDEN,
		GAS_TRAP_POISON,
		TRAP_DOOR_HIDDEN,
		TRAP_DOOR,
		GAS_TRAP_PARALYSIS_HIDDEN,
		GAS_TRAP_PARALYSIS,
		MACHINE_PARALYSIS_VENT_HIDDEN,
		MACHINE_PARALYSIS_VENT,
		GAS_TRAP_CONFUSION_HIDDEN,
		GAS_TRAP_CONFUSION,
		FLAMETHROWER_HIDDEN,
		FLAMETHROWER,
		FLOOD_TRAP_HIDDEN,
		FLOOD_TRAP,
		NET_TRAP_HIDDEN,
		NET_TRAP,
		ALARM_TRAP_HIDDEN,
		ALARM_TRAP,
		MACHINE_POISON_GAS_VENT_HIDDEN,
		MACHINE_POISON_GAS_VENT_DORMANT,
		MACHINE_POISON_GAS_VENT,
		MACHINE_METHANE_VENT_HIDDEN,
		MACHINE_METHANE_VENT_DORMANT,
		MACHINE_METHANE_VENT,
		STEAM_VENT,
		MACHINE_PRESSURE_PLATE,
		MACHINE_PRESSURE_PLATE_USED,
		MACHINE_GLYPH,
		MACHINE_GLYPH_INACTIVE,
		DEWAR_CAUSTIC_GAS,
		DEWAR_CONFUSION_GAS,
		DEWAR_PARALYSIS_GAS,
		DEWAR_METHANE_GAS,

		DEEP_WATER,
		SHALLOW_WATER,
		MUD,
		CHASM,
		CHASM_EDGE,
		MACHINE_COLLAPSE_EDGE_DORMANT,
		MACHINE_COLLAPSE_EDGE_SPREADING,
		LAVA,
		LAVA_RETRACTABLE,
		LAVA_RETRACTING,
		SUNLIGHT_POOL,
		DARKNESS_PATCH,
		ACTIVE_BRIMSTONE,
		INERT_BRIMSTONE,
		OBSIDIAN,
		BRIDGE,
		BRIDGE_FALLING,
		BRIDGE_EDGE,
		STONE_BRIDGE,
		MACHINE_FLOOD_WATER_DORMANT,
		MACHINE_FLOOD_WATER_SPREADING,
		MACHINE_MUD_DORMANT,

		HOLE,
		HOLE_GLOW,
		HOLE_EDGE,
		FLOOD_WATER_DEEP,
		FLOOD_WATER_SHALLOW,
		GRASS,
		DEAD_GRASS,
		GRAY_FUNGUS,
		LUMINESCENT_FUNGUS,
		LICHEN,
		HAY,
		RED_BLOOD,
		GREEN_BLOOD,
		PURPLE_BLOOD,
		ACID_SPLATTER,
		VOMIT,
		URINE,
		UNICORN_POOP,
		WORM_BLOOD,
		ASH,
		BURNED_CARPET,
		PUDDLE,
		BONES,
		RUBBLE,
		JUNK,
		BROKEN_GLASS,
		ECTOPLASM,
		EMBERS,
		SPIDERWEB,
		NETTING,
		FOLIAGE,
		DEAD_FOLIAGE,
		TRAMPLED_FOLIAGE,
		FUNGUS_FOREST,
		TRAMPLED_FUNGUS_FOREST,
		FORCEFIELD,
		FORCEFIELD_MELT,
		SACRED_GLYPH,
		MANACLE_TL,
		MANACLE_BR,
		MANACLE_TR,
		MANACLE_BL,
		MANACLE_T,
		MANACLE_B,
		MANACLE_L,
		MANACLE_R,
		PORTAL_LIGHT,
		GUARDIAN_GLOW,

		PLAIN_FIRE,
		BRIMSTONE_FIRE,
		FLAMEDANCER_FIRE,
		GAS_FIRE,
		GAS_EXPLOSION,
		DART_EXPLOSION,
		ITEM_FIRE,
		CREATURE_FIRE,

		POISON_GAS,
		CONFUSION_GAS,
		ROT_GAS,
		STENCH_SMOKE_GAS,
		PARALYSIS_GAS,
		METHANE_GAS,
		STEAM,
		DARKNESS_CLOUD,
		HEALING_CLOUD,

		BLOODFLOWER_STALK,
		BLOODFLOWER_POD,

		HAVEN_BEDROLL,

		DEEP_WATER_ALGAE_WELL,
		DEEP_WATER_ALGAE_1,
		DEEP_WATER_ALGAE_2,

		ANCIENT_SPIRIT_VINES,
		ANCIENT_SPIRIT_GRASS,

		AMULET_SWITCH,

		COMMUTATION_ALTAR,
		COMMUTATION_ALTAR_INERT,
		PIPE_GLOWING,
		PIPE_INERT,

		RESURRECTION_ALTAR,
		RESURRECTION_ALTAR_INERT,
		MACHINE_TRIGGER_FLOOR_REPEATING,

		STATUE_INERT_DOORWAY,
		STATUE_DORMANT_DOORWAY,

		CHASM_WITH_HIDDEN_BRIDGE,
		CHASM_WITH_HIDDEN_BRIDGE_ACTIVE,
		MACHINE_CHASM_EDGE,

		RAT_TRAP_WALL_DORMANT,
		RAT_TRAP_WALL_CRACKING,

		ELECTRIC_CRYSTAL_OFF,
		ELECTRIC_CRYSTAL_ON,
		TURRET_LEVER,

		WORM_TUNNEL_MARKER_DORMANT,
		WORM_TUNNEL_MARKER_ACTIVE,
		WORM_TUNNEL_OUTER_WALL,

		BRAZIER,

		MUD_FLOOR,
		MUD_WALL,
		MUD_DOORWAY,

		NUMBER_TILETYPES,
	};




	public enum creatureStates {
		MONSTER_SLEEPING,
		MONSTER_TRACKING_SCENT,
		MONSTER_WANDERING,
		MONSTER_FLEEING,
		MONSTER_ALLY,
	};

	public enum creatureModes {
		MODE_NORMAL,
		MODE_PERM_FLEEING
	};

	public enum dungeonFeatureTypes {
		DF_GRANITE_COLUMN = 1,
		DF_CRYSTAL_WALL,
		DF_LUMINESCENT_FUNGUS,
		DF_GRASS,
		DF_DEAD_GRASS,
		DF_BONES,
		DF_RUBBLE,
		DF_FOLIAGE,
		DF_FUNGUS_FOREST,
		DF_DEAD_FOLIAGE,

		DF_SUNLIGHT,
		DF_DARKNESS,

		DF_SHOW_DOOR,
		DF_SHOW_POISON_GAS_TRAP,
		DF_SHOW_PARALYSIS_GAS_TRAP,
		DF_SHOW_TRAPDOOR_HALO,
		DF_SHOW_TRAPDOOR,
		DF_SHOW_CONFUSION_GAS_TRAP,
		DF_SHOW_FLAMETHROWER_TRAP,
		DF_SHOW_FLOOD_TRAP,
		DF_SHOW_NET_TRAP,
		DF_SHOW_ALARM_TRAP,

		DF_RED_BLOOD,
		DF_GREEN_BLOOD,
		DF_PURPLE_BLOOD,
		DF_WORM_BLOOD,
		DF_ACID_BLOOD,
		DF_ASH_BLOOD,
		DF_EMBER_BLOOD,
		DF_ECTOPLASM_BLOOD,
		DF_RUBBLE_BLOOD,
		DF_ROT_GAS_BLOOD,

		DF_VOMIT,
		DF_BLOAT_DEATH,
		DF_BLOAT_EXPLOSION,
		DF_BLOOD_EXPLOSION,
		DF_FLAMEDANCER_CORONA,

		DF_MUTATION_EXPLOSION,
		DF_MUTATION_LICHEN,

		DF_REPEL_CREATURES,
		DF_ROT_GAS_PUFF,
		DF_STEAM_PUFF,
		DF_STEAM_ACCUMULATION,
		DF_METHANE_GAS_PUFF,
		DF_SALAMANDER_FLAME,
		DF_URINE,
		DF_UNICORN_POOP,
		DF_PUDDLE,
		DF_ASH,
		DF_ECTOPLASM_DROPLET,
		DF_FORCEFIELD,
		DF_FORCEFIELD_MELT,
		DF_SACRED_GLYPHS,
		DF_LICHEN_GROW,
		DF_TUNNELIZE,
		DF_SHATTERING_SPELL,

		// spiderwebs
		DF_WEB_SMALL,
		DF_WEB_LARGE,

		// ancient spirit
		DF_ANCIENT_SPIRIT_VINES,
		DF_ANCIENT_SPIRIT_GRASS,

		// foliage
		DF_TRAMPLED_FOLIAGE,
		DF_SMALL_DEAD_GRASS,
		DF_FOLIAGE_REGROW,
		DF_TRAMPLED_FUNGUS_FOREST,
		DF_FUNGUS_FOREST_REGROW,

		// brimstone
		DF_ACTIVE_BRIMSTONE,
		DF_INERT_BRIMSTONE,

		// bloodwort
		DF_BLOODFLOWER_PODS_GROW_INITIAL,
		DF_BLOODFLOWER_PODS_GROW,
		DF_BLOODFLOWER_POD_BURST,

		// dewars
		DF_DEWAR_CAUSTIC,
		DF_DEWAR_CONFUSION,
		DF_DEWAR_PARALYSIS,
		DF_DEWAR_METHANE,
		DF_DEWAR_GLASS,
		DF_CARPET_AREA,

		// algae
		DF_BUILD_ALGAE_WELL,
		DF_ALGAE_1,
		DF_ALGAE_2,
		DF_ALGAE_REVERT,

		DF_OPEN_DOOR,
		DF_CLOSED_DOOR,
		DF_OPEN_IRON_DOOR_INERT,
		DF_ITEM_CAGE_OPEN,
		DF_ITEM_CAGE_CLOSE,
		DF_ALTAR_INERT,
		DF_ALTAR_RETRACT,
		DF_PORTAL_ACTIVATE,
		DF_INACTIVE_GLYPH,
		DF_ACTIVE_GLYPH,
		DF_SILENT_GLYPH_GLOW,
		DF_GUARDIAN_STEP,
		DF_MIRROR_TOTEM_STEP,
		DF_GLYPH_CIRCLE,
		DF_REVEAL_LEVER,
		DF_PULL_LEVER,
		DF_CREATE_LEVER,

		DF_BRIDGE_FALL_PREP,
		DF_BRIDGE_FALL,

		DF_PLAIN_FIRE,
		DF_GAS_FIRE,
		DF_EXPLOSION_FIRE,
		DF_DART_EXPLOSION,
		DF_BRIMSTONE_FIRE,
		DF_BRIDGE_FIRE,
		DF_FLAMETHROWER,
		DF_EMBERS,
		DF_EMBERS_PATCH,
		DF_OBSIDIAN,
		DF_ITEM_FIRE,
		DF_CREATURE_FIRE,

		DF_FLOOD,
		DF_FLOOD_2,
		DF_FLOOD_DRAIN,
		DF_HOLE_2,
		DF_HOLE_DRAIN,

		DF_POISON_GAS_CLOUD,
		DF_CONFUSION_GAS_TRAP_CLOUD,
		DF_NET,
		DF_AGGRAVATE_TRAP,
		DF_METHANE_GAS_ARMAGEDDON,

		// potions
		DF_POISON_GAS_CLOUD_POTION,
		DF_PARALYSIS_GAS_CLOUD_POTION,
		DF_CONFUSION_GAS_CLOUD_POTION,
		DF_INCINERATION_POTION,
		DF_DARKNESS_POTION,
		DF_HOLE_POTION,
		DF_LICHEN_PLANTED,

		// other items
		DF_ARMOR_IMMOLATION,
		DF_STAFF_HOLE,
		DF_STAFF_HOLE_EDGE,

		// commutation altar
		DF_ALTAR_COMMUTE,
		DF_MAGIC_PIPING,
		DF_INERT_PIPE,

		// resurrection altar
		DF_ALTAR_RESURRECT,
		DF_MACHINE_FLOOR_TRIGGER_REPEATING,

		// vampire in coffin
		DF_COFFIN_BURSTS,
		DF_COFFIN_BURNS,
		DF_TRIGGER_AREA,

		// throwing tutorial -- button in chasm
		DF_CAGE_DISAPPEARS,
		DF_MEDIUM_HOLE,
		DF_MEDIUM_LAVA_POND,
		DF_MACHINE_PRESSURE_PLATE_USED,

		// rat trap
		DF_WALL_CRACK,

		// wooden barricade at entrance
		DF_WOODEN_BARRICADE_BURN,

		// wooden barricade around altar, dead grass all around
		DF_SURROUND_WOODEN_BARRICADE,

		// pools of water that, when triggered, slowly expand to fill the room
		DF_SPREADABLE_WATER,
		DF_SHALLOW_WATER,
		DF_WATER_SPREADS,
		DF_SPREADABLE_WATER_POOL,
		DF_SPREADABLE_DEEP_WATER_POOL,

		// when triggered, the ground gradually turns into chasm:
		DF_SPREADABLE_COLLAPSE,
		DF_COLLAPSE,
		DF_COLLAPSE_SPREADS,
		DF_ADD_MACHINE_COLLAPSE_EDGE_DORMANT,

		// when triggered, a bridge appears:
		DF_BRIDGE_ACTIVATE,
		DF_BRIDGE_ACTIVATE_ANNOUNCE,
		DF_BRIDGE_APPEARS,
		DF_ADD_DORMANT_CHASM_HALO,

		// when triggered, the lava retracts:
		DF_LAVA_RETRACTABLE,
		DF_RETRACTING_LAVA,
		DF_OBSIDIAN_WITH_STEAM,

		// when triggered, the door seals and caustic gas fills the room
		DF_SHOW_POISON_GAS_VENT,
		DF_POISON_GAS_VENT_OPEN,
		DF_ACTIVATE_PORTCULLIS,
		DF_OPEN_PORTCULLIS,
		DF_VENT_SPEW_POISON_GAS,

		// when triggered, pilot light ignites and explosive gas fills the room
		DF_SHOW_METHANE_VENT,
		DF_METHANE_VENT_OPEN,
		DF_VENT_SPEW_METHANE,
		DF_PILOT_LIGHT,

		// paralysis trap: trigger plate with gas vents nearby
		DF_DISCOVER_PARALYSIS_VENT,
		DF_PARALYSIS_VENT_SPEW,
		DF_REVEAL_PARALYSIS_VENT_SILENTLY,

		// thematic dungeon
		DF_AMBIENT_BLOOD,

		// statues crack for a few turns and then shatter, revealing the monster inside
		DF_CRACKING_STATUE,
		DF_STATUE_SHATTER,

		// a turret appears:
		DF_TURRET_EMERGE,

		// an elaborate worm catacomb opens up
		DF_WORM_TUNNEL_MARKER_DORMANT,
		DF_WORM_TUNNEL_MARKER_ACTIVE,
		DF_GRANITE_CRUMBLES,
		DF_WALL_OPEN,

		// the room gradually darkens
		DF_DARKENING_FLOOR,
		DF_DARK_FLOOR,
		DF_HAUNTED_TORCH_TRANSITION,
		DF_HAUNTED_TORCH,

		// bubbles rise from the mud and bog monsters spawn
		DF_MUD_DORMANT,
		DF_MUD_ACTIVATE,

		// crystals charge when hit by lightning
		DF_ELECTRIC_CRYSTAL_ON,
		DF_TURRET_LEVER,

		// idyll:
		DF_SHALLOW_WATER_POOL,
		DF_DEEP_WATER_POOL,

		// swamp:
		DF_SWAMP_WATER,
		DF_SWAMP,
		DF_SWAMP_MUD,

		// camp:
		DF_HAY,
		DF_JUNK,

		// remnants:
		DF_REMNANT,
		DF_REMNANT_ASH,

		// chasm catwalk:
		DF_CHASM_HOLE,
		DF_CATWALK_BRIDGE,

		// lake catwalk:
		DF_LAKE_CELL,
		DF_LAKE_HALO,

		// worm den:
		DF_WALL_SHATTER,

		// monster cages open:
		DF_MONSTER_CAGE_OPENS,

		// goblin warren:
		DF_STENCH_BURN,
		DF_STENCH_SMOLDER,

		NUMBER_DUNGEON_FEATURES,
	};

	public 
	enum lightType {
		NO_LIGHT,
		MINERS_LIGHT,
		BURNING_CREATURE_LIGHT,
		WISP_LIGHT,
		SALAMANDER_LIGHT,
		IMP_LIGHT,
		PIXIE_LIGHT,
		LICH_LIGHT,
		FLAMEDANCER_LIGHT,
		SENTINEL_LIGHT,
		UNICORN_LIGHT,
		IFRIT_LIGHT,
		PHOENIX_LIGHT,
		PHOENIX_EGG_LIGHT,
		YENDOR_LIGHT,
		SPECTRAL_BLADE_LIGHT,
		SPECTRAL_IMAGE_LIGHT,
		SPARK_TURRET_LIGHT,
		EXPLOSIVE_BLOAT_LIGHT,
		BOLT_LIGHT_SOURCE,
		TELEPATHY_LIGHT,

		SCROLL_PROTECTION_LIGHT,
		SCROLL_ENCHANTMENT_LIGHT,
		POTION_STRENGTH_LIGHT,
		EMPOWERMENT_LIGHT,
		GENERIC_FLASH_LIGHT,
		FALLEN_TORCH_FLASH_LIGHT,
		SUMMONING_FLASH_LIGHT,
		EXPLOSION_FLARE_LIGHT,
		QUIETUS_FLARE_LIGHT,
		SLAYING_FLARE_LIGHT,
		CHARGE_FLASH_LIGHT,

		TORCH_LIGHT,
		LAVA_LIGHT,
		SUN_LIGHT,
		DARKNESS_PATCH_LIGHT,
		FUNGUS_LIGHT,
		FUNGUS_FOREST_LIGHT,
		LUMINESCENT_ALGAE_BLUE_LIGHT,
		LUMINESCENT_ALGAE_GREEN_LIGHT,
		ECTOPLASM_LIGHT,
		UNICORN_POOP_LIGHT,
		EMBER_LIGHT,
		FIRE_LIGHT,
		BRIMSTONE_FIRE_LIGHT,
		EXPLOSION_LIGHT,
		INCENDIARY_DART_LIGHT,
		PORTAL_ACTIVATE_LIGHT,
		CONFUSION_GAS_LIGHT,
		DARKNESS_CLOUD_LIGHT,
		FORCEFIELD_LIGHT,
		CRYSTAL_WALL_LIGHT,
		CANDLE_LIGHT,
		HAUNTED_TORCH_LIGHT,
		GLYPH_LIGHT_DIM,
		GLYPH_LIGHT_BRIGHT,
		SACRED_GLYPH_LIGHT,
		DESCENT_LIGHT,
		NUMBER_LIGHT_KINDS
	};


	public enum DFFlags {
		DFF_EVACUATE_CREATURES_FIRST	= (1<<(0)),	// Creatures in the DF area get moved outside of it
		DFF_SUBSEQ_EVERYWHERE			= (1<<(1)),	// Subsequent DF spawns in every cell that this DF spawns in, instead of only the origin
		DFF_TREAT_AS_BLOCKING			= (1<<(2)),	// If filling the footprint of this DF with walls would disrupt level connectivity, then abort.
		DFF_PERMIT_BLOCKING				= (1<<(3)),	// Generate this DF without regard to level connectivity.
		DFF_ACTIVATE_DORMANT_MONSTER	= (1<<(4)),	// Dormant monsters on this tile will appear -- e.g. when a statue bursts to reveal a monster.
		DFF_CLEAR_OTHER_TERRAIN			= (1<<(5)),	// Erase other terrain in the footprint of this DF.
		DFF_BLOCKED_BY_OTHER_LAYERS		= (1<<(6)),	// Will not propagate into a cell if any layer in that cell has a superior priority.
		DFF_SUPERPRIORITY				= (1<<(7)),	// Will overwrite terrain of a superior priority.
		DFF_AGGRAVATES_MONSTERS         = (1<<(8)),    // Will act as though an aggravate monster scroll of effectRadius radius had been read at that point.
		DFF_RESURRECT_ALLY              = (1<<(9)),    // Will bring back to life your most recently deceased ally.
	}; 

	public enum RNGs {
		RNG_SUBSTANTIVE,
		RNG_COSMETIC,
		NUMBER_OF_RNGS,
	};

	public enum featTypes {
		FEAT_PURE_MAGE = 0,
		FEAT_PURE_WARRIOR,
		FEAT_PACIFIST,
		FEAT_ARCHIVIST,
		FEAT_COMPANION,
		FEAT_SPECIALIST,
		FEAT_JELLYMANCER,
		FEAT_INDOMITABLE,
		FEAT_MYSTIC,
		FEAT_DRAGONSLAYER,
		FEAT_PALADIN,

		FEAT_COUNT,
	};

	// Dungeon flags
	public enum tileFlags {
		DISCOVERED                  = (1<<(0)),
		VISIBLE                     = (1<<(1)),    // cell has sufficient light and is in field of view, ready to draw.
		HAS_PLAYER                  = (1<<(2)),
		HAS_MONSTER                 = (1<<(3)),
		HAS_DORMANT_MONSTER         = (1<<(4)),    // hidden monster on the square
		HAS_ITEM                    = (1<<(5)),
		IN_FIELD_OF_VIEW            = (1<<(6)),    // player has unobstructed line of sight whether or not there is enough light
		WAS_VISIBLE                 = (1<<(7)),
		HAS_DOWN_STAIRS             = (1<<(8)),
		HAS_UP_STAIRS               = (1<<(9)),
		IS_IN_SHADOW                = (1<<(10)),   // so that a player gains an automatic stealth bonus
		MAGIC_MAPPED                = (1<<(11)),
		ITEM_DETECTED               = (1<<(12)),
		CLAIRVOYANT_VISIBLE         = (1<<(13)),
		WAS_CLAIRVOYANT_VISIBLE     = (1<<(14)),
		CLAIRVOYANT_DARKENED        = (1<<(15)),   // magical blindness from a cursed ring of clairvoyance
		CAUGHT_FIRE_THIS_TURN       = (1<<(16)),   // so that fire does not spread asymmetrically
		PRESSURE_PLATE_DEPRESSED    = (1<<(17)),   // so that traps do not trigger repeatedly while you stand on them
		STABLE_MEMORY               = (1<<(18)),   // redraws will simply be pulled from the memory array, not recalculated
		KNOWN_TO_BE_TRAP_FREE       = (1<<(19)),   // keep track of where the player has stepped as he knows no traps are there
		IS_IN_PATH                  = (1<<(20)),   // the yellow trail leading to the cursor
		IN_LOOP                     = (1<<(21)),   // this cell is part of a terrain loop
		IS_CHOKEPOINT               = (1<<(22)),   // if this cell is blocked, part of the map will be rendered inaccessible
		IS_GATE_SITE                = (1<<(23)),   // consider placing a locked door here
		IS_IN_ROOM_MACHINE          = (1<<(24)),
		IS_IN_AREA_MACHINE          = (1<<(25)),
		IS_POWERED                  = (1<<(26)),   // has been activated by machine power this turn (can probably be eliminate if needed)
		IMPREGNABLE                 = (1<<(27)),   // no tunneling allowed!
		TERRAIN_COLORS_DANCING      = (1<<(28)),   // colors here will sparkle when the game is idle
		TELEPATHIC_VISIBLE          = (1<<(29)),   // potions of telepathy let you see through other creatures' eyes
		WAS_TELEPATHIC_VISIBLE      = (1<<(30)),   // potions of telepathy let you see through other creatures' eyes

		HAS_STAIRS                  = (HAS_UP_STAIRS | HAS_DOWN_STAIRS),
		IS_IN_MACHINE               = (IS_IN_ROOM_MACHINE | IS_IN_AREA_MACHINE),    // sacred ground; don't generate items here, or teleport randomly to it

		PERMANENT_TILE_FLAGS = (DISCOVERED | MAGIC_MAPPED | ITEM_DETECTED | HAS_ITEM | HAS_DORMANT_MONSTER
			| HAS_UP_STAIRS | HAS_DOWN_STAIRS | PRESSURE_PLATE_DEPRESSED
			| STABLE_MEMORY | KNOWN_TO_BE_TRAP_FREE | IN_LOOP
			| IS_CHOKEPOINT | IS_GATE_SITE | IS_IN_MACHINE | IMPREGNABLE),

		ANY_KIND_OF_VISIBLE         = (VISIBLE | CLAIRVOYANT_VISIBLE | TELEPATHIC_VISIBLE),
	};

	public enum dungeonProfileTypes {
		DP_BASIC,
		DP_BASIC_FIRST_ROOM,

		DP_GOBLIN_WARREN,
		DP_SENTINEL_SANCTUARY,

		NUMBER_DUNGEON_PROFILES,
	};

	public enum directions {
		NO_DIRECTION    = -1,
		// Cardinal directions; must be 0-3:
		UP				= 0,
		DOWN			= 1,
		LEFT			= 2,
		RIGHT			= 3,
		// Secondary directions; must be 4-7:
		UPLEFT			= 4,
		DOWNLEFT		= 5,
		UPRIGHT			= 6,
		DOWNRIGHT		= 7,

		DIRECTION_COUNT = 8,
	};

	public class RogueH  {
		public const int MESSAGE_LINES = 3;
		public const int MESSAGE_ARCHIVE_LINES = ROWS;

		// Size of the entire terminal window. These need to be hard-coded here and in Viewport.h
		public const int COLS = 100;
		public const int ROWS = (31 + MESSAGE_LINES);

		public const int DCOLS = (COLS - STAT_BAR_WIDTH - 1) ;		// n columns on the left for the sidebar;
																	// one column to separate the sidebar from the map.
		public const int DROWS = (ROWS - MESSAGE_LINES - 2) ;		// n lines at the top for messages;
																	// one line at the bottom for flavor text;
																	// another line at the bottom for the menu bar.

		public const int STAT_BAR_WIDTH = 20 ;	 // number of characters in the stats bar to the left of the map

		public const int NUMBER_MONSTER_KINDS = (int) monsterTypes.NUMBER_MONSTER_KINDS; 
		public const int NUMBER_TERRAIN_LAYERS = (int)dungeonLayers.NUMBER_TERRAIN_LAYERS ;

		public const int  KEY_ID_MAXIMUM = 20 ;
		public const int  MAX_WAYPOINT_COUNT = 40 ;

		public const int NUMBER_OF_STATUS_EFFECTS = (int)statusEffects.NUMBER_OF_STATUS_EFFECTS ;

		public const int NUMBER_DUNGEON_FEATURES = (int)dungeonFeatureTypes.NUMBER_DUNGEON_FEATURES; 

		public const int AMULET_LEVEL=			26;			// how deep before the amulet appears
		public const int DEEPEST_LEVEL=           40;          // how deep the universe goes

		// flavors

		public const int NUMBER_ITEM_COLORS = 21;
		public const int NUMBER_TITLE_PHONEMES		=21;
		public const int NUMBER_ITEM_WOODS			=21;
		public const int NUMBER_POTION_DESCRIPTIONS	=18;
		public const int NUMBER_ITEM_METALS			=12;
		public const int NUMBER_ITEM_GEMS			=18;

		public const int MAX_ITEMS_IN_MONSTER_ITEMS_HOPPER   =100 ;

		public const int STOMACH_SIZE			=			2150;

		public const int TURNS_FOR_FULL_REGEN = 300;

		public const double FLOAT_FUDGE = 0.00001;

		// color escapes
		public const int  COLOR_ESCAPE			=25;
		public const int  COLOR_VALUE_INTERCEPT	=25;

		public const int  NUMBER_DYNAMIC_COLORS	=6;

		public const int  ROOM_TYPE_COUNT  = 8 ;
		public const int DIRECTION_COUNT = (int)directions.DIRECTION_COUNT;

		public const int PDS_FORBIDDEN   =-1;
		public const int PDS_OBSTRUCTION =-2;
	}
}

