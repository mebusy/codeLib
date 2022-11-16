
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
from helper import *
from game import obj_Game 
from spriteSheet import obj_Spritesheet
from assets import struct_Assets
from menu import *
from magic import *


            



def draw_game():
    # clear the surface
    glob.SURFACE_MAIN.fill(constants.COLOR_DEFAULT_BG)

    # draw the map
    draw_map( glob.GAME.current_map )

    # draw the character
    for obj in glob.GAME.current_objects:
        obj.draw()

    draw_debug()
    draw_messages()
    

glob.DRAW_GAME = draw_game



def game_main_loop():
    game_quit = False
    while not game_quit:
        player_action = game_handle_keys()
        
        map_calculate_fov()

        if player_action == "QUIT":
            game_quit = True
        elif player_action != "no-action":
            for obj in glob.GAME.current_objects:
                if obj.ai:
                    obj.ai.take_turn()

        # draw the game
        draw_game()
        # update the display
        pygame.display.flip()

        glob.CLOCK.tick(constants.FPS)


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
                glob.PLAYER.creature.move( *KB_moving[ event.key ] , moveManually = True )
                glob.FOV_CALCULATE = True 
                return "player-moved"
            if event.key == pygame.K_g:
                objects_at_player = map_objects_at_coords( glob.PLAYER.x , glob.PLAYER.y  )
                for obj in objects_at_player:
                    if obj.item:
                        obj.item.pick_up(glob.PLAYER)
            if event.key == pygame.K_d:
                if len(glob.PLAYER.container.inventory) > 0:
                    glob.PLAYER.container.inventory[-1].item.drop()
            if event.key == pygame.K_p:
                menu_pause()
            if event.key == pygame.K_i:
                menu_inventory()
            if event.key == pygame.K_l:
                cast_lightning(10)
            if event.key == pygame.K_f:
                cast_fireball()
            if event.key == pygame.K_c:
                cast_confusion()

            

    return "no-action"

    

def game_initialize():
    pygame.init()
    pygame.key.set_repeat(200, 70)

    glob.CLOCK = pygame.time.Clock()

    glob.SURFACE_MAIN = pygame.display.set_mode( ( constants.MAP_WIDTH*constants.CELL_WIDTH,
                                                   constants.MAP_HEIGHT*constants.CELL_HEIGHT ) )
    glob.GAME = obj_Game()

    glob.FOV_CALCULATE = True

    glob.ASSETS = struct_Assets()

    container_com = com_Container()
    creature_com = com_Creatures( "greg" )
    glob.PLAYER = obj_Actor(2,2,"python", glob.ASSETS.A_PLAYER, animation_speed = 1, creature= creature_com,container = container_com)

    item_com = com_Item( value =10 , use_function = cast_heal) 
    creature_com = com_Creatures( "jackie", death_function = death_monster )
    ai_com = ai_Chase()
    glob.ENEMY = obj_Actor(15,15, "smart crab", glob.ASSETS.A_ENEMY,  creature = creature_com, ai=ai_com,item = item_com)

    item_com = com_Item(  value =10 , use_function = cast_heal ) 
    creature_com = com_Creatures( "bob", death_function = death_monster )
    ai_com = ai_Chase()
    DUP_ENEMY = obj_Actor(14,15, "dup crab", glob.ASSETS.A_ENEMY,  creature = creature_com, ai=ai_com,item = item_com)
    
    glob.GAME.current_objects = [glob.PLAYER, glob.ENEMY, DUP_ENEMY]


if __name__ == '__main__':
    game_initialize()
    game_main_loop() 
