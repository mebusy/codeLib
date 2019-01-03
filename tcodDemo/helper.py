# import constants 
import glob

def helper_text_objects(incoming_text, incoming_color, incoming_bg):

    if incoming_bg:
        Text_surface = glob.ASSETS.FONT_DEBUG_MESSAGE.render(incoming_text, True, incoming_color, incoming_bg )
    else:
        Text_surface = glob.ASSETS.FONT_DEBUG_MESSAGE.render(incoming_text, True, incoming_color)

    return Text_surface, Text_surface.get_rect()

def helper_text_height(font):
    font_object = font.render('a', False, (0,0,0) )
    font_rect = font_object.get_rect()
    return font_rect.height 
    
