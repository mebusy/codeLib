import constants
import glob 
import libtcodpy as libtcod
import math

class obj_Actor:
    def __init__(
            self,x,y, name_object, animation,animation_speed = .5 ,  
            creature= None, ai = None, container =None, item = None):
        self.x = x 
        self.y = y
        self.name_object = name_object
        # self.sprite  = sprite 
        self.animation = animation
        self.animation_speed = animation_speed * 1.0  # in seconds
        self.flicker = self.animation_speed /  len(self.animation) 
        self.flicker_timer = 0 

        self.creature = creature 
        if creature:
            self.creature.owner = self

        self.ai = ai
        if ai:
            self.ai.owner = self

        self.container = container 
        if self.container:
            self.container.owner = self

        self.item = item 
        if self.item :
            self.item.owner = self 

    def draw(self):
        is_visible = libtcod.map_is_in_fov( glob.FOV_MAP , self.x, self.y  )
        if is_visible:
            if len(self.animation) == 1:
                glob.SURFACE_MAIN.blit( self.animation[0], ( self.x*constants.CELL_WIDTH, self.y*constants.CELL_HEIGHT ) )
            elif len(self.animation) > 1:
                fps = glob.CLOCK.get_fps()
                if fps > 0.0:
                    self.flicker_timer += 1.0 / fps 

                frame = int(self.flicker_timer/self.flicker) % len(self.animation) 
                glob.SURFACE_MAIN.blit( self.animation[frame], ( self.x*constants.CELL_WIDTH, self.y*constants.CELL_HEIGHT ) )

    def distance_to(self,other):
        dx = other.x - self.x 
        dy = other.y - self.y
        return math.sqrt( dx**2 + dy**2 )                

    def move_towards(self, other):
        dx = other.x - self.x 
        dy = other.y - self.y
        dist =  math.sqrt( dx**2 + dy**2 )                

        self.creature.move( int(round( dx/dist )) , int(round( dy/dist ))  )
        

