import pygame
from spriteSheet import obj_Spritesheet 
import constants

class struct_Assets:
    def __init__(self):
        tempspritesheet = obj_Spritesheet("data/s.png")
        self.A_PLAYER = tempspritesheet.get_animation( 0,8, 32,32, 3 )
        self.A_ENEMY =  tempspritesheet.get_animation( 0,12, 32,32, 3 ) 

        self.S_WALL =  tempspritesheet.get_image( 8,0, 32,32 ) 
        self.S_WALLEXPLORED = tempspritesheet.get_image( 12,0, 32,32 )
        self.S_FLOOR = tempspritesheet.get_image( 11,4, 32,32 )
        self.S_FLOOREXPLORED = pygame.image.load( 'data/floorunseen.png' )

        self.FONT_DEBUG_MESSAGE = pygame.font.Font( None,16 )
        self.FONT_MESSAGE_TEXT = pygame.font.Font( None,16 )
        self.FONT_CURSOR_TEXT = pygame.font.Font( None, constants.CELL_HEIGHT*2 )
        
