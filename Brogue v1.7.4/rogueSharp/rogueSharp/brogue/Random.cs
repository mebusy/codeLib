using System;

namespace rogueSharp
{
	public class Random:Singleton<Random>
	{
		private Random ()
		{
		}

		const short RNG_SUBSTANTIVE = (short)RNGs.RNG_SUBSTANTIVE ;
		const short RNG_COSMETIC =  (short)RNGs.RNG_COSMETIC ;

		static System.Random []RNGState = new System.Random[2];

		public static double clamp(double x, double low, double hi) {
			return Math.Min(hi, Math.Max(x, low)) ;
		}

		public static short randClump(randomRange theRange) {
			return randClumpedRange(theRange.lowerBound, theRange.upperBound, theRange.clumpFactor);
		}

		// Get a random int between lowerBound and upperBound, inclusive, with probability distribution
		// affected by clumpFactor.
		public static short randClumpedRange(short lowerBound, short upperBound, short clumpFactor) {
			if (upperBound <= lowerBound) {
				return lowerBound;
			}
			if (clumpFactor <= 1) {
				return (short)rand_range(lowerBound, upperBound);
			}

			short i, total = 0, numSides = (short)((upperBound - lowerBound) / clumpFactor);

			for(i=0; i < (upperBound - lowerBound) % clumpFactor; i++) {
				total +=  (short)rand_range(0, numSides + 1);
			}

			for(; i< clumpFactor; i++) {
				total +=  (short)rand_range(0, numSides);
			}

			return  (short)(total + lowerBound);
		}

		// Get a random int between lowerBound and upperBound, inclusive
		public static bool rand_percent(short percent) {
			return (rand_range(0, 99) < clamp(percent, 0, 100));

		}


		
		public static int rand_range(int lowerBound, int upperBound) {
			//brogueAssert(lowerBound <= INT_MAX && upperBound <= INT_MAX);
			if (upperBound <= lowerBound) {
				return lowerBound;
			}

			/* nouse
			if (rogue.RNG == RNG_SUBSTANTIVE) {
				randomNumbersGenerated++;
			}
			//*/

			playerCharacter rogue = RogueMain.GetInstance().getRogue ();
			return RNGState [rogue.RNG].Next(lowerBound , upperBound+1  );
		}


		// seeds with the time if called with a parameter of 0; returns the seed regardless.
		// All RNGs are seeded simultaneously and identically.

		public static ulong ConvertToUnixTimestamp(DateTime date)
		{
			DateTime origin = new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
			TimeSpan diff = date.ToUniversalTime() - origin;
			return (ulong)Math.Floor(diff.TotalSeconds);
		}

		public static ulong seedRandomGenerator( ulong seed) {

			if (seed == 0) {
				seed = ConvertToUnixTimestamp ( DateTime.Now );
			}

			RNGState [RNG_SUBSTANTIVE] = new System.Random ( (int)seed );
			RNGState [RNG_COSMETIC] = new System.Random ( (int)seed );

			return seed;
		}

		public static void fillSequentialList(short[] list, short listLength) {
			short i;
			for (i=0; i<listLength; i++) {
				list[i] = i;
			}
		}

		public static void shuffleList(short[] list, short listLength) {
			short i, r, buf;
			for (i=0; i<listLength; i++) {
				r = (short)rand_range(0, listLength-1);
				if (i != r) {
					buf = list[r];
					list[r] = list[i];
					list[i] = buf;
				}
			}
		}


	}


}

