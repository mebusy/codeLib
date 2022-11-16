using System;

/* comments , print only 
// Defines all creatures, which include monsters and the player:
typedef struct creatureType {
	enum monsterTypes monsterID; // index number for the monsterCatalog
	char monsterName[COLS];
	uchar displayChar;
	const color *foreColor;
	short maxHP;
	short defense;
	short accuracy;
	randomRange damage;
	long turnsBetweenRegen;		// turns to wait before regaining 1 HP
	short movementSpeed;
	short attackSpeed;
	enum dungeonFeatureTypes bloodType;
	enum lightType intrinsicLightType;
	short DFChance;						// percent chance to spawn the dungeon feature per awake turn
	enum dungeonFeatureTypes DFType;	// kind of dungeon feature
    enum boltType bolts[20];
	unsigned long flags;
	unsigned long abilityFlags;
}
*/

namespace rogueSharp 
{ 
	[Serializable] 
	public class creatureType { 
		const int COLS = RogueH.COLS; 

		public monsterTypes monsterID ;
		public string monsterName  ;
		public char displayChar ;
		public color foreColor ;
		public short maxHP ;
		public short defense ;
		public short accuracy ;
		private randomRange __damage__  = new randomRange () ;
		public randomRange damage {
			get { return __damage__; } 
			set { if(value!=null) ObjectCopier.CopyFrom<randomRange>(  __damage__ , value  )  ;   }
		}


		public long turnsBetweenRegen ;
		public short movementSpeed ;
		public short attackSpeed ;
		public dungeonFeatureTypes bloodType ;
		public lightType intrinsicLightType ;
		public short DFChance ;
		public dungeonFeatureTypes DFType ;
		public boltType [] bolts   ;
		public ulong flags ;
		public ulong abilityFlags ;


		public creatureType( 
			monsterTypes nMonsterID=monsterTypes.MK_YOU , 
			string _monsterName="" , char _displayChar=' ' , 
			color _foreColor = null , // will warn if null
			short _maxHP = 0 , short _defense = 0, short _accuracy = 0 ,
			randomRange _damage  = null , // do nothing if null
			long _turnsBetweenRegen =0,
			short _movementSpeed =0,
			short _attackSpeed =0,
			dungeonFeatureTypes _bloodType = (dungeonFeatureTypes)0 ,
			lightType _intrinsicLightType = lightType.NO_LIGHT ,
			short _DFChance = 0  ,
			dungeonFeatureTypes _DFType = (dungeonFeatureTypes)0 ,
			boltType [] _bolts = null ,   // it's ok, maybe
			ulong _flags = 0 ,
			ulong _abilityFlags = 0

		) { 
			monsterID = (monsterTypes)nMonsterID;
			monsterName = _monsterName;
			displayChar = _displayChar;
			foreColor = _foreColor; 
			if (foreColor == null) {
				foreColor = Global.black;
				Debug.LogError( "monster color not initialized : " + nMonsterID );
			}
			maxHP = _maxHP;
			defense = _defense;
			accuracy = _accuracy;
			damage = _damage;
			turnsBetweenRegen = _turnsBetweenRegen;
			movementSpeed = _movementSpeed;
			attackSpeed = _attackSpeed;
			
			bloodType = _bloodType;
			intrinsicLightType = _intrinsicLightType;
			DFChance = _DFChance;
			DFType = _DFType;

			bolts = _bolts;
			if (bolts == null)
				bolts = new boltType [20];
				
			flags = _flags;
			abilityFlags = _abilityFlags;

		} // constructure  


	} // class 
} // namespace 


//  creatureType;
