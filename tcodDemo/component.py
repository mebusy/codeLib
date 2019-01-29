import libtcodpy as libtcod
import glob
from map import game_message
import constants


class com_Creatures:
    '''
    Creatures have health, and can damage other objects by attacking them. Can also die
    '''
    def __init__(self,name_instance, hp=10, death_function = None ):
        self.name_instance = name_instance 
        self.hp = hp
        self.max_hp = hp
        self.death_function = death_function

    def take_damage(self, damage):
        self.hp = max( self.hp-damage , 0) 
        game_message( "{} 's hp is {}/{}".format( self.name_instance,self.hp,self.max_hp ) , constants.COLOR_WHITE ) 

        if self.hp <= 0:
            if self.death_function :
                self.death_function(self.owner)

    def heal( self, value ):
        self.hp = min( self.hp + value , self.max_hp )
        

    def move(self, dx, dy , moveManually = False ) :
        if moveManually and self.owner == glob.PLAYER and self.owner.ai is not None:
            return  

        tile_is_block = glob.GAME.current_map[self.owner.x + dx][self.owner.y+dy].block_path is True
        target = None

        if not tile_is_block:
            for obj in glob.GAME.current_objects:
                if (obj is not self.owner and 
                        obj.x == self.owner.x + dx and 
                        obj.y == self.owner.y + dy and 
                        obj.creature):
                    target = obj
                    break

        if target:
            self.attack(target, 5)
        
        if not tile_is_block and target is None:
            self.owner.x += dx
            self.owner.y += dy

    def attack(self, target , damage ):
        game_message( '{} attack {} for {} damage'.format(self.name_instance , target.creature.name_instance,damage) , constants.COLOR_RED )
        target.creature.take_damage( damage )


# class com_Item:


# class com_Container:


class com_AI:
    """
    Once per tuen , execute
    """
    def take_turn(self):
        self.owner.creature.move( libtcod.random_get_int(0,-1,1), libtcod.random_get_int(0,-1,1))

class ai_Confuse:
    def __init__(self, old_ai, num_turns):
        self.old_ai  = old_ai 
        self.num_turns = num_turns

    def take_turn(self):
        if self.num_turns > 0:
            self.owner.creature.move( libtcod.random_get_int(0,-1,1), libtcod.random_get_int(0,-1,1))
            self.num_turns -= 1
        else:
            self.owner.ai = self.old_ai
            game_message( "The creature has broken free!" , constants.COLOR_RED )

class ai_Chase:
    def take_turn(self):
        monster = self.owner
        if libtcod.map_is_in_fov( glob.FOV_MAP, monster.x, monster.y ):
            monster.move_towards( glob.PLAYER )


    


def death_monster(monster):
    '''On death, most monsters stop moving '''
    game_message(  monster.creature.name_instance + ' is dead!' , constants.COLOR_GREY ) 
    monster.creature = None
    monster.ai = None

class com_Container():
    def __init__(self, volume = 10.0, inventory = None):
        self.inventory = inventory or []
        self.max_volume = volume

    @property
    def volume(self):
        return sum( [ obj.item.volume for obj in self.inventory ] )

class com_Item:
    def __init__(self, weight = 0.0, volume = 0.0, use_function = None, value = None):
        self.weight = weight
        self.volume = volume
        self.use_function = use_function 
        self.value = value 

    def pick_up( self, actor ):
        if actor.container:
            if actor.container.volume + self.volume > actor.container.max_volume :
                game_message( "Inventory is full" )
            else:
                game_message( "Picking up" )
                actor.container.inventory.append(self.owner)
                glob.GAME.current_objects.remove(self.owner)
                self.current_container = actor.container
        
    def drop(self ):
        glob.GAME.current_objects.append(self.owner)
        self.current_container.inventory.remove( self.owner )
        self.owner.x = self.current_container.owner.x 
        self.owner.y = self.current_container.owner.y 
        game_message("Item dropped")


    def use(self):
        if self.use_function:
            result = self.use_function(self.current_container.owner, self.value )
            if result is None:
                self.current_container.inventory.remove(self.owner)
            else:
                print "use_function failed"
                    
        

