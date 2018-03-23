using System;

namespace rogueSharp
{
	public class Items:Singleton<Items>
	{
		public const double DEFENSE_FACTOR = 0.987;		// Each point of armor multiplies enemy attackers' accuracy by this value.
		// (displayed armor value is 10% of the real value)
		public const double  WEAPON_ENCHANT_DAMAGE_FACTOR =1.065;		// Each marginal point of weapon enchantment
		// multiplies damage by this factor.
		public const double  WEAPON_ENCHANT_ACCURACY_FACTOR=1.065;		// Each marginal point of weapon enchantment
		// multiplies accuracy by this factor.

		public const int WEAPON_KILLS_TO_AUTO_ID	= 20;
		public const int ARMOR_DELAY_TO_AUTO_ID	= 1000;
		public const int RING_DELAY_TO_AUTO_ID =	1500;

		const int COLS = RogueH.COLS; 
		const int ROWS = RogueH.ROWS; 

		const int NUMBER_POTION_KINDS = (int)potionKind.NUMBER_POTION_KINDS ;
		const int NUMBER_WAND_KINDS = (int)wandKind.NUMBER_WAND_KINDS ;
		const int NUMBER_SCROLL_KINDS = (int)scrollKind.NUMBER_SCROLL_KINDS ;

		const int NUMBER_CHARM_KINDS = (int)charmKind.NUMBER_CHARM_KINDS;

		const int NUMBER_ITEM_COLORS = RogueH.NUMBER_ITEM_COLORS ;
		const int NUMBER_ITEM_WOODS = RogueH.NUMBER_ITEM_WOODS ;
		const int NUMBER_ITEM_GEMS = RogueH.NUMBER_ITEM_GEMS ;
		const int NUMBER_ITEM_METALS = RogueH.NUMBER_ITEM_METALS ;

		const int NUMBER_TITLE_PHONEMES = RogueH.NUMBER_TITLE_PHONEMES;
		const int KEY_ID_MAXIMUM = RogueH.KEY_ID_MAXIMUM; 

		const int NUMBER_FOOD_KINDS = (int)foodKind.NUMBER_FOOD_KINDS;

		const weaponKind DAGGER = weaponKind.DAGGER;
		const weaponKind SWORD = weaponKind.SWORD;
		const weaponKind BROADSWORD = weaponKind.BROADSWORD;

		const weaponKind WHIP = weaponKind.WHIP;
		const weaponKind RAPIER = weaponKind.RAPIER;
		const weaponKind FLAIL = weaponKind.FLAIL;

		const weaponKind MACE = weaponKind.MACE;
		const weaponKind HAMMER = weaponKind.HAMMER;

		const weaponKind SPEAR = weaponKind.SPEAR;
		const weaponKind PIKE = weaponKind.PIKE;

		const weaponKind AXE = weaponKind.AXE;
		const weaponKind WAR_AXE = weaponKind.WAR_AXE;

		const weaponKind DART = weaponKind.DART;
		const weaponKind INCENDIARY_DART = weaponKind.INCENDIARY_DART;
		const weaponKind JAVELIN = weaponKind.JAVELIN;

		const int NUMBER_WEAPON_KINDS = (int)weaponKind.NUMBER_WEAPON_KINDS;


		const int NUMBER_ARMOR_KINDS = (int)armorKind.NUMBER_ARMOR_KINDS;

		const short RING_CLAIRVOYANCE = (short)ringKind.RING_CLAIRVOYANCE;
		const short RING_STEALTH = (short)ringKind.RING_STEALTH;
		const short RING_REGENERATION = (short)ringKind.RING_REGENERATION;
		const short RING_TRANSFERENCE = (short)ringKind.RING_TRANSFERENCE;
		const short RING_LIGHT = (short)ringKind.RING_LIGHT;
		const short RING_AWARENESS = (short)ringKind.RING_AWARENESS;
		const short RING_WISDOM = (short)ringKind.RING_WISDOM;
		const short RING_REAPING = (short)ringKind.RING_REAPING;
		const short NUMBER_RING_KINDS = (short)ringKind.NUMBER_RING_KINDS;

		const short A_MULTIPLICITY = (short)armorEnchants.A_MULTIPLICITY;
		const short A_MUTUALITY = (short)armorEnchants.A_MUTUALITY;
		const short A_ABSORPTION = (short)armorEnchants.A_ABSORPTION;
		const short A_REPRISAL = (short)armorEnchants.A_REPRISAL;
		const short A_IMMUNITY = (short)armorEnchants.A_IMMUNITY;
		const short A_REFLECTION = (short)armorEnchants.A_REFLECTION;
		const short A_RESPIRATION = (short)armorEnchants.A_RESPIRATION;
		const short A_DAMPENING = (short)armorEnchants.A_DAMPENING;
		const short A_BURDEN = (short)armorEnchants.A_BURDEN;
		const short NUMBER_GOOD_ARMOR_ENCHANT_KINDS = (short)armorEnchants.NUMBER_GOOD_ARMOR_ENCHANT_KINDS;
		const short A_VULNERABILITY = (short)armorEnchants.A_VULNERABILITY;
		const short A_IMMOLATION = (short)armorEnchants.A_IMMOLATION;
		const short NUMBER_ARMOR_ENCHANT_KINDS = (short)armorEnchants.NUMBER_ARMOR_ENCHANT_KINDS;

		const staffKind STAFF_LIGHTNING = staffKind.STAFF_LIGHTNING;
		const staffKind STAFF_FIRE = staffKind.STAFF_FIRE;
		const staffKind STAFF_POISON = staffKind.STAFF_POISON;
		const staffKind STAFF_TUNNELING = staffKind.STAFF_TUNNELING;
		const staffKind STAFF_BLINKING = staffKind.STAFF_BLINKING;
		const staffKind STAFF_ENTRANCEMENT = staffKind.STAFF_ENTRANCEMENT;
		const staffKind STAFF_OBSTRUCTION = staffKind.STAFF_OBSTRUCTION;
		const staffKind STAFF_DISCORD = staffKind.STAFF_DISCORD;
		const staffKind STAFF_CONJURATION = staffKind.STAFF_CONJURATION;
		const staffKind STAFF_HEALING = staffKind.STAFF_HEALING;
		const staffKind STAFF_HASTE = staffKind.STAFF_HASTE;
		const staffKind STAFF_PROTECTION = staffKind.STAFF_PROTECTION;
		const int NUMBER_STAFF_KINDS = (int)staffKind.NUMBER_STAFF_KINDS;

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


