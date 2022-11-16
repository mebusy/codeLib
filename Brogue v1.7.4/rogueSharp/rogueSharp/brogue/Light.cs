using System;

namespace rogueSharp
{
	public class Light : Singleton<Light>
	{
		


		const short STATUS_DARKNESS = (short)statusEffects.STATUS_DARKNESS;

		// sets miner's light strength and characteristics based on rings of illumination, scrolls of darkness and water submersion
		public void updateMinersLightRadius() {
			playerCharacter rogue = RogueMain.GetInstance ().getRogue ();
			creature player = RogueMain.GetInstance ().getPlayer ();

			double fraction;
			double lightRadius;

			lightRadius = 100 * rogue.minersLightRadius;

			if (rogue.lightMultiplier < 0) {
				lightRadius /= (-1 * rogue.lightMultiplier + 1);
			} else {
				lightRadius *= (rogue.lightMultiplier);
				lightRadius = Math.Max(lightRadius, (rogue.lightMultiplier * 2 + 2));
			}

			if (player.status[STATUS_DARKNESS] != 0 ) {
				fraction = (double) Math.Pow(1.0 - (((double) player.status[STATUS_DARKNESS]) / player.maxStatus[STATUS_DARKNESS]), 3);
				if (fraction < 0.05) {
					fraction = 0.05;
				}
			} else {
				fraction = 1;
			}
			lightRadius = lightRadius * fraction;

			if (lightRadius < 2) {
				lightRadius = 2;
			}

			if (rogue.inWater && lightRadius > 3) {
				lightRadius = Math.Max(lightRadius / 2, 3);
			}

			rogue.minersLight.radialFadeToPercent = (short)( 35 + Math.Max(0, Math.Min(65, rogue.lightMultiplier * 5)) * (fraction + RogueH.FLOAT_FUDGE) );

			rogue.minersLight.lightRadius.upperBound = rogue.minersLight.lightRadius.lowerBound = (short) Random.clamp(lightRadius + RogueH.FLOAT_FUDGE, -30000, 30000);
		}

	}
}

