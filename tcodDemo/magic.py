from map import game_message

def cast_heal(target, value):
    if target.creature.hp ==  target.creature.max_hp:
        game_message ( "{} the {} hp is already full".format( target.creature.name_instance, target.name_object  ) )
        return "canceled"
    else:
        game_message ( "{} the {} heal for {}".format(target.creature.name_instance , target.name_object, value ) )
        target.creature.heal( value )
        return None
    
