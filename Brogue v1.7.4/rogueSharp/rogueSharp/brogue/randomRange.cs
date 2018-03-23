using System;

/* comments , print only 
typedef struct randomRange {
	short lowerBound;
	short upperBound;
	short clumpFactor;
}
*/

namespace rogueSharp 
{ 
	[Serializable] 
	public class randomRange { 

		public short lowerBound ;
		public short upperBound ;
		public short clumpFactor ;

		public randomRange( short _lowerBound = 0 ,  short _upperBound = 0 , short _clumpFactor =  0) { 
			lowerBound = _lowerBound;
			upperBound = _upperBound;
			clumpFactor = _clumpFactor;
		} // constructure  
	} // class 
} // namespace 

