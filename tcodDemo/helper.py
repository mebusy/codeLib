# import constants 
# import glob

def helper_text_objects(incoming_text,font, incoming_color, incoming_bg):
    
    Text_surface = font.render(incoming_text, True, incoming_color, incoming_bg )

    return Text_surface, Text_surface.get_rect()

def helper_text_height(font):
    font_object = font.render('a', False, (0,0,0) )
    font_rect = font_object.get_rect()
    return font_rect.height 

def helper_text_width(font):
    font_object = font.render('a', False, (0,0,0) )
    font_rect = font_object.get_rect()
    return font_rect.width 
    
