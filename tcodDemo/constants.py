import pygame
pygame.init()

# MAP
MAP_WIDTH = 20
MAP_HEIGHT = 20
CELL_WIDTH = 32
CELL_HEIGHT = 32

# Color definitions
COLOR_BLACK = (0,0,0)
COLOR_WHITE = (255,255,255)
COLOR_GRAY = (100,100,100)

COLOR_DEFAULT_BG = COLOR_GRAY

# SPRITES
S_PLAYER = pygame.image.load( 'data/python.png' )
S_ENEMY = pygame.image.load( 'data/crab.png' )
S_WALL = pygame.image.load( 'data/wall.png' )
S_FLOOR = pygame.image.load( 'data/floor.png' )
