import libtcodpy as libtcod
import glob


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
        self.hp -= damage 
        print "{} 's hp is {}/{}".format( self.name_instance,self.hp,self.max_hp )

        if self.hp <= 0:
            if self.death_function :
                self.death_function(self.owner)

    def move(self, dx, dy) :
        tile_is_block = glob.GAME_MAP[self.owner.x + dx][self.owner.y+dy].block_path is True
        target = None

        if not tile_is_block:
            for obj in glob.GAME_OBJECTS:
                if (obj is not self.owner and 
                        obj.x == self.owner.x + dx and 
                        obj.y == self.owner.y + dy and 
                        obj.creature):
                    target = obj
                    break

        if target:
            print self.name_instance , 'attack', target.creature.name_instance, 'for 5 damage'
            target.creature.take_damage(5)
        
        if not tile_is_block and target is None:
            self.owner.x += dx
            self.owner.y += dy


# class com_Item:


# class com_Container:


class com_AI:
    """
    Once per tuen , execute
    """
    def take_turn(self):
        self.owner.creature.move( libtcod.random_get_int(0,-1,1), libtcod.random_get_int(0,-1,1))


def death_monster(monster):
    '''On death, most monsters stop moving '''
    print monster.creature.name_instance , 'is dead!'
    monster.creature = None
    monster.ai = None


