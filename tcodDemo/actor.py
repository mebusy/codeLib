import constants
import glob 

class obj_Actor:
    def __init__(self,x,y,sprite ):
        self.x = x 
        self.y = y
        self.sprite  = sprite 

    def draw(self):
        glob.SURFACE_MAIN.blit( self.sprite, ( self.x*constants.CELL_WIDTH, self.y*constants.CELL_HEIGHT ) )

    def move(self, dx, dy) :
        if glob.GAME_MAP[self.x + dx][self.y+dy].block_path is False:
            self.x += dx
            self.y += dy
