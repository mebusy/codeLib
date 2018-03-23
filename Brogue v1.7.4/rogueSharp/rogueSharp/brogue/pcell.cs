using System;

/* comments , print only 

typedef struct pcell {								// permanent cell; have to remember this stuff to save levels
	enum tileType layers[NUMBER_TERRAIN_LAYERS];	// terrain
	unsigned long flags;							// non-terrain cell flags
	unsigned short volume;							// quantity of gas in cell
	unsigned char machineNumber;
	cellDisplayBuffer rememberedAppearance;			// how the player remembers the cell to look
	enum itemCategory rememberedItemCategory;		// what category of item the player remembers lying there
	short rememberedItemKind;                       // what kind of item the player remembers lying there
    short rememberedItemQuantity;                   // how many of the item the player remembers lying there
	enum tileType rememberedTerrain;				// what the player remembers as the terrain (i.e. highest priority terrain upon last seeing)
    unsigned long rememberedCellFlags;              // map cell flags the player remembers from that spot
    unsigned long rememberedTerrainFlags;           // terrain flags the player remembers from that spot
    unsigned long rememberedTMFlags;                // TM flags the player remembers from that spot    
}
*/

namespace rogueSharp 
{ 
	public class pcell { 
		const int NUMBER_TERRAIN_LAYERS = RogueH.NUMBER_TERRAIN_LAYERS; 

		public readonly tileType [] layers  = new tileType [NUMBER_TERRAIN_LAYERS];
		public ulong flags ;
		public ushort volume ;
		public byte machineNumber ;
		private readonly cellDisplayBuffer __rememberedAppearance__  = new cellDisplayBuffer () ;
		public cellDisplayBuffer rememberedAppearance {
			get { return __rememberedAppearance__; } 
			set { if (value != null)
				ObjectCopier.CopyFrom<cellDisplayBuffer> (__rememberedAppearance__, value);}     
		}

		public itemCategory rememberedItemCategory ;
		public short rememberedItemKind ;
		public short rememberedItemQuantity ;
		public tileType rememberedTerrain ;
		public ulong rememberedCellFlags ;
		public ulong rememberedTerrainFlags ;
		public ulong rememberedTMFlags ;

		public pcell() { 

		} // constructure  
	} // class 
} // namespace 

