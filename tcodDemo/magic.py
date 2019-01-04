from map import *
from menu import *

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