		const short W_SPEED = (short)weaponEnchants.W_SPEED;
		const short W_QUIETUS = (short)weaponEnchants.W_QUIETUS;
		const short W_PARALYSIS = (short)weaponEnchants.W_PARALYSIS;
		const short W_MULTIPLICITY = (short)weaponEnchants.W_MULTIPLICITY;
		const short W_SLOWING = (short)weaponEnchants.W_SLOWING;
		const short W_CONFUSION = (short)weaponEnchants.W_CONFUSION;
		const short W_FORCE = (short)weaponEnchants.W_FORCE;
		const short W_SLAYING = (short)weaponEnchants.W_SLAYING;
		const short W_MERCY = (short)weaponEnchants.W_MERCY;
		const short NUMBER_GOOD_WEAPON_ENCHANT_KINDS = (short)weaponEnchants.NUMBER_GOOD_WEAPON_ENCHANT_KINDS;
		const short W_PLENTY = (short)weaponEnchants.W_PLENTY;
		const short NUMBER_WEAPON_RUNIC_KINDS = (short)weaponEnchants.NUMBER_WEAPON_RUNIC_KINDS;

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

		const ushort CAN_BE_DETECTED = (ushort)itemCategory.CAN_BE_DETECTED;
		const ushort PRENAMED_CATEGORY = (ushort)itemCategory.PRENAMED_CATEGORY;
		const ushort NEVER_IDENTIFIABLE = (ushort)itemCategory.NEVER_IDENTIFIABLE;
		const ushort COUNTS_TOWARD_SCORE = (ushort)itemCategory.COUNTS_TOWARD_SCORE;
		const ushort CAN_BE_SWAPPED = (ushort)itemCategory.CAN_BE_SWAPPED;
		const ushort ALL_ITEMS = (ushort)itemCategory.ALL_ITEMS;


		const ulong ITEM_IDENTIFIED = (ulong)itemFlags.ITEM_IDENTIFIED;
		const ulong ITEM_EQUIPPED = (ulong)itemFlags.ITEM_EQUIPPED;
		const ulong ITEM_CURSED = (ulong)itemFlags.ITEM_CURSED;
		const ulong ITEM_PROTECTED = (ulong)itemFlags.ITEM_PROTECTED;
		// unused               = (1<<(4)),
		const ulong ITEM_RUNIC = (ulong)itemFlags.ITEM_RUNIC;
		const ulong ITEM_RUNIC_HINTED = (ulong)itemFlags.ITEM_RUNIC_HINTED;
		const ulong ITEM_RUNIC_IDENTIFIED = (ulong)itemFlags.ITEM_RUNIC_IDENTIFIED;
		const ulong ITEM_CAN_BE_IDENTIFIED = (ulong)itemFlags.ITEM_CAN_BE_IDENTIFIED;
		const ulong ITEM_PREPLACED = (ulong)itemFlags.ITEM_PREPLACED;
		const ulong ITEM_FLAMMABLE = (ulong)itemFlags.ITEM_FLAMMABLE;
		const ulong ITEM_MAGIC_DETECTED = (ulong)itemFlags.ITEM_MAGIC_DETECTED;
		const ulong ITEM_MAX_CHARGES_KNOWN = (ulong)itemFlags.ITEM_MAX_CHARGES_KNOWN;
		const ulong ITEM_IS_KEY = (ulong)itemFlags.ITEM_IS_KEY;

		const ulong ITEM_ATTACKS_HIT_SLOWLY = (ulong)itemFlags.ITEM_ATTACKS_HIT_SLOWLY;
		const ulong ITEM_ATTACKS_EXTEND = (ulong)itemFlags.ITEM_ATTACKS_EXTEND;
		const ulong ITEM_ATTACKS_QUICKLY = (ulong)itemFlags.ITEM_ATTACKS_QUICKLY;
		const ulong ITEM_ATTACKS_PENETRATE = (ulong)itemFlags.ITEM_ATTACKS_PENETRATE;
		const ulong ITEM_ATTACKS_ALL_ADJACENT = (ulong)itemFlags.ITEM_ATTACKS_ALL_ADJACENT;
		const ulong ITEM_LUNGE_ATTACKS = (ulong)itemFlags.ITEM_LUNGE_ATTACKS;
		const ulong ITEM_SNEAK_ATTACK_BONUS = (ulong)itemFlags.ITEM_SNEAK_ATTACK_BONUS;
		const ulong ITEM_PASS_ATTACKS = (ulong)itemFlags.ITEM_PASS_ATTACKS;

		const ulong ITEM_KIND_AUTO_ID = (ulong)itemFlags.ITEM_KIND_AUTO_ID;
		const ulong ITEM_PLAYER_AVOIDS = (ulong)itemFlags.ITEM_PLAYER_AVOIDS;

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


		public char [][] itemTitles = Global.itemTitles;  
		public char [][] itemColors = Global.itemColors;  
		public char [][] itemMetals = Global.itemMetals;  
		public char [][] itemWoods  = Global.itemWoods;  
		public char [][] itemGems   = Global.itemGems;   



		public itemTable [] scrollTable = Global.GetInstance().scrollTable ; 
		public itemTable[] potionTable = Global.GetInstance(). potionTable;

		public itemTable[] wandTable   = Global.GetInstance(). wandTable;
		public itemTable[] staffTable  = Global.GetInstance(). staffTable;

		public itemTable[] ringTable  = Global.GetInstance(). ringTable;
		public itemTable[] charmTable = Global.GetInstance(). charmTable;

		public itemTable[] foodTable = Global.GetInstance(). foodTable;
		public itemTable[] weaponTable = Global.GetInstance(). weaponTable;
		public itemTable[] armorTable = Global.GetInstance(). armorTable;


