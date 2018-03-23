using System;
using System.Text ;

namespace rogueSharp
{
	public class IO : Singleton<IO>
	{
		const int DCOLS = RogueH.DCOLS ;
		const int DROWS = RogueH.DROWS ;

		const int COLS = RogueH.COLS; 
		const int ROWS = RogueH.ROWS; 

		 // higher-level redraw
		public void displayLevel() {

			Debug.Log ( "TODO ~~~ displayLevel " ) ;
			/*
			short i, j;

			for( i=0; i<DCOLS; i++ ) {
				for( j=0; j<DROWS; j++ ) {
					refreshDungeonCell(i, j);
				}
			}
			//*/
		}

		public void bakeColor(color theColor) {
			short rand;
			rand = rand_range(0, theColor.rand);
			theColor.red += (short)(rand_range(0, theColor.redRand) + rand);
			theColor.green += (short)(rand_range(0, theColor.greenRand) + rand);
			theColor.blue += (short)(rand_range(0, theColor.blueRand) + rand);
			theColor.redRand = theColor.greenRand = theColor.blueRand = theColor.rand = 0;
		}


		// Inserts a four-character color escape sequence into a string at the insertion point.
		// Does NOT check string lengths, so it could theoretically write over the null terminator.
		// Returns the new insertion point.
		public short encodeMessageColor(char[] msg, short i, color theColor) {
			playerCharacter rogue = RogueMain.GetInstance().getRogue(); 

			bool needTerminator = false;
			color col = theColor;  // color col = *theColor;

			short oldRNG = rogue.RNG; rogue.RNG = (short)RNGs.RNG_COSMETIC;  //assureCosmeticRNG;

			bakeColor(col);

			col.red		= (short)Random.clamp(col.red, 0, 100);
			col.green	= (short)Random.clamp(col.green, 0, 100);
			col.blue	= (short)Random.clamp(col.blue, 0, 100);

			needTerminator = msg[i]==0 || msg[i + 1]==0 || msg[i + 2]==0 || msg[i + 3]==0;

			msg[i++] = (char)RogueH.COLOR_ESCAPE;
			msg[i++] = (char) (RogueH.COLOR_VALUE_INTERCEPT + col.red);
			msg[i++] = (char) (RogueH.COLOR_VALUE_INTERCEPT + col.green);
			msg[i++] = (char) (RogueH.COLOR_VALUE_INTERCEPT + col.blue);

			if (needTerminator) {
				msg[i] = '\0';
			}

			rogue.RNG = oldRNG; //restoreRNG;

			return i;
		}

		// Call this when the i'th character of msg is COLOR_ESCAPE.
		// It will return the encoded color, and will advance i past the color escape sequence.
		public static short decodeMessageColor( char[] msg, short i,  color returnColor) {

			if (msg[i] != (char)RogueH.COLOR_ESCAPE) {
				Debug.Log("Asked to decode a color escape that didn't exist!");
				ObjectCopier.CopyFrom<color>(  returnColor , Global.white  )  ;   //	 *returnColor = white;
			} else {
				i++;
				ObjectCopier.CopyFrom<color>(  returnColor , Global.black  )  ;  //*returnColor = black;
				returnColor.red	= (short) (msg[i++] - RogueH.COLOR_VALUE_INTERCEPT);
				returnColor.green	= (short) (msg[i++] - RogueH.COLOR_VALUE_INTERCEPT);
				returnColor.blue	= (short) (msg[i++] - RogueH.COLOR_VALUE_INTERCEPT);

				returnColor.red	= (short)Random.clamp(returnColor.red, 0, 100);
				returnColor.green	= (short)Random.clamp(returnColor.green, 0, 100);
				returnColor.blue	= (short)Random.clamp(returnColor.blue, 0, 100);
			}
			return i;
		}


