using System;


/* comments , print only 
// Dungeon features, spawned from Architect.c:
typedef struct dungeonFeature {
	// tile info:
	enum tileType tile;
	enum dungeonLayers layer;
	
	// spawning pattern:
	short startProbability;
	short probabilityDecrement;
	unsigned long flags;
	char description[DCOLS];
    enum lightType lightFlare;
	const color *flashColor;
	short effectRadius;
	enum tileType propagationTerrain;
	enum dungeonFeatureTypes subsequentDF;
	boolean messageDisplayed;
}
*/

namespace rogueSharp 
{ 
	public class dungeonFeature { 
		const int DCOLS = RogueH.DCOLS; 

		public tileType tile ;
		public dungeonLayers layer ;
		public short startProbability ;
		public short probabilityDecrement ;
		public ulong flags ;
		public string description ;
		public lightType lightFlare ;
		public color flashColor ;
		public short effectRadius ;
		public tileType propagationTerrain ;
		public dungeonFeatureTypes subsequentDF ;
		public bool messageDisplayed ;

		public dungeonFeature( 
			tileType _tile = tileType.NOTHING ,
			dungeonLayers _layer = dungeonLayers.NO_LAYER, 
			short _startProbability = 0 ,
			short _probabilityDecrement = 0 , 
			ulong _flags = 0 , 
			string _description = "" ,
			lightType _lightFlare = lightType.NO_LIGHT ,
			color _flashColor = null ,  // its ok
			short _effectRadius = 0 , 
			tileType _propagationTerrain = tileType.NOTHING ,
			dungeonFeatureTypes _subsequentDF = (dungeonFeatureTypes)0, // ?? 
			bool _messageDisplayed = false 
		) { 
			tile = _tile ;
			layer = _layer ;
			startProbability = _startProbability;
			probabilityDecrement = _probabilityDecrement;
			flags = _flags;
			description = _description;

			lightFlare = _lightFlare ;
			flashColor = _flashColor;
			if(flashColor==null) {
				flashColor = Global.black;
				//Debug.LogError( "dungeonFeature flashColor not initialized :"  + tile );
			}


			effectRadius = _effectRadius;
			propagationTerrain = _propagationTerrain ;
			subsequentDF = _subsequentDF;
			messageDisplayed = _messageDisplayed ;
		} // constructure  

		 

	} // class 
} // namespace 