		public readonly string[] itemColorsRef = Global.itemColorsRef;
		public readonly string[] itemWoodsRef = Global.itemWoodsRef;
		public readonly string[] itemGemsRef = Global.itemGemsRef;
		public readonly string[] itemMetalsRef = Global.itemMetalsRef;
		public readonly string[] titlePhonemes = Global.titlePhonemes;

		static short[,] nbDirs  =  Global .nbDirs ; 
		static short[,] cDirs   =  Global .cDirs ; 

		monsterClass[]  monsterClassCatalog = Global.GetInstance().monsterClassCatalog ;
		int MONSTER_CLASS_COUNT = Global.GetInstance().monsterClassCatalog.Length ;



		void resetItemTableEntry(itemTable theEntry) {
			theEntry.identified = false;
			theEntry.called = false;
			theEntry.callTitle = ""; // [0] = '\0';  // commonFunc.zeroOut_1D_array ?
		}





		//*
		public void shuffleFlavors() {
			short i, j, randIndex, randNumber;
			char []buf = new char[COLS];

			for (i=0; i<NUMBER_POTION_KINDS; i++) {
				resetItemTableEntry(potionTable[i]);
			}
			for (i=0; i<NUMBER_STAFF_KINDS; i++) {
				resetItemTableEntry(staffTable[i]);
			}
			for (i=0; i<NUMBER_WAND_KINDS; i++) {
				resetItemTableEntry(wandTable [i]);
			}
			for (i=0; i<NUMBER_SCROLL_KINDS; i++) {
				resetItemTableEntry(scrollTable [i]);
			}
			for (i=0; i<NUMBER_RING_KINDS; i++) {
				resetItemTableEntry(ringTable [i]);
			}

			for (i=0; i<NUMBER_ITEM_COLORS; i++) {
				strcpy(itemColors[i], itemColorsRef[i]);
			}

			// change order of itemColors
			for (i=0; i<NUMBER_ITEM_COLORS; i++) {
				randIndex = rand_range(0, NUMBER_ITEM_COLORS - 1);
				if (randIndex != i) {
					strcpy(buf, itemColors[i]);
					strcpy(itemColors[i], itemColors[randIndex]);
					strcpy(itemColors[randIndex], buf);
				}
			}

			for (i=0; i<NUMBER_ITEM_WOODS; i++) {
				strcpy(itemWoods[i], itemWoodsRef[i]);
			}
			for (i=0; i<NUMBER_ITEM_WOODS; i++) {
				randIndex = rand_range(0, NUMBER_ITEM_WOODS - 1);
				if (randIndex != i) {
					strcpy(buf, itemWoods[i]);
					strcpy(itemWoods[i], itemWoods[randIndex]);
					strcpy(itemWoods[randIndex], buf);
				}
			}

			for (i=0; i<NUMBER_ITEM_GEMS; i++) {
				strcpy(itemGems[i], itemGemsRef[i]);
			}
			for (i=0; i<NUMBER_ITEM_GEMS; i++) {
				randIndex = rand_range(0, NUMBER_ITEM_GEMS - 1);
				if (randIndex != i) {
					strcpy(buf, itemGems[i]);
					strcpy(itemGems[i], itemGems[randIndex]);
					strcpy(itemGems[randIndex], buf);
				}
			}

			for (i=0; i<NUMBER_ITEM_METALS; i++) {
				strcpy(itemMetals[i], itemMetalsRef[i]);
			}
			for (i=0; i<NUMBER_ITEM_METALS; i++) {
				randIndex = rand_range(0, NUMBER_ITEM_METALS - 1);
				if (randIndex != i) {
					strcpy(buf, itemMetals[i]);
					strcpy(itemMetals[i], itemMetals[randIndex]);
					strcpy(itemMetals[randIndex], buf);
				}
			}

			for (i=0; i<NUMBER_SCROLL_KINDS; i++) {
				// itemTitles[i][0] = '\0';
				commonFunc.zeroOut_1D_array<char>( itemTitles[i] );

				randNumber = rand_range(3, 4);
				for (j=0; j<randNumber; j++) {
					randIndex = rand_range(0, NUMBER_TITLE_PHONEMES - 1);
					strcpy(buf, itemTitles[i]);
					commonFunc.sprintf(itemTitles[i], "{0}{0}{0}", 
						__arglist(buf, (( Random.rand_percent(50) && j>0) ? " " : ""), titlePhonemes[randIndex] )
					);

				}
			}
		}

		//*/

		public item initializeItem() {
			short i;
			item theItem;

			theItem = new item ();

			theItem.category = 0;
			theItem.kind = 0;
			theItem.flags = 0;
			theItem.displayChar = '&';
			theItem.foreColor = Global.itemColor;
			theItem.inventoryColor = Global.white;
			theItem.armor = 0;
			theItem.strengthRequired = 0;
			theItem.enchant1 = 0;
			theItem.enchant2 = 0;
			theItem.timesEnchanted = 0;
			theItem.vorpalEnemy = 0;
			theItem.charges = 0;
			theItem.quantity = 1;
			theItem.quiverNumber = 0;
			theItem.originDepth = 0;
			// theItem.inscription[0] = '\0';
			commonFunc.zeroOut_1D_array<char>( theItem.inscription );

			theItem.nextItem = null;

			for (i=0; i < KEY_ID_MAXIMUM; i++) {
				theItem.keyLoc[i].x = 0;
				theItem.keyLoc[i].y = 0;
				theItem.keyLoc[i].machine = 0;
				theItem.keyLoc[i].disposableHere = false;
			}
			return theItem;
		}

		ulong pickItemCategory(  ulong theCategory) {
			short i, sum, randIndex;
			short[]  probabilities =            {50,	42,		52,		3,		3,		10,		8,		2,		3,      2,        0,		0,		0}; // 13
			ushort[] correspondingCategories  =	{GOLD,	SCROLL,	POTION,	STAFF,	WAND,	WEAPON,	ARMOR,	FOOD,	RING,   CHARM,    AMULET,	GEM,	KEY}; // 13

			sum = 0;

			for (i=0; i<correspondingCategories.Length; i++) {
				if (theCategory <= 0 || (theCategory & correspondingCategories[i]) != 0 ) {
					sum += probabilities[i];
				}
			}

			if (sum == 0) {
				return theCategory; // e.g. when you pass in AMULET or GEM, since they have no frequency
			}

			randIndex = rand_range(1, sum);

			for (i=0; ; i++) {
				if (theCategory <= 0 || (theCategory & correspondingCategories[i] )!=0 ) {
					if (randIndex <= probabilities[i]) {
						return correspondingCategories[i];
					}
					randIndex -= probabilities[i];
				}
			}
		}

