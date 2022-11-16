using System;

/* comments , print only 
typedef struct itemTable {
	char *name;
	char *flavor;
	char callTitle[30];
	short frequency;
	short marketValue;
	short strengthRequired;
	randomRange range;
	boolean identified;
	boolean called;
	char description[1500];
}
*/

namespace rogueSharp 
{ 
	public class itemTable { 

		public string name ;
		public char[] flavor ;
		public string callTitle; // = new char [30];
		public short frequency ;
		public short marketValue ;
		public short strengthRequired ;
		private randomRange __range__  = new randomRange () ;
		public randomRange range {
			get { return __range__; } 
			set { if(value!=null) ObjectCopier.CopyFrom<randomRange>(  __range__ , value  )  ;   }  
		}

		public bool identified ;
		public bool called ;
		public readonly string description; //= new char [1500];

		public itemTable( 
			string _name = ""  ,
			char[] _flavor  = null , // will warn if it is null
			string _callTitle = "" ,
			short _frequency = 0,
			short _marketValue = 0,
			short _strengthRequired = 0 ,
			randomRange _range = null , // do nothing if null
			bool _identified = false ,
			bool _called = false ,
			string _description = ""

		) { 
			name = _name;
			flavor = _flavor ;
			if (flavor == null) {
				Debug.LogError( "item flavor not initialized :"  + name );
			}
			callTitle = _callTitle;
			frequency = _frequency;
			marketValue = _marketValue;
			strengthRequired = _strengthRequired;
			range = _range;
			identified = _identified;
			called = _called;
			description = _description;

		} // constructure  

		public itemTable( 
			string _name = ""  ,
			string _str_flavor  = null , // will warn if it is null
			string _callTitle = "" ,
			short _frequency = 0,
			short _marketValue = 0,
			short _strengthRequired = 0 ,
			randomRange _range = null , //  do nothing if null
			bool _identified = false ,
			bool _called = false ,
			string _description = ""

		) : this ( _name, 
			_str_flavor != null ? _str_flavor.ToCharArray() : null ,
			_callTitle , _frequency ,_marketValue , 
			_strengthRequired  ,
			_range , _identified , _called , _description
		
		) { 
			

		} // constructure  
	} // class 
} // namespace 

