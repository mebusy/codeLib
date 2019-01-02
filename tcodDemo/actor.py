import constants
import glob 
import libtcodpy as libtcod

class obj_Actor:
    def __init__(self,x,y, name_object, sprite, creature= None, ai = None):
        self.x = x 
        self.y = y
        self.sprite  = sprite 

        self.creature = creature 
        if creature:
            self.creature.owner = self

        self.ai = ai
        if ai:
            self.ai.owner = self

    def draw(self):
        is_visible = libtcod.map_is_in_fov( glob.FOV_MAP , self.x, self.y  )
        if is_visible:
            glob.SURFACE_MAIN.blit( self.sprite, ( self.x*constants.CELL_WIDTH, self.y*constants.CELL_HEIGHT ) )

