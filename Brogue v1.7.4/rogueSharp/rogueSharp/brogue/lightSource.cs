using System;

/* comments , print only 
typedef struct lightSource {
	const color *lightColor;
	randomRange lightRadius;
	short radialFadeToPercent;
	boolean passThroughCreatures; // generally no, but miner light does
}
*/

namespace rogueSharp 
{ 
	[Serializable] 
	public class lightSource { 

		public color lightColor ;
		private randomRange __lightRadius__  = new randomRange () ;
		public randomRange lightRadius {
			get { return __lightRadius__; } 
			set { if (value != null)
					ObjectCopier.CopyFrom<randomRange> (__lightRadius__, value);}     
		}
		public short radialFadeToPercent ;
		public bool passThroughCreatures ;

		public lightSource( 
			color _lightColor = null ,  
			randomRange _lightRadius = null , //  do nothing if null
			short _radialFadeToPercent = 0 , 
			bool _passThroughCreatures = false 
			) 
		{ 
			lightColor = _lightColor;
			if (lightColor == null)
				lightColor = Global.black;
			lightRadius = _lightRadius;
			radialFadeToPercent = _radialFadeToPercent;
			passThroughCreatures = _passThroughCreatures;
		} // constructure  
	} // class 
} // namespace 
