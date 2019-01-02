# pygame.init()
import constants
import pygame

class obj_Spritesheet:
    def __init__(self, file_name ):
        self.sprite_sheet = pygame.image.load( file_name ).convert( )

    def get_image(self, column, row, width = constants.CELL_WIDTH, height = constants.CELL_HEIGHT, scale = None ):
        '''scale is a tuple'''
        
        image = pygame.Surface( [width, height] ).convert()
        image.blit(self.sprite_sheet , (0,0) , (column*width, row*height, width, height)   )
        image.set_colorkey(constants.COLOR_BLACK )
        if scale :
            image = pygame.transform.scale( image, scale )

        return ( image )


    def get_animation(self, column, row, width = constants.CELL_WIDTH, height = constants.CELL_HEIGHT, num_sprites = 1, scale = None ):
        '''scale is a tuple'''
        
        image_list = []
        for i in xrange( num_sprites ) :
            image = pygame.Surface( [width, height] ).convert()
            image.blit(self.sprite_sheet , (0,0) , ( (column+i)*width, row*height, width, height)   )
            image.set_colorkey(constants.COLOR_BLACK )
            if scale :
                image = pygame.transform.scale( image, scale )

            image_list.append( image )

        return image_list
