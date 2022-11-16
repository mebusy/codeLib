using System;

namespace rogueSharp
{
	public enum monsterTypes {
		MK_YOU,
		MK_RAT,
		MK_KOBOLD,
		MK_JACKAL,
		MK_EEL,
		MK_MONKEY,
		MK_BLOAT,
		MK_PIT_BLOAT,
		MK_GOBLIN,
		MK_GOBLIN_CONJURER,
		MK_GOBLIN_MYSTIC,
		MK_GOBLIN_TOTEM,
		MK_PINK_JELLY,
		MK_TOAD,
		MK_VAMPIRE_BAT,
		MK_ARROW_TURRET,
		MK_ACID_MOUND,
		MK_CENTIPEDE,
		MK_OGRE,
		MK_BOG_MONSTER,
		MK_OGRE_TOTEM,
		MK_SPIDER,
		MK_SPARK_TURRET,
		MK_WILL_O_THE_WISP,
		MK_WRAITH,
		MK_ZOMBIE,
		MK_TROLL,
		MK_OGRE_SHAMAN,
		MK_NAGA,
		MK_SALAMANDER,
		MK_EXPLOSIVE_BLOAT,
		MK_DAR_BLADEMASTER,
		MK_DAR_PRIESTESS,
		MK_DAR_BATTLEMAGE,
		MK_ACID_JELLY,
		MK_CENTAUR,
		MK_UNDERWORM,
		MK_SENTINEL,
		MK_ACID_TURRET,
		MK_DART_TURRET,
		MK_KRAKEN,
		MK_LICH,
		MK_PHYLACTERY,
		MK_PIXIE,
		MK_PHANTOM,
		MK_FLAME_TURRET,
		MK_IMP,
		MK_FURY,
		MK_REVENANT,
		MK_TENTACLE_HORROR,
		MK_GOLEM,
		MK_DRAGON,

		MK_GOBLIN_CHIEFTAN,
		MK_BLACK_JELLY,
		MK_VAMPIRE,
		MK_FLAMEDANCER,

		MK_SPECTRAL_BLADE,
		MK_SPECTRAL_IMAGE,
		MK_GUARDIAN,
		MK_WINGED_GUARDIAN,
		MK_CHARM_GUARDIAN,
		MK_WARDEN_OF_YENDOR,
		MK_ELDRITCH_TOTEM,
		MK_MIRRORED_TOTEM,

		MK_UNICORN,
		MK_IFRIT,
		MK_PHOENIX,
		MK_PHOENIX_EGG,
		MK_ANCIENT_SPIRIT,

		NUMBER_MONSTER_KINDS
	};


