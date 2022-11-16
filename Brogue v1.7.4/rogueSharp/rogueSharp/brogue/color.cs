using System;


/* comments , print only 
typedef struct color {
	// base RGB components:
	short red;
	short green;
	short blue;
	
	// random RGB components to add to base components:
	short redRand;
	short greenRand;
	short blueRand;
	
	// random scalar to add to all components:
	short rand;
	
	// Flag: this color "dances" with every refresh:
	boolean colorDances;
}
*/

namespace rogueSharp 
{ 
	[Serializable] 
	public class color { 

		public short red ;
		public short green ;
		public short blue ;
		public short redRand ;
		public short greenRand ;
		public short blueRand ;
		public short rand ;
		public bool colorDances ;

		public color( short _red = 0 , short _green = 0, short _blue = 0 , 
			short _redRand = 0, short _greenRand = 0, short _blueRand = 0, 
			short _rand = 0, bool _colorDances = false 
		) { 
			red 		= _red ;
			green		= _green ;
			blue 		= _blue ;
			redRand 	= _redRand ;
			greenRand	= _greenRand ;
			blueRand	= _blueRand ;
			rand		= _rand ;
			colorDances	= _colorDances ;
		} // constructure  
	} // class 
} // namespace 

