using System;

/* comments , print only 
typedef struct tcell {			// transient cell; stuff we don't need to remember between levels
	short light[3];				// RGB components of lighting
	short oldLight[3];			// compare with subsequent lighting to determine whether to refresh cell
}
*/

namespace rogueSharp 
{ 
	public class tcell { 

		public readonly short [] light  = new short [3];
		public readonly short [] oldLight  = new short [3];

		public tcell() { 

		} // constructure  
	} // class 
} // namespace 