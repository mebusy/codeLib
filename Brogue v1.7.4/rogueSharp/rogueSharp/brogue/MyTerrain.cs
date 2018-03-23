using System;

namespace rogueSharp
{

	public enum terrainFlagCatalog {
		T_OBSTRUCTS_PASSABILITY         = (1<<(0)),        // cannot be walked through
		T_OBSTRUCTS_VISION              = (1<<(1)),        // blocks line of sight
		T_OBSTRUCTS_ITEMS               = (1<<(2)),        // items can't be on this tile
		T_OBSTRUCTS_SURFACE_EFFECTS     = (1<<(3)),        // grass, blood, etc. cannot exist on this tile
		T_OBSTRUCTS_GAS                 = (1<<(4)),        // blocks the permeation of gas
		T_OBSTRUCTS_DIAGONAL_MOVEMENT   = (1<<(5)),        // can't step diagonally around this tile
		T_SPONTANEOUSLY_IGNITES         = (1<<(6)),        // monsters avoid unless chasing player or immune to fire
		T_AUTO_DESCENT                  = (1<<(7)),        // automatically drops creatures down a depth level and does some damage (2d6)
		T_LAVA_INSTA_DEATH              = (1<<(8)),        // kills any non-levitating non-fire-immune creature instantly
		T_CAUSES_POISON                 = (1<<(9)),        // any non-levitating creature gets 10 poison
		T_IS_FLAMMABLE                  = (1<<(10)),       // terrain can catch fire
		T_IS_FIRE                       = (1<<(11)),       // terrain is a type of fire; ignites neighboring flammable cells
		T_ENTANGLES                     = (1<<(12)),       // entangles players and monsters like a spiderweb
		T_IS_DEEP_WATER                 = (1<<(13)),       // steals items 50% of the time and moves them around randomly
		T_CAUSES_DAMAGE                 = (1<<(14)),       // anything on the tile takes max(1-2, 10%) damage per turn
		T_CAUSES_NAUSEA                 = (1<<(15)),       // any creature on the tile becomes nauseous
		T_CAUSES_PARALYSIS              = (1<<(16)),       // anything caught on this tile is paralyzed
		T_CAUSES_CONFUSION              = (1<<(17)),       // causes creatures on this tile to become confused
		T_CAUSES_HEALING                = (1<<(18)),       // heals 20% max HP per turn for any player or non-inanimate monsters
		T_IS_DF_TRAP                    = (1<<(19)),       // spews gas of type specified in fireType when stepped on
		T_CAUSES_EXPLOSIVE_DAMAGE       = (1<<(20)),       // is an explosion; deals higher of 15-20 or 50% damage instantly, but not again for five turns
		T_SACRED                        = (1<<(21)),       // monsters that aren't allies of the player will avoid stepping here

		T_OBSTRUCTS_SCENT               = (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_VISION | T_AUTO_DESCENT | T_LAVA_INSTA_DEATH | T_IS_DEEP_WATER | T_SPONTANEOUSLY_IGNITES),
		T_PATHING_BLOCKER               = (T_OBSTRUCTS_PASSABILITY | T_AUTO_DESCENT | T_IS_DF_TRAP | T_LAVA_INSTA_DEATH | T_IS_DEEP_WATER | T_IS_FIRE | T_SPONTANEOUSLY_IGNITES),
		T_DIVIDES_LEVEL                 = (T_OBSTRUCTS_PASSABILITY | T_AUTO_DESCENT | T_IS_DF_TRAP | T_LAVA_INSTA_DEATH | T_IS_DEEP_WATER),
		T_LAKE_PATHING_BLOCKER          = (T_AUTO_DESCENT | T_LAVA_INSTA_DEATH | T_IS_DEEP_WATER | T_SPONTANEOUSLY_IGNITES),
		T_WAYPOINT_BLOCKER              = (T_OBSTRUCTS_PASSABILITY | T_AUTO_DESCENT | T_IS_DF_TRAP | T_LAVA_INSTA_DEATH | T_IS_DEEP_WATER | T_SPONTANEOUSLY_IGNITES),
		T_MOVES_ITEMS                   = (T_IS_DEEP_WATER | T_LAVA_INSTA_DEATH),
		T_CAN_BE_BRIDGED                = (T_AUTO_DESCENT),
		T_OBSTRUCTS_EVERYTHING          = (T_OBSTRUCTS_PASSABILITY | T_OBSTRUCTS_VISION | T_OBSTRUCTS_ITEMS | T_OBSTRUCTS_GAS | T_OBSTRUCTS_SURFACE_EFFECTS | T_OBSTRUCTS_DIAGONAL_MOVEMENT),
		T_HARMFUL_TERRAIN               = (T_CAUSES_POISON | T_IS_FIRE | T_CAUSES_DAMAGE | T_CAUSES_PARALYSIS | T_CAUSES_CONFUSION | T_CAUSES_EXPLOSIVE_DAMAGE),
		T_RESPIRATION_IMMUNITIES        = (T_CAUSES_DAMAGE | T_CAUSES_CONFUSION | T_CAUSES_PARALYSIS | T_CAUSES_NAUSEA),
	};

