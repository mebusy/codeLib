
import sys
import pygame
# add parent folder as search path
sys.path.append( '/Volumes/WORK/WORK/libtcod-1.10.2-x86.x86_64-macos/python')
import libtcodpy as libtcod

import constants
from tile import struct_Tile
from actor import obj_Actor
import glob
from component import *
from map import *


            

clock = pygame.time.Clock()
font = pygame.font.Font(None, 30)


def draw_game():
    # clear the surface
    glob.SURFACE_MAIN.fill(constants.COLOR_DEFAULT_BG)

    # draw the map
    draw_map( glob.GAME_MAP )

    # draw the character
    for obj in glob.GAME_OBJECTS:
        obj.draw()

    fps = font.render(str(int(clock.get_fps())), True, pygame.Color('white'))
    glob.SURFACE_MAIN.blit(fps, (0, 0))

    # update the display
    pygame.display.flip()
    
    clock.tick(60)




def game_main_loop():
    game_quit = False
    while not game_quit:
        player_action = game_handle_keys()
        
        map_calculate_fov()

        if player_action == "QUIT":
            game_quit = True
        elif player_action != "no-action":
            for obj in glob.GAME_OBJECTS:
                if obj.ai:
                    obj.ai.take_turn()

        # draw the game
        draw_game()


    # quit the game
    pygame.quit()
    exit()


KB_moving = {
    pygame.K_UP: (0,-1),    
    pygame.K_DOWN: (0,1),    
    pygame.K_RIGHT: (1,0),    
    pygame.K_LEFT: (-1,0),    
}
def game_handle_keys():
    # get player input
    event_list = pygame.event.get()

    # process input
    for event in event_list:
        if event.type == pygame.QUIT:
            # game_quit = True
            return "QUIT"
        if event.type == pygame.KEYDOWN:
            if event.key in KB_moving:
                glob.PLAYER.creature.move( *KB_moving[ event.key ] )
                glob.FOV_CALCULATE = True 
                return "player-moved"
    return "no-action"

def game_initialize():
    pygame.init()
    glob.SURFACE_MAIN = pygame.display.set_mode( ( constants.MAP_WIDTH*constants.CELL_WIDTH,
                                                   constants.MAP_HEIGHT*constants.CELL_HEIGHT ) )
    glob.GAME_MAP = map_create()
    glob.FOV_CALCULATE = True

    creature_com = com_Creatures( "greg" )
    glob.PLAYER = obj_Actor(2,2,"python", constants.S_PLAYER, creature= creature_com)

    creature_com = com_Creatures( "jackie", death_function = death_monster )
    ai_com = com_AI()
    glob.ENEMY = obj_Actor(15,15, "crab", constants.S_ENEMY, creature = creature_com, ai=ai_com)
    
    glob.GAME_OBJECTS = [glob.PLAYER, glob.ENEMY]


if __name__ == '__main__':
    game_initialize()
    game_main_loop() 
