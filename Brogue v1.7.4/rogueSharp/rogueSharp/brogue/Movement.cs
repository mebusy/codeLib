using System;

namespace rogueSharp
{
	public class Movement : Singleton<Movement>
	{
		tcell[,] tmap = Global .tmap ;						// grids with info about the map
		pcell[,] pmap = Global  .pmap  ;


		floorTileType[] tileCatalog = Global.GetInstance().tileCatalog ;

		public void updateFieldOfViewDisplay(bool updateDancingTerrain, bool refreshDisplay) {
			Debug.Log ( "TODO~~~ updateFieldOfViewDisplay " );
		}

		public void storeMemories(  short x,   short y) {
			pmap[x,y].rememberedTerrainFlags = MyTerrain.GetInstance().terrainFlags(x, y);
			pmap[x,y].rememberedTMFlags = MyTerrain.GetInstance().terrainMechFlags(x, y);
			pmap[x,y].rememberedCellFlags = pmap[x,y].flags;
			pmap[x,y].rememberedTerrain = pmap[x,y].layers[ (int)highestPriorityLayer(x, y, false)];
		}


		dungeonLayers highestPriorityLayer(short x, short y, bool  skipGas) {
			short bestPriority = 10000;
			dungeonLayers tt = dungeonLayers.NO_LAYER, best = dungeonLayers.NO_LAYER;

			for (tt = 0; tt < dungeonLayers.NUMBER_TERRAIN_LAYERS; tt++) {
				if (tt == dungeonLayers.GAS && skipGas) {
					continue;
				}
				if (pmap[x,y].layers[(int)tt]!=0 && tileCatalog[(int)pmap[x,y].layers[(int)tt]].drawPriority < bestPriority) {
					bestPriority = tileCatalog[(int)pmap[x,y].layers[(int)tt]].drawPriority;
					best = tt;
				}
			}
			return best;
		}



	}
}