	public enum monsterBehaviorFlags {
		MONST_INVISIBLE					= (1<<(0)),	// monster is invisible
		MONST_INANIMATE					= (1<<(1)),	// monster has abbreviated stat bar display and is immune to many things
		MONST_IMMOBILE					= (1<<(2)),	// monster won't move or perform melee attacks
		MONST_CARRY_ITEM_100			= (1<<(3)),	// monster carries an item 100% of the time
		MONST_CARRY_ITEM_25				= (1<<(4)),	// monster carries an item 25% of the time
		MONST_ALWAYS_HUNTING			= (1<<(5)),	// monster is never asleep or in wandering mode
		MONST_FLEES_NEAR_DEATH			= (1<<(6)),	// monster flees when under 25% health and re-engages when over 75%
		MONST_ATTACKABLE_THRU_WALLS		= (1<<(7)),	// can be attacked when embedded in a wall
		MONST_DEFEND_DEGRADE_WEAPON		= (1<<(8)),	// hitting the monster damages the weapon
		MONST_IMMUNE_TO_WEAPONS			= (1<<(9)),	// weapons ineffective
		MONST_FLIES						= (1<<(10)),	// permanent levitation
		MONST_FLITS						= (1<<(11)),	// moves randomly a third of the time
		MONST_IMMUNE_TO_FIRE			= (1<<(12)),	// won't burn, won't die in lava
		MONST_CAST_SPELLS_SLOWLY		= (1<<(13)),	// takes twice the attack duration to cast a spell
		MONST_IMMUNE_TO_WEBS			= (1<<(14)),	// monster passes freely through webs
		MONST_REFLECT_4					= (1<<(15)),	// monster reflects projectiles as though wearing +4 armor of reflection
		MONST_NEVER_SLEEPS				= (1<<(16)),	// monster is always awake
		MONST_FIERY						= (1<<(17)),	// monster carries an aura of flame (but no automatic fire light)
		MONST_INVULNERABLE              = (1<<(18)),	// monster is immune to absolutely everything
		MONST_IMMUNE_TO_WATER			= (1<<(19)),	// monster moves at full speed in deep water and (if player) doesn't drop items
		MONST_RESTRICTED_TO_LIQUID		= (1<<(20)),	// monster can move only on tiles that allow submersion
		MONST_SUBMERGES					= (1<<(21)),	// monster can submerge in appropriate terrain
		MONST_MAINTAINS_DISTANCE		= (1<<(22)),	// monster tries to keep a distance of 3 tiles between it and player
		MONST_WILL_NOT_USE_STAIRS		= (1<<(23)),	// monster won't chase the player between levels
		MONST_DIES_IF_NEGATED			= (1<<(24)),	// monster will die if exposed to negation magic
		MONST_MALE						= (1<<(25)),	// monster is male (or 50% likely to be male if also has MONST_FEMALE)
		MONST_FEMALE					= (1<<(26)),	// monster is female (or 50% likely to be female if also has MONST_MALE)
		MONST_NOT_LISTED_IN_SIDEBAR     = (1<<(27)),   // monster doesn't show up in the sidebar
		MONST_GETS_TURN_ON_ACTIVATION   = (1<<(28)),   // monster never gets a turn, except when its machine is activated
		MONST_ALWAYS_USE_ABILITY        = (1<<(29)),   // monster will never fail to use special ability if eligible (no random factor)
		MONST_NO_POLYMORPH              = (1<<(30)),   // monster cannot result from a polymorph spell (liches, phoenixes and Warden of Yendor)

		NEGATABLE_TRAITS				= (MONST_INVISIBLE | MONST_DEFEND_DEGRADE_WEAPON | MONST_IMMUNE_TO_WEAPONS | MONST_FLIES
			| MONST_FLITS | MONST_IMMUNE_TO_FIRE | MONST_REFLECT_4 | MONST_FIERY | MONST_MAINTAINS_DISTANCE),
		MONST_TURRET					= (MONST_IMMUNE_TO_WEBS | MONST_NEVER_SLEEPS | MONST_IMMOBILE | MONST_INANIMATE |
			MONST_ATTACKABLE_THRU_WALLS | MONST_WILL_NOT_USE_STAIRS),
		LEARNABLE_BEHAVIORS				= (MONST_INVISIBLE | MONST_FLIES | MONST_IMMUNE_TO_FIRE | MONST_REFLECT_4),
		MONST_NEVER_VORPAL_ENEMY		= (MONST_INANIMATE | MONST_INVULNERABLE | MONST_IMMOBILE | MONST_RESTRICTED_TO_LIQUID | MONST_GETS_TURN_ON_ACTIVATION | MONST_MAINTAINS_DISTANCE),
		MONST_NEVER_MUTATED             = (MONST_INVISIBLE | MONST_INANIMATE | MONST_IMMOBILE | MONST_INVULNERABLE),
	};

