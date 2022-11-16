from map import *
from menu import *
from component import *
import constants 

def cast_heal(target, value):
    if target.creature.hp ==  target.creature.max_hp:
        game_message ( "{} the {} hp is already full".format( target.creature.name_instance, target.name_object  ) )
        return "canceled"
    else:
        game_message ( "{} the {} heal for {}".format(target.creature.name_instance , target.name_object, value ) )
        target.creature.heal( value )
        return None
    

def cast_lightning(damage):
    # prompt the player for a tile
    list_of_tiles = menu_tile_select( coords_origin = (glob.PLAYER.x , glob.PLAYER.y) , max_range= 5, penetrate_walls = False )
    
    # cycle through list , damage everything found
    for x,y in list_of_tiles:
        target = map_check_for_creature(x,y)
        if target and target is not glob.PLAYER:
            target.creature.take_damage( damage )


def cast_fireball():
    damage = 5
    radius = 1
    max_r = 4

    list_of_tiles = menu_tile_select( 
        coords_origin = (glob.PLAYER.x , glob.PLAYER.y) , 
        max_range=max_r, penetrate_walls = False, pierce_creature=False,radius=radius  )
    tiles_to_damage = map_find_radius( list_of_tiles[-1], radius )
    creature_hit = False 
    for x,y in tiles_to_damage:
        obj = map_check_for_creature(x,y)
        if obj and obj is not glob.PLAYER :
            obj.creature.take_damage( damage )
            creature_hit = True

    if creature_hit:
        game_message( "The monster howls out in pain.", constants.COLOR_RED )


def cast_confusion():
    list_of_tiles = menu_tile_select()

    if list_of_tiles and len(list_of_tiles) > 0 :
        tile_x , tile_y =  list_of_tiles[0]
        target = map_check_for_creature(tile_x, tile_y)
    
        # temporarily confuse the target
        if target:
            oldai = target.ai
            target.ai = ai_Confuse( old_ai = oldai , num_turns = 5 )
            target.ai.owner = target 

            game_message( "The creature's eye glaze over" , constants.COLOR_GREEN) 