		short chooseKind(itemTable[] theTable, short numKinds) {
			short i, totalFrequencies = 0, randomFrequency;
			for (i=0; i<numKinds; i++) {
				totalFrequencies += Math.Max((short)0, theTable[i].frequency);
			}
			randomFrequency = rand_range(1, totalFrequencies);
			for (i=0; randomFrequency > theTable[i].frequency; i++) {
				randomFrequency -= Math.Max((short)0, theTable[i].frequency);
			}
			return i;
		}

		short chooseVorpalEnemy() {
			playerCharacter rogue = RogueMain.GetInstance().getRogue(); // will it cause stackoverflow ?

			short i;
			short[] frequencies = new short[MONSTER_CLASS_COUNT];
			for (i = 0; i < MONSTER_CLASS_COUNT; i++) {
				if (monsterClassCatalog[i].maxDepth <= 0
					|| rogue.depthLevel <= monsterClassCatalog[i].maxDepth) {

					frequencies[i] = monsterClassCatalog[i].frequency;
				} else {
					frequencies[i] = 0;
				}
			}
			return lotteryDraw(frequencies, (short)MONSTER_CLASS_COUNT);
		}

		short lotteryDraw(short []frequencies, short itemCount) {
			short i, maxFreq, randIndex;
			maxFreq = 0;
			for (i = 0; i < itemCount; i++) {
				maxFreq += frequencies[i];
			}
			RogueMain.brogueAssert(maxFreq > 0);
			randIndex = rand_range(0, maxFreq - 1);
			for (i = 0; i < itemCount; i++) {
				if (frequencies[i] > randIndex) {
					return i;
				} else {
					randIndex -= frequencies[i];
				}
			}
			RogueMain.brogueAssert(false);
			return 0;
		}

