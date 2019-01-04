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
                    glob.SURFACE_MAIN.blit( glob.ASSETS.S_WALL , ( x*constants.CELL_WIDTH, y*constants.CELL_HEIGHT ) )
                else:
                    glob.SURFACE_MAIN.blit( glob.ASSETS.S_FLOOR , ( x*constants.CELL_WIDTH, y*constants.CELL_HEIGHT ) )
            else:
                if map_to_draw[x][y].explored :
                    if map_to_draw[x][y].block_path is True:
                        glob.SURFACE_MAIN.blit( glob.ASSETS.S_WALLEXPLORED , ( x*constants.CELL_WIDTH, y*constants.CELL_HEIGHT ) )
                    else:
                        glob.SURFACE_MAIN.blit( glob.ASSETS.S_FLOOREXPLORED , ( x*constants.CELL_WIDTH, y*constants.CELL_HEIGHT ) )


def draw_debug():
    draw_text( glob.SURFACE_MAIN , "FPS: {}".format(int(glob.CLOCK.get_fps())) , glob.ASSETS.FONT_DEBUG_MESSAGE, (0,0), constants.COLOR_WHITE , constants.COLOR_BLACK )

def draw_messages():
    text_height  = helper_text_height( glob.ASSETS.FONT_MESSAGE_TEXT )
    start_y = constants.MAP_HEIGHT * constants.CELL_HEIGHT - constants.NUM_MESSAGES * text_height - 4
    for i, (message, color) in enumerate(glob.GAME.message_history[-constants.NUM_MESSAGES:]) :
        draw_text( glob.SURFACE_MAIN, message, glob.ASSETS.FONT_MESSAGE_TEXT, ( 0, start_y + text_height*i ), color, constants.COLOR_BLACK )

def draw_text(display_surface, text_to_display, font , T_coords, text_color , back_color= None ):
    text_surf, text_rect = helper_text_objects(text_to_display ,font , text_color, back_color)

    text_rect.topleft = T_coords 
    display_surface.blit( text_surf, text_rect )


def draw_tile_rect( new_surface, coords ):
    new_surface.fill(constants.COLOR_WHITE)
    glob.SURFACE_MAIN.blit( new_surface , ( coords[0]*constants.CELL_WIDTH, coords[1]*constants.CELL_HEIGHT) ) 




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

def map_objects_at_coords(coords_x, coords_y):
    object_options = [
        obj for obj in glob.GAME.current_objects if obj.x == coords_x  and obj.y == coords_y ]

    return object_options

def map_check_for_creature(coords_x, coords_y):
    object_options = [
        obj for obj in glob.GAME.current_objects  if obj.creature and obj.x == coords_x  and obj.y == coords_y ]

    return len(object_options) > 0 and object_options[0] or None

def map_find_line(coords1, coords2):
    x1,y1 = coords1
    x2,y2 = coords2

    libtcod.line_init(x1,y1, x2,y2)
    calc_x, calc_y = libtcod.line_step()
    coord_list = []
    
    if coords1 == coords2 :
        return [ coords1 ]
    while calc_x is not None :
        coord_list.append( (calc_x, calc_y) )
        if (calc_x, calc_y) == coords2 :
            return coord_list
        calc_x, calc_y = libtcod.line_step()



def game_message( game_msg , msg_color = constants.COLOR_GREY ):
    glob.GAME.message_history.append( (game_msg , msg_color) )