		public static  ConsoleColor FromColor(  color c ) {

			int c_R = (c.red * 255 / 100);
			int c_G = (c.green * 255 / 100);
			int c_B = (c.blue * 255 / 100);

			int min = Math.Min (c_R, Math.Min(c_G, c_B));
			int max = Math.Max (c_R, Math.Min(c_G, c_B));

			if (max * 1.0 / min > 1.6) {
				if (c_R == min)
					c_R = 0;
				if (c_G == min)
					c_G = 0;
				if (c_B == min)
					c_B = 0;
			}

			int index = (c_R > 128 |c_G > 128 |c_B > 128) ? 8 : 0; // Bright bit
			index |= (c_R > 64) ? 4 : 0; // Red bit
			index |= (c_G > 64) ? 2 : 0; // Green bit
			index |= (c_B > 64) ? 1 : 0; // Blue bit
			return ( ConsoleColor)index;
		}

		static void consumeStringBuilder( StringBuilder sb ) {
			Console.Write ( "{0}" , sb.ToString() );
			sb.Clear ();
		}

		private static object _MessageLock= new object();
		public static void message( char[] text, bool requireAcknowledgment) {
			lock (_MessageLock) {
				// Implement the American quotation mark/period/comma ordering rule.
				/*
				for ( int i=0; text[i] != '\0' && text[i+1] != '\0'; i++) {
					if (text[i] == RogueH.COLOR_ESCAPE) {
						i += 4;
					} else if (text[i] == '"'
						&& (text[i+1] == '.' || text[i+1] == ',')) {

						text[i] = text[i+1];
						text[i+1] = '"';
					}
				}
				//*/

				StringBuilder sb = new StringBuilder ();
				color ret = new color ();
				for (short i = 0; i < text.Length && text [i] != '\0'   ; i++) {
					if (text [i] == RogueH.COLOR_ESCAPE) {
						consumeStringBuilder ( sb );
						i = decodeMessageColor (text, i, ret);
						Console.ForegroundColor = FromColor(ret);
					} 
					//else 
					{
						sb.Append ( text[i] );
					}
				}
				consumeStringBuilder ( sb );
				Debug.Log ("");

				//Debug.Log (commonFunc.charArray2String (text));
			}
		}
		public static void message( string msg, bool requireAcknowledgment) {


			message ( msg.ToCharArray() ,  requireAcknowledgment );
		}

		// Clears the message area and prints the given message in the area.
		// It will disappear when messages are refreshed and will not be archived.
		// This is primarily used to display prompts.
		public static void temporaryMessage(char[] msg, bool  requireAcknowledgment) {
			message ( msg , requireAcknowledgment );
		}
		public static void temporaryMessage(string msg, bool  requireAcknowledgment) {
			message ( msg , requireAcknowledgment );
		}

		public static void flavorMessage (string msg) {
			message ( msg ,  false );
		}


		public static void applyColorAverage(color baseColor, color newColor, short averageWeight) {
			short weightComplement = (short)(100 - averageWeight);
			baseColor.red = (short)((baseColor.red * weightComplement + newColor.red * averageWeight) / 100);
			baseColor.redRand = (short)((baseColor.redRand * weightComplement + newColor.redRand * averageWeight) / 100);
			baseColor.green = (short)((baseColor.green * weightComplement + newColor.green * averageWeight) / 100);
			baseColor.greenRand = (short)((baseColor.greenRand * weightComplement + newColor.greenRand * averageWeight) / 100);
			baseColor.blue = (short)((baseColor.blue * weightComplement + newColor.blue * averageWeight) / 100);
			baseColor.blueRand = (short)((baseColor.blueRand * weightComplement + newColor.blueRand * averageWeight) / 100);
			baseColor.rand = (short)((baseColor.rand * weightComplement + newColor.rand * averageWeight) / 100);
			baseColor.colorDances =  (baseColor.colorDances || newColor.colorDances);
			return;
		}


		public int mapToWindowX(int x)						
		{ 
			return ((x) + RogueH.STAT_BAR_WIDTH + 1) ;
		}

		public int mapToWindowY( int y)
		{
			return ((y) + RogueH.MESSAGE_LINES);
		}

		public int  windowToMapX(int x)
		{
			return ((x) - RogueH.STAT_BAR_WIDTH - 1);
		}

		public int windowToMapY(int y)						
		{
			return ((y) - RogueH.MESSAGE_LINES);
		}