		// Sets an item to the given type and category (or chooses randomly if -1) with all other stats
		item makeItemInto(item theItem,  ulong itemCategory, short itemKind) {
			playerCharacter rogue = RogueMain.GetInstance().getRogue(); // will it cause stackoverflow ?

			itemTable theEntry = null ;

			if (itemCategory <= 0) {
				itemCategory = ALL_ITEMS;
			}

			itemCategory = pickItemCategory(itemCategory);

			theItem.category = (ushort)itemCategory;

			switch (itemCategory) {

			case FOOD:
				if (itemKind < 0) {
					itemKind = chooseKind( foodTable, NUMBER_FOOD_KINDS);
				}
				theEntry = foodTable[itemKind];  // &
				theItem.displayChar = Global.FOOD_CHAR;
				theItem.flags |= ITEM_IDENTIFIED;
				break;

			case WEAPON:
				if (itemKind < 0) {
					itemKind = chooseKind(weaponTable, NUMBER_WEAPON_KINDS);
				}
				theEntry = weaponTable[itemKind];
				theItem.damage = weaponTable[itemKind].range;
				theItem.strengthRequired = weaponTable[itemKind].strengthRequired;
				theItem.displayChar = Global.WEAPON_CHAR;

				switch ( (weaponKind) itemKind) {
				case DAGGER:
					theItem.flags |= ITEM_SNEAK_ATTACK_BONUS;
					break;
				case MACE:
				case HAMMER:
					theItem.flags |= ITEM_ATTACKS_HIT_SLOWLY;
					break;
				case WHIP:
					theItem.flags |= ITEM_ATTACKS_EXTEND;
					break;
				case RAPIER:
					theItem.flags |= (ITEM_ATTACKS_QUICKLY | ITEM_LUNGE_ATTACKS);
					break;
				case FLAIL:
					theItem.flags |= ITEM_PASS_ATTACKS;
					break;
				case SPEAR:
				case PIKE:
					theItem.flags |= ITEM_ATTACKS_PENETRATE;
					break;
				case AXE:
				case WAR_AXE:
					theItem.flags |= ITEM_ATTACKS_ALL_ADJACENT;
					break;
				default:
					break;
				}

				if (rand_percent(40)) {
					theItem.enchant1 += rand_range(1, 3);
					if (rand_percent(50)) {
						// cursed
						theItem.enchant1 *= -1;
						theItem.flags |= ITEM_CURSED;
						if (rand_percent(33)) { // give it a bad runic
							theItem.enchant2 = rand_range(NUMBER_GOOD_WEAPON_ENCHANT_KINDS, NUMBER_WEAPON_RUNIC_KINDS - 1);
							theItem.flags |= ITEM_RUNIC;
						}
					} else if (rand_range(3, 10)
						* ((theItem.flags & ITEM_ATTACKS_HIT_SLOWLY)!=0 ? 2 : 1)
						/ ((theItem.flags & ITEM_ATTACKS_QUICKLY)!=0 ? 2 : 1)
						> theItem.damage.lowerBound) {
						// give it a good runic; lower damage items are more likely to be runic
						theItem.enchant2 = rand_range(0, NUMBER_GOOD_WEAPON_ENCHANT_KINDS - 1);
						theItem.flags |= ITEM_RUNIC;
						if (theItem.enchant2 == W_SLAYING) {
							theItem.vorpalEnemy =(monsterTypes)chooseVorpalEnemy();
						}
					} else {
						while (rand_percent(10)) {
							theItem.enchant1++;
						}
					}
				}
				if ((weaponKind)itemKind == DART || (weaponKind)itemKind == INCENDIARY_DART || (weaponKind)itemKind == JAVELIN) {
					if ((weaponKind)itemKind == INCENDIARY_DART) {
						theItem.quantity = rand_range(3, 6);
					} else {
						theItem.quantity = rand_range(5, 18);
					}
					theItem.quiverNumber = (ushort) rand_range(1, 60000);
					theItem.flags &= ~(ITEM_CURSED | ITEM_RUNIC); // throwing weapons can't be cursed or runic
					theItem.enchant1 = 0; // throwing weapons can't be magical
				}
				theItem.charges = WEAPON_KILLS_TO_AUTO_ID; // kill 20 enemies to auto-identify
				break;

			case ARMOR:
				if (itemKind < 0) {
					itemKind = chooseKind(armorTable, NUMBER_ARMOR_KINDS);
				}
				theEntry = armorTable[itemKind];
				theItem.armor = randClump(armorTable[itemKind].range);
				theItem.strengthRequired = armorTable[itemKind].strengthRequired;
				theItem.displayChar = Global.ARMOR_CHAR;
				theItem.charges = ARMOR_DELAY_TO_AUTO_ID; // this many turns until it reveals its enchants and whether runic
				if (rand_percent(40)) {
					theItem.enchant1 += rand_range(1, 3);
					if (rand_percent(50)) {
						// cursed
						theItem.enchant1 *= -1;
						theItem.flags |= ITEM_CURSED;
						if (rand_percent(33)) { // give it a bad runic
							theItem.enchant2 = rand_range(NUMBER_GOOD_ARMOR_ENCHANT_KINDS, NUMBER_ARMOR_ENCHANT_KINDS - 1);
							theItem.flags |= ITEM_RUNIC;
						}
					} else if (rand_range(0, 95) > theItem.armor) { // give it a good runic
						theItem.enchant2 = rand_range(0, NUMBER_GOOD_ARMOR_ENCHANT_KINDS - 1);
						theItem.flags |= ITEM_RUNIC;
						if (theItem.enchant2 == A_IMMUNITY) {
							theItem.vorpalEnemy = (monsterTypes)chooseVorpalEnemy();
						}
					} else {
						while (rand_percent(10)) {
							theItem.enchant1++;
						}
					}
				}
				break;
			case SCROLL:
				if (itemKind < 0) {
					itemKind = chooseKind(scrollTable, NUMBER_SCROLL_KINDS);
				}
				theEntry = scrollTable[itemKind];
				theItem.displayChar = Global.SCROLL_CHAR;
				theItem.flags |= ITEM_FLAMMABLE;
				break;
			case POTION:
				if (itemKind < 0) {
					itemKind = chooseKind(potionTable, NUMBER_POTION_KINDS);
				}
				theEntry = potionTable[itemKind];
				theItem.displayChar = Global.POTION_CHAR;
				break;
			case STAFF:
				if (itemKind < 0) {
					itemKind = chooseKind(staffTable, NUMBER_STAFF_KINDS);
				}
				theEntry = staffTable[itemKind];
				theItem.displayChar = Global.STAFF_CHAR;
				theItem.charges = 2;
				if (rand_percent(50)) {
					theItem.charges++;
					if (rand_percent(15)) {
						theItem.charges++;
						while (rand_percent(10)) {
							theItem.charges++;
						}
					}
				}
				theItem.enchant1 = theItem.charges;
				theItem.enchant2 = (short) ( (staffKind)itemKind == STAFF_BLINKING || (staffKind)itemKind == STAFF_OBSTRUCTION ? 1000 : 500); // start with no recharging mojo
				break;
			case WAND:
				if (itemKind < 0) {
					itemKind = chooseKind(wandTable, NUMBER_WAND_KINDS);
				}
				theEntry = wandTable[itemKind];
				theItem.displayChar = Global.WAND_CHAR;
				theItem.charges = randClump(wandTable[itemKind].range);
				break;
			case RING:
				if (itemKind < 0) {
					itemKind = chooseKind(ringTable, NUMBER_RING_KINDS);
				}
				theEntry = ringTable[itemKind];
				theItem.displayChar = Global.RING_CHAR;
				theItem.enchant1 = randClump(ringTable[itemKind].range);
				theItem.charges = RING_DELAY_TO_AUTO_ID; // how many turns of being worn until it auto-identifies
				if (rand_percent(16)) {
					// cursed
					theItem.enchant1 *= -1;
					theItem.flags |= ITEM_CURSED;
				} else {
					while (rand_percent(10)) {
						theItem.enchant1++;
					}
				}
				break;
			case CHARM:
				if (itemKind < 0) {
					itemKind = chooseKind(charmTable, NUMBER_CHARM_KINDS);
				}
				theItem.displayChar = Global.CHARM_CHAR;
				theItem.charges = 0; // Charms are initially ready for use.
				theItem.enchant1 = randClump(charmTable[itemKind].range);
				while (rand_percent(7)) {
					theItem.enchant1++;
				}
				theItem.flags |= ITEM_IDENTIFIED;
				break;
			case GOLD:
				theEntry = null;
				theItem.displayChar = Global.GOLD_CHAR;
				theItem.quantity = rand_range(50 + rogue.depthLevel * 10, 100 + rogue.depthLevel * 15);
				break;
			case AMULET:
				theEntry = null;
				theItem.displayChar = Global.AMULET_CHAR;
				itemKind = 0;
				theItem.flags |= ITEM_IDENTIFIED;
				break;
			case GEM:
				theEntry = null;
				theItem.displayChar = Global.GEM_CHAR;
				itemKind = 0;
				theItem.flags |= ITEM_IDENTIFIED;
				break;
			case KEY:
				theEntry = null;
				theItem.displayChar = Global.KEY_CHAR;
				theItem.flags |= ITEM_IDENTIFIED;
				break;
			default:
				theEntry = null;
				IO.message("something has gone terribly wrong!", true);
				break;
			}
			if (theItem != null
				&& ! ((theItem.flags & ITEM_IDENTIFIED) !=0 )
				&& ( 
						!((theItem.category & (POTION | SCROLL))!=0 ) 
						|| (theEntry!=null && !theEntry.identified)
				   )
			) {

				theItem.flags |= ITEM_CAN_BE_IDENTIFIED;
			}
			theItem.kind = itemKind;

			#if ALL_IDENTIFIED
			identifyItemKind(theItem);
			#endif

			return theItem;
		}


