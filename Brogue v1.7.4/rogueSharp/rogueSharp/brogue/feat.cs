using System;

/* comments , print only 
typedef struct feat {
	char name[100];
    char description[200];
    boolean initialValue;
}
*/

namespace rogueSharp 
{ 
	public class feat { 

		public readonly string name   ; // = new char [100];
		public readonly string description ; // = new char [200];
		public bool initialValue ;

		public feat( string _name = "" , string _description = "" , bool _initialValue = false  ) { 
			name = _name;
			description = _description;
			initialValue = _initialValue;
		} // constructure  
	} // class 
} // namespace 
