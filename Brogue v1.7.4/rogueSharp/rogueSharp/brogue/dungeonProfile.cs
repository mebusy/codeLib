using System;

/* comments , print only 
// Level profiles, affecting what rooms get chosen and how they're connected:
typedef struct dungeonProfile {
    // Room type weights (in the natural dungeon, these are also adjusted based on depth):
    short roomFrequencies[ROOM_TYPE_COUNT];
    
    short corridorChance;
}
*/

namespace rogueSharp 
{ 
	public class dungeonProfile { 
		const int ROOM_TYPE_COUNT = RogueH.ROOM_TYPE_COUNT; 

		public readonly short []  roomFrequencies  = new short [ROOM_TYPE_COUNT];
		public short corridorChance ;

		public dungeonProfile( short [] _roomFrequencies = null , short _corridorChance = 0 ) { 
			if(_roomFrequencies!=null)
				Array.Copy ( _roomFrequencies , roomFrequencies , _roomFrequencies.Length );
			corridorChance = _corridorChance ;
		} // constructure  
	} // class 
} // namespace 