		// Allocates space, generates a specified item (or random category/kind if -1)
		// and returns a pointer to that item. The item is not given a location here
		// and is not inserted into the item chain!
		public item generateItem( ushort theCategory, short theKind) {
			item theItem = initializeItem();
			makeItemInto(theItem, theCategory, theKind);
			return theItem;
		}

		void conflateItemCharacteristics(item newItem, item oldItem) {

			// let magic detection and other flags propagate to the new stack...
			newItem.flags |= (oldItem.flags & (ITEM_MAGIC_DETECTED | ITEM_IDENTIFIED | ITEM_PROTECTED | ITEM_RUNIC
				| ITEM_RUNIC_HINTED | ITEM_CAN_BE_IDENTIFIED | ITEM_MAX_CHARGES_KNOWN));

			// keep the higher enchantment and lower strength requirement...
			if (oldItem.enchant1 > newItem.enchant1) {
				newItem.enchant1 = oldItem.enchant1;
			}
			if (oldItem.strengthRequired < newItem.strengthRequired) {
				newItem.strengthRequired = oldItem.strengthRequired;
			}
			// Copy the inscription.
			//* 
			if (oldItem.inscription[0]!=0 && newItem.inscription[0]== 0) {
				// 						<-
				strcpy(newItem.inscription, oldItem.inscription);
			}
			//*/
			// Keep track of origin depth only if every item in the stack has the same origin depth.
			if (oldItem.originDepth <= 0 || newItem.originDepth != oldItem.originDepth) {
				newItem.originDepth = 0;
			}
		}

		void deleteItem(item theItem) {
			//free(theItem);
		}
		void stackItems(item newItem, item oldItem) {
			//Increment the quantity of the old item...
			newItem.quantity += oldItem.quantity;

			// ...conflate attributes...
			conflateItemCharacteristics(newItem, oldItem);

			// ...and delete the new item.
			deleteItem(oldItem);
		}

		char nextAvailableInventoryCharacter() {
			item packItems = RogueMain.GetInstance ().packItems ;

			bool[] charTaken = new bool[26];
			short i;
			item theItem;
			char c;
			for(i=0; i<26; i++) {
				charTaken[i] = false;
			}
			for (theItem = packItems.nextItem; theItem != null; theItem = theItem.nextItem) {
				c = theItem.inventoryLetter;
				if (c >= 'a' && c <= 'z') {
					charTaken[c - 'a'] = true;
				}
			}
			for(i=0; i<26; i++) {
				if (!charTaken[i]) {
					return (char)('a' + i);
				}
			}
			return (char)0;
		}

		public item addItemToPack(item theItem) {
			item packItems = RogueMain.GetInstance ().packItems ;

			item previousItem, tempItem;
			char itemLetter;

			// Can the item stack with another in the inventory?
			if ( (theItem.category & (FOOD|POTION|SCROLL|GEM) ) != 0 ) {
				for (tempItem = packItems.nextItem; tempItem != null; tempItem = tempItem.nextItem) {
					if (theItem.category == tempItem.category && theItem.kind == tempItem.kind) {
						// We found a match!
						stackItems(tempItem, theItem);

						// Pass back the incremented (old) item. No need to add it to the pack since it's already there.
						return tempItem;
					}
				}
			} else if ( (theItem.category & WEAPON)!=0 && theItem.quiverNumber > 0) {
				for (tempItem = packItems.nextItem; tempItem != null; tempItem = tempItem.nextItem) {
					if (theItem.category == tempItem.category && theItem.kind == tempItem.kind
						&& theItem.quiverNumber == tempItem.quiverNumber) {
						// We found a match!
						stackItems(tempItem, theItem);

						// Pass back the incremented (old) item. No need to add it to the pack since it's already there.
						return tempItem;
					}
				}
			}

			// assign a reference letter to the item
			itemLetter = nextAvailableInventoryCharacter();
			if (itemLetter != 0 ) {
				theItem.inventoryLetter = itemLetter;
			}

			// insert at proper place in pack chain
			for (previousItem = packItems;
				previousItem.nextItem != null && previousItem.nextItem.category <= theItem.category;
				previousItem = previousItem.nextItem);
			theItem.nextItem = previousItem.nextItem;
			previousItem.nextItem = theItem;

			return theItem;
		}


		short effectiveRingEnchant(item theItem) {
			if (theItem.category != RING) {
				return 0;
			}
			if (   (theItem.flags & ITEM_IDENTIFIED)==0 
				  && theItem.enchant1 > 0
			) {

				return (short)(theItem.timesEnchanted + 1); // Unidentified positive rings act as +1 until identified.
			}
			return theItem.enchant1;
		}


		public void updateRingBonuses() {
			playerCharacter rogue = RogueMain.GetInstance().getRogue(); // will it cause stackoverflow ?

			short i;
			item[] rings = {rogue.ringLeft, rogue.ringRight};

			rogue.clairvoyance = rogue.stealthBonus = rogue.transference
				= rogue.awarenessBonus = rogue.regenerationBonus = rogue.wisdomBonus = rogue.reaping = 0;
			rogue.lightMultiplier = 1;

			for (i=0; i<= 1; i++) {
				if (rings[i] !=null ) {
					switch (rings[i].kind) {
					case RING_CLAIRVOYANCE:
						rogue.clairvoyance += effectiveRingEnchant(rings[i]);
						break;
					case RING_STEALTH:
						rogue.stealthBonus += effectiveRingEnchant(rings[i]);
						break;
					case RING_REGENERATION:
						rogue.regenerationBonus += effectiveRingEnchant(rings[i]);
						break;
					case RING_TRANSFERENCE:
						rogue.transference += effectiveRingEnchant(rings[i]);
						break;
					case RING_LIGHT:
						rogue.lightMultiplier += effectiveRingEnchant(rings[i]);
						break;
					case RING_AWARENESS:
						rogue.awarenessBonus += (short)(20 * effectiveRingEnchant(rings[i]) );
						break;
					case RING_WISDOM:
						rogue.wisdomBonus += effectiveRingEnchant(rings[i]);
						break;
					case RING_REAPING:
						rogue.reaping += effectiveRingEnchant(rings[i]);
						break;
					}
				}
			}

			if (rogue.lightMultiplier <= 0) {
				rogue.lightMultiplier--; // because it starts at positive 1 instead of 0
			}

			Light.GetInstance().updateMinersLightRadius();
			updatePlayerRegenerationDelay();

			if (rogue.stealthBonus < 0) {
				rogue.stealthBonus *= 4;
			}
		}

