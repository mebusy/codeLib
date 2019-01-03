import pygame
from map import draw_text
import constants
import glob
from helper import *

def menu_pause():
    menu_close = False

    while not menu_close:
        event_list = pygame.event.get()
        for event in event_list:
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_p:
                    menu_close = True

        draw_text( 
            glob.SURFACE_MAIN, 'PAUSED' , glob.ASSETS.FONT_DEBUG_MESSAGE, 
            ( constants.MAP_WIDTH*constants.CELL_WIDTH/2, constants.MAP_HEIGHT*constants.CELL_HEIGHT/2) ,
            constants.COLOR_WHITE , constants.COLOR_BLACK )
        
        pygame.display.flip()


def menu_inventory():
    menu_close = False

    menu_width = 200
    menu_height = 200 

    menu_text_font = glob.ASSETS.FONT_MESSAGE_TEXT

    local_inventory_surface = pygame.Surface( (menu_width, menu_height) ) 

    while not menu_close:
        local_inventory_surface.fill(constants.COLOR_BLACK )

        print_list = [obj.name_object for obj in glob.PLAYER.container.inventory]

        event_list = pygame.event.get()
        for event in event_list:
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_i:
                    menu_close = True

        # Draw list 
        text_height  = helper_text_height(menu_text_font)
        for i, name in enumerate(print_list):
            draw_text( 
                local_inventory_surface, name, menu_text_font ,
                ( 0, text_height*i ), constants.COLOR_WHITE, constants.COLOR_BLACK )


        # draw
        glob.SURFACE_MAIN.blit(
            local_inventory_surface , 
            ( constants.MAP_WIDTH*constants.CELL_WIDTH/2 - menu_width/2 , constants.MAP_HEIGHT*constants.CELL_HEIGHT/2 - menu_height/2 )  )

        pygame.display.update()
