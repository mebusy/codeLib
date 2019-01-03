import pygame
from spriteSheet import obj_Spritesheet 

class struct_Assets:
    def __init__(self):
        tempspritesheet = obj_Spritesheet("data/s.png")
        self.A_PLAYER = tempspritesheet.get_animation( 0,8, 32,32, 3 )
        self.A_ENEMY =  tempspritesheet.get_animation( 0,12, 32,32, 3 ) 

        self.S_WALL = pygame.image.load( 'data/wall.png' )
        self.S_WALLEXPLORED = pygame.image.load( 'data/wallunseen.png' )
        self.S_FLOOR = pygame.image.load( 'data/floor.png' )
        self.S_FLOOREXPLORED = pygame.image.load( 'data/floorunseen.png' )

        self.FONT_DEBUG_MESSAGE = pygame.font.Font( None,16 )
        self.FONT_MESSAGE_TEXT = pygame.font.Font( None,16 )
        