		void updatePlayerRegenerationDelay() {
			playerCharacter rogue = RogueMain.GetInstance().getRogue(); // will it cause stackoverflow ?

			creature player = RogueMain.GetInstance ().getPlayer ();

			short maxHP;
			long turnsForFull; // In thousandths of a turn.
			maxHP = player.info.maxHP;
			turnsForFull = turnsForFullRegen(rogue.regenerationBonus);

			player.regenPerTurn = 0;
			while (maxHP > turnsForFull / 1000) {
				player.regenPerTurn++;
				maxHP -= (short)(turnsForFull / 1000);
			}

			player.info.turnsBetweenRegen = (turnsForFull / maxHP);
			// DEBUG printf("\nTurnsForFull: %i; regenPerTurn: %i; (thousandths of) turnsBetweenRegen: %i", turnsForFull, player.regenPerTurn, player.info.turnsBetweenRegen);
		}


		long turnsForFullRegen( double bonus) {
			return ((long)(1000 * RogueH.TURNS_FOR_FULL_REGEN * Math.Pow (0.75, (bonus)) + 2000 + RogueH.FLOAT_FUDGE));
		}

		public void identify(item theItem) {
			theItem.flags |= ITEM_IDENTIFIED;
			theItem.flags &= ~ITEM_CAN_BE_IDENTIFIED;
			if ( (theItem.flags & ITEM_RUNIC) != 0) {
				theItem.flags |= (ITEM_RUNIC_IDENTIFIED | ITEM_RUNIC_HINTED);
			}
			if ( (theItem.category & RING)!=0 ) {
				updateRingBonuses();
			}
			identifyItemKind(theItem);
		}


		// kindCount is optional
		itemTable[] tableForItemCategory( itemCategory theCat, out short kindCount) {
			itemTable[] returnedTable;
			short returnedCount;
			switch ((ushort)theCat) {
			case FOOD:
				returnedTable = foodTable;
				returnedCount = NUMBER_FOOD_KINDS;
				break;
			case WEAPON:
				returnedTable = weaponTable;
				returnedCount = NUMBER_WEAPON_KINDS;
				break;
			case ARMOR:
				returnedTable = armorTable;
				returnedCount = NUMBER_ARMOR_KINDS;
				break;
			case POTION:
				returnedTable = potionTable;
				returnedCount = NUMBER_POTION_KINDS;
				break;
			case SCROLL:
				returnedTable = scrollTable;
				returnedCount = NUMBER_SCROLL_KINDS;
				break;
			case RING:
				returnedTable = ringTable;
				returnedCount = NUMBER_RING_KINDS;
				break;
			case WAND:
				returnedTable = wandTable;
				returnedCount = NUMBER_WAND_KINDS;
				break;
			case STAFF:
				returnedTable = staffTable;
				returnedCount = NUMBER_STAFF_KINDS;
				break;
			case CHARM:
				returnedTable = charmTable;
				returnedCount = NUMBER_CHARM_KINDS;
				break;
			default:
				returnedTable = null;
				returnedCount = 0;
				break;
			}
			//if (kindCount) 
			{
				kindCount = returnedCount;
			}
			return returnedTable;
		}



		void identifyItemKind(item theItem) {
			itemTable[] theTable;
			short tableCount, i, lastItem;

			short _;
			theTable = tableForItemCategory( (itemCategory)theItem.category, out _);
			if (theTable != null) {
				theItem.flags &= ~ITEM_KIND_AUTO_ID;

				tableCount = 0;
				lastItem = -1;

				switch (theItem.category) {
				case SCROLL:
					tableCount = NUMBER_SCROLL_KINDS;
					break;
				case POTION:
					tableCount = NUMBER_POTION_KINDS;
					break;
				case WAND:
					tableCount = NUMBER_WAND_KINDS;
					break;
				case STAFF:
					tableCount = NUMBER_STAFF_KINDS;
					break;
				case RING:
					tableCount = NUMBER_RING_KINDS;
					break;
				default:
					break;
				}
				if (
					(theItem.category & RING) != 0
					 && theItem.enchant1 <= 0
				) {

					theItem.flags |= ITEM_IDENTIFIED;
				}

				if ((theItem.category & WAND)!= 0
					&& theTable[theItem.kind].range.lowerBound == theTable[theItem.kind].range.upperBound) {

					theItem.flags |= ITEM_IDENTIFIED;
				}
				if (tableCount !=0) {
					theTable[theItem.kind].identified = true;
					for (i=0; i<tableCount; i++) {
						if (!(theTable[i].identified)) {
							if (lastItem != -1) {
								return; // At least two unidentified items remain.
							}
							lastItem = i;
						}
					}
					if (lastItem != -1) {
						// Exactly one unidentified item remains; identify it.
						theTable[lastItem].identified = true;
					}
				}
			}
		}

		float strengthModifier(item theItem) {
			playerCharacter rogue = RogueMain.GetInstance().getRogue(); 
			creature player = RogueMain.GetInstance ().getPlayer ();

			short difference = (short)((rogue.strength - player.weaknessAmount) - theItem.strengthRequired );
			if (difference > 0) {
				return (float) 0.25 * difference;
			} else {
				return (float) 2.5 * difference;
			}
		}

		float netEnchant(item theItem) {
			if ( (theItem.category & (WEAPON | ARMOR)) !=0 ) {
				return ((float) theItem.enchant1) + strengthModifier(theItem);
			} else {
				return ((float) theItem.enchant1);
			}
		}

