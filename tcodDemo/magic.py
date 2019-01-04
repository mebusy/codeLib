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
    point_select = menu_tile_select( coords_origin = (glob.PLAYER.x , glob.PLAYER.y)  )
    
    # convert that tile into a list of tiles between A->B
    list_of_tiles = map_find_line( (glob.PLAYER.x , glob.PLAYER.y), point_select )

    # cycle through list , damage everything found
    for x,y in list_of_tiles:
        target = map_check_for_creature(x,y)
        if target and target is not glob.PLAYER:
            target.creature.take_damage( damage )


