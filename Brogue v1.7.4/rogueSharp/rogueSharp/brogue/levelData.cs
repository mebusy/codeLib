using System;

/* comments , print only 
// Stores the necessary info about a level so it can be regenerated:
typedef struct levelData {
	boolean visited;
	pcell mapStorage[DCOLS][DROWS];
	struct item *items;
	struct creature *monsters;
	struct creature *dormantMonsters;
    short **scentMap;
	unsigned long levelSeed;
	short upStairsLoc[2];
	short downStairsLoc[2];
	short playerExitedVia[2];
	unsigned long awaySince;
}
*/

namespace rogueSharp 
{ 
	public class levelData { 
		const int DCOLS = RogueH.DCOLS; 
		const int DROWS = RogueH.DROWS; 

		public bool visited ;
		public readonly pcell [,] mapStorage  = new pcell [DCOLS,DROWS];
		public item items ;
		public creature monsters ;
		public creature dormantMonsters ;
		public short [][] scentMap ;
		public ulong levelSeed ;
		public readonly short [] upStairsLoc  = new short [2];
		public readonly short [] downStairsLoc  = new short [2];
		public readonly short [] playerExitedVia  = new short [2];
		public ulong awaySince ;

		public levelData() { 
			for (int i = 0; i < DCOLS; i++) { 
				for (int j = 0; j < DROWS; j++) { 
					mapStorage [i,j]= new pcell() ; 
				} 
			} 

		} // constructure  
	} // class 
} // namespace 