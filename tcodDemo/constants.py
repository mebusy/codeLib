import pygame
pygame.init()

GAME_WIDTH = 800
GAME_HEIGHT = 600

# MAP
MAP_WIDTH = 30
MAP_HEIGHT = 30
CELL_WIDTH = 32
CELL_HEIGHT = 32

# Color definitions
COLOR_BLACK = (0,0,0)
COLOR_WHITE = (255,255,255)
COLOR_GRAY = (100,100,100)

COLOR_DEFAULT_BG = COLOR_GRAY

# SPRITES
S_PLAYER = pygame.image.load( 'data/python.png' )
S_WALL = pygame.image.load( 'data/wall.png' )
S_FLOOR = pygame.image.load( 'data/floor.png' )