		public void recalculateEquipmentBonuses() {
			playerCharacter rogue = RogueMain.GetInstance().getRogue(); // will it cause stackoverflow ?
			creature player = RogueMain.GetInstance ().getPlayer ();

			float enchant;
			item theItem;

			if (rogue.weapon != null ) {
				theItem = rogue.weapon;
				enchant = netEnchant(theItem);
				player.info.damage = theItem.damage;
				player.info.damage.lowerBound *= (short)Math.Pow(WEAPON_ENCHANT_DAMAGE_FACTOR, enchant);
				player.info.damage.upperBound *= (short)Math.Pow(WEAPON_ENCHANT_DAMAGE_FACTOR, enchant);
				if (player.info.damage.lowerBound < 1) {
					player.info.damage.lowerBound = 1;
				}
				if (player.info.damage.upperBound < 1) {
					player.info.damage.upperBound = 1;
				}
			}

			if (rogue.armor != null) {
				theItem = rogue.armor;
				enchant = netEnchant(theItem);
				enchant -= player.status[ STATUS_DONNING];
				player.info.defense = (short)(theItem.armor + (enchant + RogueH.FLOAT_FUDGE) * 10 );
				if (player.info.defense < 0) {
					player.info.defense = 0;
				}
			}
		}

		public void equipItem(item theItem, bool  force) {
			playerCharacter rogue = RogueMain.GetInstance().getRogue(); 
			creature player = RogueMain.GetInstance ().getPlayer ();

			item previouslyEquippedItem = null;

			if ((theItem.category & RING)!=0 && (theItem.flags & ITEM_EQUIPPED)!=0 ) {
				return;
			}

			if ( (theItem.category & WEAPON)!=0 ) {
				previouslyEquippedItem = rogue.weapon;
			} else if ( (theItem.category & ARMOR)!=0 ) {
				previouslyEquippedItem = rogue.armor;
			}
			if (previouslyEquippedItem != null) {
				if (!force && (previouslyEquippedItem.flags & ITEM_CURSED)!=0 ) {
					return; // already using a cursed item
				} else {
					unequipItem(previouslyEquippedItem, force);
				}
			}
			if ( (theItem.category & WEAPON)!=0 ) {
				rogue.weapon = theItem;
				recalculateEquipmentBonuses();
			} else if ( (theItem.category & ARMOR)!=0 ) {
				if (!force) {
					player.status[STATUS_DONNING] =player.maxStatus[STATUS_DONNING] = (short)(theItem.armor / 10);
				}
				rogue.armor = theItem;
				recalculateEquipmentBonuses();
			} else if ( (theItem.category & RING)!=0 ) {
				if (rogue.ringLeft!=null && rogue.ringRight!=null) {
					return;
				}
				if (rogue.ringLeft!=null) {
					rogue.ringRight = theItem;
				} else {
					rogue.ringLeft = theItem;
				}
				updateRingBonuses();
				if (theItem.kind == RING_CLAIRVOYANCE) {
					updateClairvoyance();
					displayLevel();
					identifyItemKind(theItem);
				} else if (theItem.kind == RING_LIGHT
					|| theItem.kind == RING_STEALTH) {
					identifyItemKind(theItem);
				}
			}
			theItem.flags |= ITEM_EQUIPPED;
			return;
		}

		public void unequipItem(item theItem, bool force) {
			creature player = RogueMain.GetInstance ().getPlayer ();
			playerCharacter rogue = RogueMain.GetInstance().getRogue(); 

			if (theItem == null || (theItem.flags & ITEM_EQUIPPED)==0) {
				return;
			}
			if ((theItem.flags & ITEM_CURSED)!=0 && !force) {
				return;
			}
			theItem.flags &= ~ITEM_EQUIPPED;
			if ( (theItem.category & WEAPON)!=0 ) {
				player.info.damage.lowerBound = 1;
				player.info.damage.upperBound = 2;
				player.info.damage.clumpFactor = 1;
				rogue.weapon = null;
			}
			if ( (theItem.category & ARMOR)!=0 ) {
				player.info.defense = 0;
				rogue.armor = null;
				player.status[STATUS_DONNING] = 0;
			}
			if ( (theItem.category & RING)!=0 ) {
				if (rogue.ringLeft == theItem) {
					rogue.ringLeft = null;
				} else if (rogue.ringRight == theItem) {
					rogue.ringRight = null;
				}
				updateRingBonuses();
				if (theItem.kind == RING_CLAIRVOYANCE) {
					updateClairvoyance();
					updateFieldOfViewDisplay(false, false);
					updateClairvoyance(); // Yes, we have to call this a second time.
					displayLevel();
				}
			}
			updateEncumbrance();
			return;
		}

		void updateEncumbrance() {
			creature player = RogueMain.GetInstance ().getPlayer ();

			short moveSpeed, attackSpeed;

			moveSpeed = player.info.movementSpeed;
			attackSpeed = player.info.attackSpeed;

			if (player.status[STATUS_HASTED] != 0) {
				moveSpeed /= 2;
				attackSpeed /= 2;
			} else if (player.status[STATUS_SLOWED] !=0) {
				moveSpeed *= 2;
				attackSpeed *= 2;
			}

			player.movementSpeed = moveSpeed;
			player.attackSpeed = attackSpeed;

			recalculateEquipmentBonuses();
		}






		//=============================
		// TODO map related
		void updateClairvoyance() {
			// TODO
			Debug.Log ( "TODO ~~~ updateClairvoyance " ) ;
		}
		//=============================
		//=============================
		//=============================
		//=============================

		// ------------------------// ------------------------// ------------------------
		// ------------------------// ------------------------// ------------------------
		// ------------------------
		short rand_range( int lower , int upper) {
			return (short)Random.rand_range (lower, upper);
		}

		bool rand_percent(short percent) {
			return Random.rand_percent ( percent );

		}

		short randClump(randomRange theRange) {
			return Random.randClump (theRange);
		}

		void displayLevel() {
			IO.GetInstance ().displayLevel ();
		}
	
		void updateFieldOfViewDisplay(bool updateDancingTerrain, bool refreshDisplay) {
			Movement.GetInstance ().updateFieldOfViewDisplay ( updateDancingTerrain ,refreshDisplay );
		}


		void strcpy( char[] dst, string src ) {

			commonFunc.strcpy ( dst , src );
		}

		void strcpy( char[] dst, char[] array_src ) {
			commonFunc.strcpy ( dst , array_src );
		}
		
	}
}