	public enum monsterAbilityFlags {
		MA_HIT_HALLUCINATE				= (1<<(0)),	// monster can hit to cause hallucinations
		MA_HIT_STEAL_FLEE				= (1<<(1)),	// monster can steal an item and then run away
		MA_ENTER_SUMMONS				= (1<<(2)),	// monster will "become" its summoned leader, reappearing when that leader is defeated
		MA_HIT_DEGRADE_ARMOR			= (1<<(3)),	// monster damages armor
		MA_CAST_SUMMON					= (1<<(4)),	// requires that there be one or more summon hordes with this monster type as the leader
		MA_SEIZES						= (1<<(5)),	// monster seizes enemies before attacking
		MA_POISONS						= (1<<(6)),	// monster's damage is dealt in the form of poison
		MA_DF_ON_DEATH					= (1<<(7)),	// monster spawns its DF when it dies
		MA_CLONE_SELF_ON_DEFEND			= (1<<(8)),	// monster splits in two when struck
		MA_KAMIKAZE						= (1<<(9)),	// monster dies instead of attacking
		MA_TRANSFERENCE					= (1<<(10)),	// monster recovers 40 or 90% of the damage that it inflicts as health
		MA_CAUSES_WEAKNESS				= (1<<(11)),	// monster attacks cause weakness status in target
		MA_ATTACKS_PENETRATE            = (1<<(12)),   // monster attacks all adjacent enemies, like an axe
		MA_ATTACKS_ALL_ADJACENT         = (1<<(13)),   // monster attacks penetrate one layer of enemies, like a spear
		MA_ATTACKS_EXTEND               = (1<<(14)),   // monster attacks from a distance in a cardinal direction, like a whip
		MA_AVOID_CORRIDORS              = (1<<(15)),   // monster will avoid corridors when hunting

		SPECIAL_HIT						= (MA_HIT_HALLUCINATE | MA_HIT_STEAL_FLEE | MA_HIT_DEGRADE_ARMOR | MA_POISONS | MA_TRANSFERENCE | MA_CAUSES_WEAKNESS),
		LEARNABLE_ABILITIES				= (MA_TRANSFERENCE | MA_CAUSES_WEAKNESS),

		MA_NON_NEGATABLE_ABILITIES      = (MA_ATTACKS_PENETRATE | MA_ATTACKS_ALL_ADJACENT),
		MA_NEVER_VORPAL_ENEMY           = (MA_KAMIKAZE),
		MA_NEVER_MUTATED                = (MA_KAMIKAZE),
	};


	public enum monsterBookkeepingFlags {
		MB_WAS_VISIBLE				= (1<<(0)),	// monster was visible to player last turn
		MB_TELEPATHICALLY_REVEALED  = (1<<(1)),    // player can magically see monster and adjacent cells
		MB_PREPLACED                = (1<<(2)),	// monster dropped onto the level and requires post-processing
		MB_APPROACHING_UPSTAIRS		= (1<<(3)),	// following the player up the stairs
		MB_APPROACHING_DOWNSTAIRS	= (1<<(4)),	// following the player down the stairs
		MB_APPROACHING_PIT			= (1<<(5)),	// following the player down a pit
		MB_LEADER					= (1<<(6)),	// monster is the leader of a horde
		MB_FOLLOWER					= (1<<(7)),	// monster is a member of a horde
		MB_CAPTIVE					= (1<<(8)),	// monster is all tied up
		MB_SEIZED					= (1<<(9)),	// monster is being held
		MB_SEIZING					= (1<<(10)),	// monster is holding another creature immobile
		MB_SUBMERGED				= (1<<(11)),	// monster is currently submerged and hence invisible until it attacks
		MB_JUST_SUMMONED			= (1<<(12)),	// used to mark summons so they can be post-processed
		MB_WILL_FLASH				= (1<<(13)),	// this monster will flash as soon as control is returned to the player
		MB_BOUND_TO_LEADER			= (1<<(14)),	// monster will die if the leader dies or becomes separated from the leader
		MB_ABSORBING				= (1<<(15)),	// currently learning a skill by absorbing an enemy corpse
		MB_DOES_NOT_TRACK_LEADER	= (1<<(16)),	// monster will not follow its leader around
		MB_IS_FALLING				= (1<<(17)),	// monster is plunging downward at the end of the turn
		MB_IS_DYING					= (1<<(18)),	// monster has already been killed and is awaiting the end-of-turn graveyard sweep (or in purgatory)
		MB_GIVEN_UP_ON_SCENT		= (1<<(19)),	// to help the monster remember that the scent map is a dead end
		MB_IS_DORMANT				= (1<<(20)),	// lurking, waiting to burst out
		MB_HAS_SOUL                 = (1<<(21)),   // slaying the monster will count toward weapon auto-ID
		MB_ALREADY_SEEN             = (1<<(22)),   // seeing this monster won't interrupt exploration
	};
}

