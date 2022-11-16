using System;

/* comments , print only 
typedef struct monsterClass {
    char name[30];
    short frequency;
    short maxDepth;
    enum monsterTypes memberList[15];
}
*/

namespace rogueSharp 
{ 
	public class monsterClass { 

		public readonly string name  ; // = new char [30];
		public short frequency ;
		public short maxDepth ;
		public readonly monsterTypes [] memberList  = new monsterTypes [15];

		public monsterClass( string _name="", short _frequency =0, short _maxDepth=0 , 
			monsterTypes [] _memberList = null  // will warn if it is null
		) { 
			name = _name;
			frequency = _frequency;
			maxDepth = _maxDepth;

			memberList = _memberList;
			if (memberList == null) {
				Debug.LogError( "monsterClass memberList not initialized :"  + name );
			}

		} // constructure  
	} // class 
} // namespace 
