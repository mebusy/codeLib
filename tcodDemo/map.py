
from tile import struct_Tile
import constants
import glob

# .___  ___.      ___      .______   
# |   \/   |     /   \     |   _  \  
# |  \  /  |    /  ^  \    |  |_)  | 
# |  |\/|  |   /  /_\  \   |   ___/  
# |  |  |  |  /  _____  \  |  |      
# |__|  |__| /__/     \__\ | _|      

def map_create():
    new_map = [[struct_Tile(False) for y in xrange(constants.MAP_HEIGHT)] for x in xrange(constants.MAP_WIDTH) ]
    new_map[10][10].block_path = True 
    new_map[10][15].block_path = True 

    # create wall
    for x in xrange( constants.MAP_WIDTH ):
        new_map[x][0].block_path = True
        new_map[x][constants.MAP_HEIGHT-1].block_path = True
    for y in xrange( constants.MAP_HEIGHT):
        new_map[0][y].block_path = True
        new_map[constants.MAP_WIDTH-1][y].block_path = True

    return new_map

def draw_map(map_to_draw):
    for x in xrange( len( map_to_draw ) ):
        for y in xrange( len( map_to_draw[0] ) ):
            if map_to_draw[x][y].block_path is True:
                glob.SURFACE_MAIN.blit( constants.S_WALL , ( x*constants.CELL_WIDTH, y*constants.CELL_HEIGHT ) )
            else:
                glob.SURFACE_MAIN.blit( constants.S_FLOOR , ( x*constants.CELL_WIDTH, y*constants.CELL_HEIGHT ) )
