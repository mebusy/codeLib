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
        glob.CLOCK.tick(constants.FPS)


def menu_inventory():
    menu_close = False

    menu_width = 200
    menu_height = 200 
    menu_x, menu_y = constants.MAP_WIDTH*constants.CELL_WIDTH/2 - menu_width/2 , constants.MAP_HEIGHT*constants.CELL_HEIGHT/2 - menu_height/2 

    menu_text_font = glob.ASSETS.FONT_MESSAGE_TEXT
    menu_text_height  = helper_text_height(menu_text_font)

    local_inventory_surface = pygame.Surface( (menu_width, menu_height) ) 

    while not menu_close:
        local_inventory_surface.fill(constants.COLOR_BLACK )

        print_list = [obj.name_object for obj in glob.PLAYER.container.inventory]

        event_list = pygame.event.get()
        mouse_x, mouse_y = pygame.mouse.get_pos()
        mouse_x_rel = mouse_x - menu_x
        mouse_y_rel = mouse_y - menu_y
        mouse_in_menu = mouse_x_rel > 0 and mouse_y_rel > 0 and mouse_x_rel < menu_width and mouse_y_rel < menu_height
        mouse_line_selection = mouse_y_rel / menu_text_height

        for event in event_list:
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_i:
                    menu_close = True
            if event.type == pygame.MOUSEBUTTONDOWN:
                if event.button == 1 :
                    if mouse_in_menu and mouse_line_selection < len(print_list):
                        glob.PLAYER.container.inventory[mouse_line_selection].item.use()

        # Draw list 
        for line, name in enumerate(print_list):

            draw_text( 
                local_inventory_surface, name, menu_text_font ,
                ( 0, menu_text_height*line ), constants.COLOR_WHITE, (line == mouse_line_selection and mouse_in_menu) and constants.COLOR_GREY or constants.COLOR_BLACK )


        # draw
        glob.SURFACE_MAIN.blit(
            local_inventory_surface , 
            (menu_x, menu_y)  )

        pygame.display.update()
        glob.CLOCK.tick(constants.FPS)
