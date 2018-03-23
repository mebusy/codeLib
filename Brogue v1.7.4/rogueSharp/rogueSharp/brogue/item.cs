using System;

/* comments , print only 

typedef struct item {
	unsigned short category;
	short kind;
	unsigned long flags;
	randomRange damage;
	short armor;
	short charges;
	short enchant1;
	short enchant2;
    short timesEnchanted;
	enum monsterTypes vorpalEnemy;
	short strengthRequired;
	unsigned short quiverNumber;
	uchar displayChar;
	color *foreColor;
	color *inventoryColor;
	short quantity;
	char inventoryLetter;
	char inscription[DCOLS];
	short xLoc;
	short yLoc;
	keyLocationProfile keyLoc[KEY_ID_MAXIMUM];
	short originDepth;
	struct item *nextItem;
}
*/

namespace rogueSharp 
{ 
	public class item { 
		const int DCOLS = RogueH.DCOLS; 
		const int KEY_ID_MAXIMUM = RogueH.KEY_ID_MAXIMUM; 

		public ushort category ;
		public short kind ;
		public ulong flags ;
		private readonly randomRange __damage__  = new randomRange () ;
		public randomRange damage {
			get { return __damage__; } 
			set { if (value != null)
				ObjectCopier.CopyFrom<randomRange> (__damage__, value);}     
		}


		public short armor ;
		public short charges ;
		public short enchant1 ;
		public short enchant2 ;
		public short timesEnchanted ;
		public monsterTypes vorpalEnemy ;
		public short strengthRequired ;
		public ushort quiverNumber ;
		public ushort displayChar ;
		public color foreColor ;
		public color inventoryColor ;
		public short quantity ;
		public char inventoryLetter ;
		public readonly char [] inscription  = new char [DCOLS];
		public short xLoc ;
		public short yLoc ;
		public readonly keyLocationProfile [] keyLoc  = new keyLocationProfile [KEY_ID_MAXIMUM];
		public short originDepth ;
		public item nextItem ;

		public item() { 
			for (int i = 0; i < KEY_ID_MAXIMUM; i++) { 
				keyLoc [i]= new keyLocationProfile() ; 
			} 

		} // constructure  
	} // class 
} // namespace 


//  item;
