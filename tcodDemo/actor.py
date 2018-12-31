import constants
import glob 

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
        glob.SURFACE_MAIN.blit( self.sprite, ( self.x*constants.CELL_WIDTH, self.y*constants.CELL_HEIGHT ) )

