using System;

/* comments , print only 
// Terrain types:
typedef struct floorTileType {
	// appearance:
	uchar displayChar;
	const color *foreColor;
	const color *backColor;
	short drawPriority;                     // priority (lower number means higher priority); governs drawing as well as tile replacement comparisons.
	char chanceToIgnite;					// chance to burn if a flame terrain is on one of the four cardinal neighbors
	enum dungeonFeatureTypes fireType;		// spawn this DF when the terrain ignites (or, if it's T_IS_DF_TRAP, when the pressure plate clicks)
	enum dungeonFeatureTypes discoverType;	// spawn this DF when successfully searched if T_IS_SECRET is set
	enum dungeonFeatureTypes promoteType;	// creates this dungeon spawn type when it promotes for some other reason (random promotion or promotion through machine activation)
	short promoteChance;					// percent chance per turn to spawn the promotion type; will also vanish upon doing so if T_VANISHES_UPON_PROMOTION is set
	short glowLight;						// if it glows, this is the ID of the light type
	unsigned long flags;
    unsigned long mechFlags;
	char description[COLS];
	char flavorText[COLS];
}
*/

namespace rogueSharp 
{ 
	public class floorTileType { 
		const int COLS = RogueH.COLS; 

		public ushort displayChar ;
		public color foreColor ;
		public color backColor ;
		public short drawPriority ;
		public int chanceToIgnite ;
		public dungeonFeatureTypes fireType ;
		public dungeonFeatureTypes discoverType ;
		public dungeonFeatureTypes promoteType ;
		public short promoteChance ;
		public short glowLight ;
		public ulong flags ;
		public ulong mechFlags ;
		public readonly string description = "" ; //  = new char [COLS];
		public readonly string flavorText = "" ;  // = new char [COLS];

		public floorTileType(
			ushort _displayChar = 0 ,
			color _foreColor = null,
			color _backColor = null,
			short _drawPriority =0,
			int _chanceToIgnite =0,
			dungeonFeatureTypes _fireType = (dungeonFeatureTypes)0,
			dungeonFeatureTypes _discoverType = (dungeonFeatureTypes)0,
			dungeonFeatureTypes _promoteType = (dungeonFeatureTypes)0 ,
			short _promoteChance = 0,
			lightType _glowLight = lightType.NO_LIGHT ,
			ulong _flags =0,
			ulong _mechFlags =0,
			string _description = "" , //  = new char [COLS];
			string _flavorText = "" 
		) { 

			displayChar = _displayChar ;
			foreColor = _foreColor ;
			backColor = _backColor ;
			drawPriority = _drawPriority ;
			chanceToIgnite = _chanceToIgnite ;
			fireType = _fireType ;
			discoverType = _discoverType ;
			promoteType = _promoteType ;
			promoteChance = _promoteChance ;
			glowLight = (short)_glowLight ;
			flags = _flags ;
			mechFlags = _mechFlags ;
			if(_description != null)
				description = _description ;
			if(_flavorText!=null)
				flavorText = _flavorText ;


		} // constructure  

		public floorTileType (
			ushort _displayChar = 0,
			color _foreColor = null,
			int _backColor = 0,
			short _drawPriority = 0,
			int _chanceToIgnite = 0,
			dungeonFeatureTypes _fireType = (dungeonFeatureTypes)0,
			dungeonFeatureTypes _discoverType = (dungeonFeatureTypes)0,
			dungeonFeatureTypes _promoteType = (dungeonFeatureTypes)0,
			short _promoteChance = 0,
			lightType _glowLight = lightType.NO_LIGHT,
			ulong _flags = 0,
			ulong _mechFlags = 0,
			string _description = "", //  = new char [COLS];
			string _flavorText = "" 
		) : this (  
			_displayChar ,
			_foreColor  ,
			null  ,
			_drawPriority  ,
			_chanceToIgnite ,
			_fireType ,
			_discoverType ,
			_promoteType ,
			_promoteChance  ,
			_glowLight ,
			_flags ,
			_mechFlags ,
			_description , //  = new char [COLS];
			_flavorText 
		
		) 
		{   } // constructure  

		public floorTileType (
			ushort _displayChar = 0,
			int _foreColor = 0 ,
			color _backColor = null,
			short _drawPriority = 0,
			int _chanceToIgnite = 0,
			dungeonFeatureTypes _fireType = (dungeonFeatureTypes)0,
			dungeonFeatureTypes _discoverType = (dungeonFeatureTypes)0,
			dungeonFeatureTypes _promoteType = (dungeonFeatureTypes)0,
			short _promoteChance = 0,
			lightType _glowLight = lightType.NO_LIGHT,
			ulong _flags = 0,
			ulong _mechFlags = 0,
			string _description = "", //  = new char [COLS];
			string _flavorText = "" 
		) : this (  
			_displayChar ,
			null  ,
			_backColor  ,
			_drawPriority  ,
			_chanceToIgnite ,
			_fireType ,
			_discoverType ,
			_promoteType ,
			_promoteChance  ,
			_glowLight ,
			_flags ,
			_mechFlags ,
			_description , //  = new char [COLS];
			_flavorText 

		) 
		{   } // constructure  

		public floorTileType (
			ushort _displayChar = 0,
			int _foreColor = 0 ,
			int _backColor = 0,
			short _drawPriority = 0,
			int _chanceToIgnite = 0,
			dungeonFeatureTypes _fireType = (dungeonFeatureTypes)0,
			dungeonFeatureTypes _discoverType = (dungeonFeatureTypes)0,
			dungeonFeatureTypes _promoteType = (dungeonFeatureTypes)0,
			short _promoteChance = 0,
			lightType _glowLight = lightType.NO_LIGHT,
			ulong _flags = 0,
			ulong _mechFlags = 0,
			string _description = "", //  = new char [COLS];
			string _flavorText = "" 
		) : this (  
			_displayChar ,
			null  ,
			null  ,
			_drawPriority  ,
			_chanceToIgnite ,
			_fireType ,
			_discoverType ,
			_promoteType ,
			_promoteChance  ,
			_glowLight ,
			_flags ,
			_mechFlags ,
			_description , //  = new char [COLS];
			_flavorText 

		) 
		{   } // constructure  
	} // class 
} // namespace 