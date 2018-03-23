using System;

/* comments , print only 
typedef struct flare {
    lightSource *light;                 // Flare light
    short coeffChangeAmount;            // The constant amount by which the coefficient changes per frame, e.g. -25 means it gets 25% dimmer per frame.
    short coeffLimit;                   // Flare ends if the coefficient passes this percentage (whether going up or down).
    short xLoc, yLoc;                   // Current flare location.
    long coeff;                         // Current flare coefficient; always starts at 100.
    unsigned long turnNumber;           // So we can eliminate those that fired one or more turns ago.
}
*/

namespace rogueSharp 
{ 
	public class flare { 

		public lightSource light ;
		public short coeffChangeAmount ;
		public short coeffLimit ;
		public short yLoc ;
		public long coeff ;
		public ulong turnNumber ;

		public flare() { 

		} // constructure  
	} // class 
} // namespace 
