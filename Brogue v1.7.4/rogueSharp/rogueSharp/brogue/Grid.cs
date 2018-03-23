using System;

namespace rogueSharp
{
	public class Grid : Singleton<Grid>
	{
		private Grid ()
		{
		}

		const int DCOLS = RogueH.DCOLS ;
		const int DROWS = RogueH.DROWS ;
		const short RNG_SUBSTANTIVE = (short)RNGs.RNG_SUBSTANTIVE ;
		const short RNG_COSMETIC =  (short)RNGs.RNG_COSMETIC ;

		static short[,] nbDirs  =  Global .nbDirs ; 
		static short[,] cDirs   =  Global .cDirs ; 


		cellDisplayBuffer[,] displayBuffer = Global. displayBuffer ;

		public static short[][] allocGrid(  ) {
			short[][] array = new short[DCOLS][];

			for (int j = 0; j < array.Length; j++) {
				short[] l =  new short[DROWS];
//				for (int i = 0; i < l.Length; i++)
//					l[i] = 0;

				array [j] = l;
			}

			return array;
		}

		public static void freeGrid(short[][] array) {

			//free(array[0]);
			//free(array);

			short i ;

			for(i = 0; i < DCOLS; i++) {
				array [i] = null;
			}

		}

		public static void fillGrid(short[][] grid, short fillValue) {
			short i, j;

			for(i = 0; i < DCOLS; i++) {
				for(j = 0; j < DROWS; j++) {
					grid[i][j] = fillValue;
				}
			}
		} // 


		// Highlight the portion indicated by hiliteCharGrid with the hiliteColor at the hiliteStrength -- both latter arguments are optional.
		public void hiliteGrid(short[][] grid, color hiliteColor, int hiliteStrength) {
			playerCharacter rogue = RogueMain.GetInstance().getRogue(); 

			short i, j, x, y;
			color hCol = new color();

			short oldRNG = rogue.RNG; rogue.RNG = RNG_COSMETIC; //assureCosmeticRNG;

			if (hiliteColor!= null) {
				ObjectCopier.CopyFrom( hCol , hiliteColor );
			} else {
				ObjectCopier.CopyFrom( hCol , Global.yellow );
			}

			IO.GetInstance().bakeColor(hCol);

			if (hiliteStrength==0) {
				hiliteStrength = 75;
			}

			for (i=0; i<DCOLS; i++) {
				for (j=0; j<DROWS; j++) {
					if (grid[i][j] != 0 ) {
						x = (short)IO.GetInstance().mapToWindowX(i);
						y = (short)IO.GetInstance().mapToWindowY(j);

						displayBuffer[x,y].needsUpdate = true;
						displayBuffer[x,y].backColorComponents[0] = (char)Random.clamp(displayBuffer[x,y].backColorComponents[0] + hCol.red * hiliteStrength / 100, 0, 100);
						displayBuffer[x,y].backColorComponents[1] = (char)Random.clamp(displayBuffer[x,y].backColorComponents[1] + hCol.green * hiliteStrength / 100, 0, 100);
						displayBuffer[x,y].backColorComponents[2] = (char)Random.clamp(displayBuffer[x,y].backColorComponents[2] + hCol.blue * hiliteStrength / 100, 0, 100);
						displayBuffer[x,y].foreColorComponents[0] = (char)Random.clamp(displayBuffer[x,y].foreColorComponents[0] + hCol.red * hiliteStrength / 100, 0, 100);
						displayBuffer[x,y].foreColorComponents[1] = (char)Random.clamp(displayBuffer[x,y].foreColorComponents[1] + hCol.green * hiliteStrength / 100, 0, 100);
						displayBuffer[x,y].foreColorComponents[2] = (char)Random.clamp(displayBuffer[x,y].foreColorComponents[2] + hCol.blue * hiliteStrength / 100, 0, 100);
					}
				}
			}
			rogue.RNG = oldRNG; //restoreRNG;
		}

		public static void drawRectangleOnGrid(short [][]grid, int x, int y, int width, int height, short value) {
			int i, j;

			for (i=x; i < x+width; i++) {
				for (j=y; j<y+height; j++) {
					grid[i][j] = value;
				}
			}
		}

		public static void drawCircleOnGrid(short[][] grid, int x, int y, int radius, short value) {
			int i, j;

			for (i=Math.Max(0, x - radius - 1); i < Math.Max(DCOLS, x + radius); i++) {
				for (j=Math.Max(0, y - radius - 1); j < Math.Max(DROWS, y + radius); j++) {
					if ((i-x)*(i-x) + (j-y)*(j-y) < radius * radius + radius) {
						grid[i][j] = value;
					}
				}
			}
		}

		public static void copyGrid(short[][] to, short[][] from) {
			short i, j;

			for(i = 0; i < DCOLS; i++) {
				for(j = 0; j < DROWS; j++) {
					to[i][j] = from[i][j];
				}
			}
		}


		// Marks a cell as being a member of blobNumber, then recursively iterates through the rest of the blob
		public static short fillContiguousRegion(short[][] grid, short x, short y, short fillValue) {
			/*directions*/ int dir;
			short newX, newY, numberOfCells = 1;

			grid[x][y] = fillValue;

			// Iterate through the four cardinal neighbors.
			for (dir=0; dir<4; dir++) {
				newX = (short)(x + nbDirs[dir,0]);
				newY = (short)(y + nbDirs[dir,1]);

				if (!IO.GetInstance().coordinatesAreInMap(newX, newY)) {
					break;
				}
				if (grid[newX][newY] == 1) { // If the neighbor is an unmarked region cell,
					numberOfCells += fillContiguousRegion(grid, newX, newY, fillValue); // then recurse.
				}
			}
			return numberOfCells;
		}



		static short validLocationCount(short[][] grid, short validValue) {
			short i, j, count;
			count = 0;
			for(i = 0; i < DCOLS; i++) {
				for(j = 0; j < DROWS; j++) {
					if (grid[i][j] == validValue) {
						count++;
					}
				}
			}
			return count;
		}

		// Takes a grid as a mask of valid locations, chooses one randomly and returns it as (x, y).
		// If there are no valid locations, returns (-1, -1).
		public static void randomLocationInGrid(short[][] grid, out short x, out short y, short validValue) {
			short locationCount = validLocationCount(grid, validValue);
			short i, j;

			//qibinyi, ensure assign value before return 
			x = y = -1;

			if (locationCount <= 0) {
				x = y = -1;
				return;
			}
			short index = rand_range(0, locationCount - 1);
			for(i = 0; i < DCOLS && index >= 0; i++) {
				for(j = 0; j < DROWS && index >= 0; j++) {
					if (grid[i][j] == validValue) {
						if (index == 0) {
							x = i;
							y = j;
						}
						index--;
					}
				}
			}
			return;
		}

		public static void findReplaceGrid(short[][] grid, int findValueMin, int findValueMax, short fillValue) {
			short i, j;

			for(i = 0; i < DCOLS; i++) {
				for(j = 0; j < DROWS; j++) {
					if (grid[i][j] >= findValueMin && grid[i][j] <= findValueMax) {
						grid[i][j] = fillValue;
					}
				}
			}
		}

		//-------------

		static short rand_range( int lower , int upper) {
			return (short)Random.rand_range (lower, upper);
		}

	} // end class 
}