	public enum terrainMechanicalFlagCatalog {
		TM_IS_SECRET                    = (1<<(0)),        // successful search or being stepped on while visible transforms it into discoverType
		TM_PROMOTES_WITH_KEY            = (1<<(1)),        // promotes if the key is present on the tile (in your pack, carried by monster, or lying on the ground)
		TM_PROMOTES_WITHOUT_KEY         = (1<<(2)),        // promotes if the key is NOT present on the tile (in your pack, carried by monster, or lying on the ground)
		TM_PROMOTES_ON_STEP             = (1<<(3)),        // promotes when a creature, player or item is on the tile (whether or not levitating)
		TM_PROMOTES_ON_ITEM_PICKUP      = (1<<(4)),        // promotes when an item is lifted from the tile (primarily for altars)
		TM_PROMOTES_ON_PLAYER_ENTRY     = (1<<(5)),        // promotes when the player enters the tile (whether or not levitating)
		TM_PROMOTES_ON_ELECTRICITY      = (1<<(6)),        // promotes when hit by a lightning bolt
		TM_ALLOWS_SUBMERGING            = (1<<(7)),        // allows submersible monsters to submerge in this terrain
		TM_IS_WIRED                     = (1<<(8)),        // if wired, promotes when powered, and sends power when promoting
		TM_IS_CIRCUIT_BREAKER           = (1<<(9)),        // prevents power from circulating in its machine
		TM_GAS_DISSIPATES               = (1<<(10)),       // does not just hang in the air forever
		TM_GAS_DISSIPATES_QUICKLY       = (1<<(11)),       // dissipates quickly
		TM_EXTINGUISHES_FIRE            = (1<<(12)),       // extinguishes burning terrain or creatures
		TM_VANISHES_UPON_PROMOTION      = (1<<(13)),       // vanishes when creating promotion dungeon feature, even if the replacement terrain priority doesn't require it
		TM_REFLECTS_BOLTS               = (1<<(14)),       // magic bolts reflect off of its surface randomly (similar to pmap flag IMPREGNABLE)
		TM_STAND_IN_TILE                = (1<<(15)),       // earthbound creatures will be said to stand "in" the tile, not on it
		TM_LIST_IN_SIDEBAR              = (1<<(16)),       // terrain will be listed in the sidebar with a description of the terrain type
		TM_VISUALLY_DISTINCT            = (1<<(17)),       // terrain will be color-adjusted if necessary so the character stands out from the background
		TM_BRIGHT_MEMORY                = (1<<(18)),       // no blue fade when this tile is out of sight
		TM_EXPLOSIVE_PROMOTE            = (1<<(19)),       // when burned, will promote to promoteType instead of burningType if surrounded by tiles with T_IS_FIRE or TM_EXPLOSIVE_PROMOTE
		TM_CONNECTS_LEVEL               = (1<<(20)),       // will be treated as passable for purposes of calculating level connectedness, irrespective of other aspects of this terrain layer
		TM_INTERRUPT_EXPLORATION_WHEN_SEEN = (1<<(21)),    // will generate a message when discovered during exploration to interrupt exploration
		TM_INVERT_WHEN_HIGHLIGHTED      = (1<<(22)),       // will flip fore and back colors when highlighted with pathing
		TM_SWAP_ENCHANTS_ACTIVATION     = (1<<(23)),       // in machine, swap item enchantments when two suitable items are on this terrain, and activate the machine when that happens
	};


	public class MyTerrain : Singleton<MyTerrain>
	{

		floorTileType[] tileCatalog = Global.GetInstance().tileCatalog ;

		tcell[,] tmap = Global.tmap ;						// grids with info about the map
		pcell[,] pmap = Global.pmap  ;

		public ulong terrainFlags( long x,  long y) 
		{
			return	tileCatalog[ (int)pmap[x,y].layers[(int)dungeonLayers.DUNGEON]].flags
				| tileCatalog[(int)pmap[x,y].layers[(int)dungeonLayers.LIQUID]].flags  
				| tileCatalog[(int)pmap[x,y].layers[(int)dungeonLayers.SURFACE]].flags  
				| tileCatalog[(int)pmap[x,y].layers[(int)dungeonLayers.GAS]].flags ;
		}


		public ulong terrainMechFlags( long x,  long y)	
		{ 
			return tileCatalog[(int)pmap[x,y].layers[(int)dungeonLayers.DUNGEON]].mechFlags 
				| tileCatalog[(int)pmap[x,y].layers[(int)dungeonLayers.LIQUID]].mechFlags  
				| tileCatalog[(int)pmap[x,y].layers[(int)dungeonLayers.SURFACE]].mechFlags  
				| tileCatalog[(int)pmap[x,y].layers[(int)dungeonLayers.GAS]].mechFlags ;
		}
	}
}

