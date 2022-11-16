using System;

/* comments , print only 
// keeps track of graphics so we only redraw if the cell has changed:
typedef struct cellDisplayBuffer {
	uchar character;
	char foreColorComponents[3];
	char backColorComponents[3];
	char opacity;
	boolean needsUpdate;
}
*/

namespace rogueSharp 
{ 
	public class cellDisplayBuffer { 

		public ushort character ;
		public readonly char [] foreColorComponents  = new char [3];
		public readonly char [] backColorComponents  = new char [3];
		public char opacity ;
		public bool needsUpdate ;

		public cellDisplayBuffer() { 

		} // constructure  
	} // class 
} // namespace 
