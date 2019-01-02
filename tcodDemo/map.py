
from tile import struct_Tile
import constants
import glob
import libtcodpy as libtcod
from helper import *

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

    map_make_fov(new_map)

    return new_map

def draw_map(map_to_draw):
    for x in xrange( len( map_to_draw ) ):
        for y in xrange( len( map_to_draw[0] ) ):
            # fov
            is_visible = libtcod.map_is_in_fov( glob.FOV_MAP , x, y  )
            if is_visible:
                
                map_to_draw[x][y].explored = True

                if map_to_draw[x][y].block_path is True:
                    glob.SURFACE_MAIN.blit( constants.S_WALL , ( x*constants.CELL_WIDTH, y*constants.CELL_HEIGHT ) )
                else:
                    glob.SURFACE_MAIN.blit( constants.S_FLOOR , ( x*constants.CELL_WIDTH, y*constants.CELL_HEIGHT ) )
            else:
                if map_to_draw[x][y].explored :
                    if map_to_draw[x][y].block_path is True:
                        glob.SURFACE_MAIN.blit( constants.S_WALLEXPLORED , ( x*constants.CELL_WIDTH, y*constants.CELL_HEIGHT ) )
                    else:
                        glob.SURFACE_MAIN.blit( constants.S_FLOOREXPLORED , ( x*constants.CELL_WIDTH, y*constants.CELL_HEIGHT ) )


def draw_debug():
    draw_text( glob.SURFACE_MAIN , str(int(glob.CLOCK.get_fps())) , (0,0), constants.COLOR_RED )

def draw_text(display_surface, text_to_display, T_coords, text_color ):
    text_surf, text_rect = helper_text_objects(text_to_display , text_color)

    text_rect.topleft = T_coords 
    display_surface.blit( text_surf, text_rect )


def map_make_fov( incoming_map ):
    '''
    actually create the map that we can use to calculate what the fov is 
    '''
    
    glob.FOV_MAP = libtcod.map_new( constants.MAP_WIDTH, constants.MAP_HEIGHT )
    for y in xrange(constants.MAP_HEIGHT):
        for x in xrange(constants.MAP_WIDTH):
            # (map,x,y, isTransparet, isWalkable)
            libtcod.map_set_properties( 
                glob.FOV_MAP, x, y , 
                not incoming_map[x][y].block_path , not incoming_map[x][y].block_path )



def map_calculate_fov():
    if glob.FOV_CALCULATE:
        glob.FOV_CALCULATE = False 
        libtcod.map_compute_fov( 
            glob.FOV_MAP , glob.PLAYER.x , glob.PLAYER.y , constants.TORCH_RADIUS , constants.FOV_LIGHT_WALLS, 
            constants.FOV_ALGO )