		public void colorOverDungeon(  color color) {
			short i, j;

			for (i=0; i<DCOLS; i++) {
				for (j=0; j<DROWS; j++) {
					plotCharWithColor(' ', mapToWindowX(i), mapToWindowY(j), color, color);
				}
			}
		}

		public bool coordinatesAreInMap(int x, int y) 
		{
			return ((x) >= 0 && (x) < DCOLS	&& (y) >= 0 && (y) < DROWS);
		}
		public bool  coordinatesAreInWindow(int x, int y) 
		{
			return ((x) >= 0 && (x) < COLS && (y) >= 0 && (y) < ROWS);
		}

		// set displayBuffer
		public void plotCharWithColor( char inputChar, int xLoc, int yLoc,   color cellForeColor,  color cellBackColor) {
			Debug.Log ( " TODO : plotCharWithColor " );

			/*
			short oldRNG;

			short foreRed = cellForeColor->red,
			foreGreen = cellForeColor->green,
			foreBlue = cellForeColor->blue,

			backRed = cellBackColor->red,
			backGreen = cellBackColor->green,
			backBlue = cellBackColor->blue,

			foreRand, backRand;

			brogueAssert(coordinatesAreInWindow(xLoc, yLoc));

			if (rogue.gameHasEnded || rogue.playbackFastForward) {
				return;
			}

			//assureCosmeticRNG;
			oldRNG = rogue.RNG;
			rogue.RNG = RNG_COSMETIC;

			foreRand = rand_range(0, cellForeColor->rand);
			backRand = rand_range(0, cellBackColor->rand);
			foreRed += rand_range(0, cellForeColor->redRand) + foreRand;
			foreGreen += rand_range(0, cellForeColor->greenRand) + foreRand;
			foreBlue += rand_range(0, cellForeColor->blueRand) + foreRand;
			backRed += rand_range(0, cellBackColor->redRand) + backRand;
			backGreen += rand_range(0, cellBackColor->greenRand) + backRand;
			backBlue += rand_range(0, cellBackColor->blueRand) + backRand;

			foreRed =		min(100, max(0, foreRed));
			foreGreen =		min(100, max(0, foreGreen));
			foreBlue =		min(100, max(0, foreBlue));
			backRed =		min(100, max(0, backRed));
			backGreen =		min(100, max(0, backGreen));
			backBlue =		min(100, max(0, backBlue));

			if (inputChar != ' '
				&& foreRed		== backRed
				&& foreGreen	== backGreen
				&& foreBlue		== backBlue) {

				inputChar = ' ';
			}

			if (inputChar		!= displayBuffer[xLoc][yLoc].character
				|| foreRed		!= displayBuffer[xLoc][yLoc].foreColorComponents[0]
				|| foreGreen	!= displayBuffer[xLoc][yLoc].foreColorComponents[1]
				|| foreBlue		!= displayBuffer[xLoc][yLoc].foreColorComponents[2]
				|| backRed		!= displayBuffer[xLoc][yLoc].backColorComponents[0]
				|| backGreen	!= displayBuffer[xLoc][yLoc].backColorComponents[1]
				|| backBlue		!= displayBuffer[xLoc][yLoc].backColorComponents[2]) {

				displayBuffer[xLoc][yLoc].needsUpdate = true;

				displayBuffer[xLoc][yLoc].character = inputChar;
				displayBuffer[xLoc][yLoc].foreColorComponents[0] = foreRed;
				displayBuffer[xLoc][yLoc].foreColorComponents[1] = foreGreen;
				displayBuffer[xLoc][yLoc].foreColorComponents[2] = foreBlue;
				displayBuffer[xLoc][yLoc].backColorComponents[0] = backRed;
				displayBuffer[xLoc][yLoc].backColorComponents[1] = backGreen;
				displayBuffer[xLoc][yLoc].backColorComponents[2] = backBlue;
			}

			restoreRNG;
			//*/
		}


		//-----------
		// ------------------------
		short rand_range( int lower , int upper) {
			return (short)Random.rand_range (lower, upper);
		}
	}
}

