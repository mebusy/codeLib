using System;
using System.Text ;


namespace rogueSharp
{
	public class commonFunc :Singleton<commonFunc>
	{
		
		private commonFunc ()
		{
		}

		public T[] initialize_1D_objectArray<T>( int nArrayLen ) where T: new()
		{
			T[] t = new T[ nArrayLen ];
			for (int i = 0; i < nArrayLen; i++) {
				t [i] = new T();
			}
			return t ;
		}

		public static void zeroOut_1D_array<T> ( T[] array )  {
			for (int i = 0; i < array.Length; i++) {
				array [i] = default(T) ; // (T)Convert.ChangeType(0, typeof(T));  ;
			}
		}

		public static string charArray2String( char[] array ) {
			return new string(array).Replace("\0", string.Empty); ;
		}

		public static void strcpy( char[] dst, string src ) {

			char[] array_src = src.ToCharArray ();
			int n = Math.Min ( dst.Length ,array_src.Length  );

			Array.Copy (array_src, dst, n);

			// clean tail
			for (int i = n ; i < dst.Length; i++) {
				dst [i] = (char)0;
			}

		}

		public static  void strcpy( char[] dst, char[] array_src ) {

			int n = Math.Min ( dst.Length ,array_src.Length  );

			Array.Copy (array_src, dst, n);

			// clean tail
			for (int i = n ; i < dst.Length; i++) {
				dst [i] = (char)0;
			}

		}

		public static short strlen( char[] array ) {

			short len = 0 ;
			for (int i = 0; i < array.Length; i++) {
				if (array [i] == 0)
					break;
				
				len++; 
			}

			return len;
		}

		public static char[] strcat( char[] dst , char[] src ) {

			int nDstStart = strlen(dst);
			int nStrDstMax = dst.Length;
			int nStrLenSrc = strlen(src);

			for (int i = 0; i < nStrLenSrc; i++) {
				if (i + nDstStart >= nStrDstMax)
					break; 
				dst[i + nDstStart ] = src [i];
			}
				
			return dst;
		}
		public static char[] strcat( char[] dst , string strSrc ) {
			char[] src = strSrc.ToCharArray();

			int nDstStart = strlen(dst);
			int nStrDstMax = dst.Length;
			int nStrLenSrc = strlen(src);

			for (int i = 0; i < nStrLenSrc; i++) {
				if (i + nDstStart >= nStrDstMax)
					break; 
				dst[i + nDstStart ] = src [i];
			}

			return dst;
		}

		private static char[] __ca__ = new char[1]  ;
		public static void sprintf( char[] buf, string fmt , __arglist ) {
			// clear
			for (int i = 0 ; i < buf.Length; i++) {
				buf [i] = (char)0;
			}

			string[] fmt_items = fmt.Split ( '}' );



			int fmt_index = 0;

			StringBuilder sb = new StringBuilder ();
			//*
			ArgIterator args = new ArgIterator(__arglist);

			string fmt_tail = "";
			while (args.GetRemainingCount() > 0)
			{
				if (fmt_index >= fmt_items.Length) {
					break;
				}

				TypedReference tr = args.GetNextArg();
				Object o = TypedReference.ToObject (tr);

				if( fmt_index == fmt_items.Length - 2 ) {
					fmt_tail= fmt_items[fmt_items.Length - 1];
				}

				if ( o.GetType().Equals( __ca__.GetType() ) ) {
					sb.AppendFormat( fmt_items[fmt_index] + "}"+fmt_tail , commonFunc.charArray2String( (char[])(o) ) );
				} else {
					sb.AppendFormat( fmt_items[fmt_index] + "}"+fmt_tail  , o  );
				}
				fmt_index++;
			}

			//*/
			string text =  sb.ToString()  ;
			strcpy ( buf , text  );
			// Debug.Log( new string(buf) );
		}

	}
}

